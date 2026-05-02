import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/lost_found_service.dart';
import '../../services/category_service.dart';
import 'lost_found_list_event.dart';
import 'lost_found_list_state.dart';

class LostFoundListBloc extends Bloc<LostFoundListEvent, LostFoundListState> {
  final LostFoundService _lostFoundService;
  final CategoryService _categoryService;
  Timer? _debounceTimer;

  LostFoundListBloc({
    required LostFoundService lostFoundService,
    required CategoryService categoryService,
  })  : _lostFoundService = lostFoundService,
        _categoryService = categoryService,
        super(const LostFoundListState.initial()) {
    on<ListLoadList>(_onLoadList);
    on<ListSearchChanged>(_onSearchChanged);
    on<ListFilterChanged>(_onFilterChanged);
    on<ListLoadMore>(_onLoadMore);
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }

  Future<void> _onLoadList(
      ListLoadList event, Emitter<LostFoundListState> emit) async {
    emit(const LostFoundListState.loading());
    try {
      final categories = await _categoryService.getList();
      final pageData = await _lostFoundService.list(pageNum: 1);
      emit(LostFoundListState.loaded(
        items: pageData.records,
        currentPage: pageData.current,
        hasMore: pageData.current < pageData.pages,
        categories: categories,
      ));
    } catch (e) {
      emit(LostFoundListState.error(message: e.toString()));
    }
  }

  Future<void> _onSearchChanged(
      ListSearchChanged event, Emitter<LostFoundListState> emit) async {
    _debounceTimer?.cancel();
    final s = state;
    if (s is! ListLoaded) return;

    _debounceTimer = Timer(const Duration(milliseconds: 300), () async {
      try {
        final pageData = await _lostFoundService.list(
          pageNum: 1,
          keyword: event.keyword,
          itemType: s.itemType,
          categoryId: s.categoryId,
          status: s.status,
        );
        if (!isClosed) {
          emit(s.copyWith(
            items: pageData.records,
            currentPage: pageData.current,
            hasMore: pageData.current < pageData.pages,
            keyword: event.keyword,
          ));
        }
      } catch (e) {
        if (!isClosed) {
          emit(LostFoundListState.error(message: e.toString()));
        }
      }
    });
  }

  Future<void> _onFilterChanged(
      ListFilterChanged event, Emitter<LostFoundListState> emit) async {
    _debounceTimer?.cancel();
    final s = state;
    if (s is! ListLoaded) return;

    try {
      final pageData = await _lostFoundService.list(
        pageNum: 1,
        keyword: s.keyword,
        itemType: event.itemType,
        categoryId: event.categoryId,
        status: event.status,
      );
      if (!isClosed) {
        emit(s.copyWith(
          items: pageData.records,
          currentPage: pageData.current,
          hasMore: pageData.current < pageData.pages,
          itemType: event.itemType,
          categoryId: event.categoryId,
          status: event.status,
        ));
      }
    } catch (e) {
      if (!isClosed) {
        emit(LostFoundListState.error(message: e.toString()));
      }
    }
  }

  Future<void> _onLoadMore(
      ListLoadMore event, Emitter<LostFoundListState> emit) async {
    final s = state;
    if (s is! ListLoaded || s.isLoadingMore || !s.hasMore) return;

    emit(s.copyWith(isLoadingMore: true));
    try {
      final nextPage = s.currentPage + 1;
      final pageData = await _lostFoundService.list(
        pageNum: nextPage,
        keyword: s.keyword,
        itemType: s.itemType,
        categoryId: s.categoryId,
        status: s.status,
      );
      if (!isClosed) {
        emit(s.copyWith(
          items: [...s.items, ...pageData.records],
          currentPage: pageData.current,
          hasMore: pageData.current < pageData.pages,
          isLoadingMore: false,
        ));
      }
    } catch (e) {
      if (!isClosed) {
        emit(s.copyWith(isLoadingMore: false));
      }
    }
  }
}
