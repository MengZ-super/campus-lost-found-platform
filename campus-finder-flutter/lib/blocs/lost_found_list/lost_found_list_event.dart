import 'package:freezed_annotation/freezed_annotation.dart';

part 'lost_found_list_event.freezed.dart';

@freezed
class LostFoundListEvent with _$LostFoundListEvent {
  const factory LostFoundListEvent.loadList() = ListLoadList;
  const factory LostFoundListEvent.searchChanged(String keyword) = ListSearchChanged;
  const factory LostFoundListEvent.filterChanged({
    String? itemType,
    int? categoryId,
    String? status,
  }) = ListFilterChanged;
  const factory LostFoundListEvent.loadMore() = ListLoadMore;
}
