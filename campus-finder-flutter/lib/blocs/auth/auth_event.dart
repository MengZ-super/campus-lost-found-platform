import 'package:freezed_annotation/freezed_annotation.dart';
import '../../models/user.dart';

part 'auth_event.freezed.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.appStarted() = AppStarted;
  const factory AuthEvent.loginRequested({
    required String username,
    required String password,
  }) = LoginRequested;
  const factory AuthEvent.registerRequested({
    required RegisterRequest request,
  }) = RegisterRequested;
  const factory AuthEvent.logoutRequested() = LogoutRequested;
}
