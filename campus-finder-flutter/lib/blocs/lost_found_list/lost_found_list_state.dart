import 'package:freezed_annotation/freezed_annotation.dart';
import '../../models/lost_found.dart';
import '../../models/category.dart';

part 'lost_found_list_state.freezed.dart';

@freezed
class LostFoundListState with _$LostFoundListState {
  const factory LostFoundListState.initial() = ListInitial;
  const factory LostFoundListState.loading() = ListLoading;
  const factory LostFoundListState.loaded({
    required List<LostFoundItem> items,
    required int currentPage,
    required bool hasMore,
    required List<Category> categories,
    String? itemType,
    int? categoryId,
    String? status,
    @Default('') String keyword,
    @Default(false) bool isLoadingMore,
  }) = ListLoaded;
  const factory LostFoundListState.error({required String message}) = ListError;
}
