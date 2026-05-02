import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required int id,
    required String username,
    String? nickname,
    String? phone,
    String? email,
    String? studentId,
    String? avatar,
    String? role,
    DateTime? createTime,
    DateTime? lastLoginTime,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@freezed
class AuthResponse with _$AuthResponse {
  const factory AuthResponse({
    required String accessToken,
    required String refreshToken,
    required int expiresIn,
    required User user,
  }) = _AuthResponse;

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);
}

@freezed
class LoginRequest with _$LoginRequest {
  const factory LoginRequest({
    required String username,
    required String password,
  }) = _LoginRequest;

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);

  Map<String, dynamic> toJson() => {'username': username, 'password': password};
}

@freezed
class RegisterRequest with _$RegisterRequest {
  const factory RegisterRequest({
    required String username,
    required String password,
    required String phone,
    String? studentId,
    String? nickname,
  }) = _RegisterRequest;

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
        'phone': phone,
        if (studentId != null) 'studentId': studentId,
        if (nickname != null) 'nickname': nickname,
      };
}

@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    required int id,
    required String username,
    String? nickname,
    String? phone,
    String? email,
    String? studentId,
    String? avatar,
    String? role,
    DateTime? createTime,
    DateTime? lastLoginTime,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
}
