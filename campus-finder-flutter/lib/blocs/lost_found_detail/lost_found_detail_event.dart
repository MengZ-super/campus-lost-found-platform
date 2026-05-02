import 'package:freezed_annotation/freezed_annotation.dart';

part 'lost_found_detail_event.freezed.dart';

@freezed
abstract class LostFoundDetailEvent with _$LostFoundDetailEvent {
  const factory LostFoundDetailEvent.loadDetail({required int id}) = LoadDetail;
  const factory LostFoundDetailEvent.toggleFavorite({required int id}) =
      ToggleFavorite;
}
