import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/lost_found_service.dart';
import 'lost_found_detail_event.dart';
import 'lost_found_detail_state.dart';

class LostFoundDetailBloc
    extends Bloc<LostFoundDetailEvent, LostFoundDetailState> {
  final LostFoundService _service;

  LostFoundDetailBloc({required LostFoundService service})
      : _service = service,
        super(const LostFoundDetailState.initial()) {
    on<LoadDetail>(_onLoadDetail);
    on<ToggleFavorite>(_onToggleFavorite);
  }

  Future<void> _onLoadDetail(
      LoadDetail event, Emitter<LostFoundDetailState> emit) async {
    emit(const LostFoundDetailState.loading());
    try {
      final item = await _service.getDetail(event.id);
      emit(LostFoundDetailState.loaded(item: item));
    } catch (e) {
      emit(LostFoundDetailState.error(message: e.toString()));
    }
  }

  Future<void> _onToggleFavorite(
      ToggleFavorite event, Emitter<LostFoundDetailState> emit) async {
    final s = state;
    if (s is! DetailLoaded) return;

    final item = s.item;
    final wasFav = item.favorited == true;
    try {
      if (wasFav) {
        await _service.unfavorite(event.id);
      } else {
        await _service.favorite(event.id);
      }
      emit(LostFoundDetailState.loaded(
        item: item.copyWith(
          favorited: !wasFav,
          favoriteCount:
              item.favoriteCount != null ? item.favoriteCount! + (wasFav ? -1 : 1) : (wasFav ? 0 : 1),
        ),
      ));
    } catch (_) {}
  }
}
