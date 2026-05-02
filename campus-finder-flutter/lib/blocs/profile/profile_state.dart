import 'package:freezed_annotation/freezed_annotation.dart';
import '../../models/user.dart';

part 'profile_state.freezed.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState.initial() = ProfileInitial;
  const factory ProfileState.loading() = ProfileLoading;
  const factory ProfileState.loaded({required UserProfile profile}) =
      ProfileLoaded;
  const factory ProfileState.saving({required UserProfile profile}) =
      ProfileSaving;
  const factory ProfileState.error({required String message}) = ProfileError;
  const factory ProfileState.passwordChangeLoading() = PasswordChangeLoading;
  const factory ProfileState.passwordChangeSuccess() = PasswordChangeSuccess;
  const factory ProfileState.passwordChangeError({required String message}) =
      PasswordChangeError;
}
