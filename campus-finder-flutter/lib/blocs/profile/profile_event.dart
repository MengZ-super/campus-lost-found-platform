import 'package:freezed_annotation/freezed_annotation.dart';
import '../../models/user.dart';

part 'profile_event.freezed.dart';

@freezed
class ProfileEvent with _$ProfileEvent {
  const factory ProfileEvent.loadProfile() = LoadProfile;
  const factory ProfileEvent.updateProfile({
    required UpdateProfileRequest request,
  }) = UpdateProfile;
  const factory ProfileEvent.changePassword({
    required ChangePasswordRequest request,
  }) = ChangePassword;
}
