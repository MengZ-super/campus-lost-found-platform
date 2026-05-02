import 'package:freezed_annotation/freezed_annotation.dart';
import '../../models/lost_found.dart';

part 'lost_found_detail_state.freezed.dart';

@freezed
abstract class LostFoundDetailState with _$LostFoundDetailState {
  const factory LostFoundDetailState.initial() = DetailInitial;
  const factory LostFoundDetailState.loading() = DetailLoading;
  const factory LostFoundDetailState.loaded({required LostFoundItem item}) = DetailLoaded;
  const factory LostFoundDetailState.error({required String message}) = DetailError;
}
