// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
  id: (json['id'] as num).toInt(),
  username: json['username'] as String,
  nickname: json['nickname'] as String?,
  phone: json['phone'] as String?,
  email: json['email'] as String?,
  studentId: json['studentId'] as String?,
  avatar: json['avatar'] as String?,
  role: json['role'] as String?,
  createTime: json['createTime'] == null
      ? null
      : DateTime.parse(json['createTime'] as String),
  lastLoginTime: json['lastLoginTime'] == null
      ? null
      : DateTime.parse(json['lastLoginTime'] as String),
);

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
  'id': instance.id,
  'username': instance.username,
  'nickname': instance.nickname,
  'phone': instance.phone,
  'email': instance.email,
  'studentId': instance.studentId,
  'avatar': instance.avatar,
  'role': instance.role,
  'createTime': instance.createTime?.toIso8601String(),
  'lastLoginTime': instance.lastLoginTime?.toIso8601String(),
};

_AuthResponse _$AuthResponseFromJson(Map<String, dynamic> json) =>
    _AuthResponse(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      expiresIn: (json['expiresIn'] as num).toInt(),
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthResponseToJson(_AuthResponse instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'expiresIn': instance.expiresIn,
      'user': instance.user,
    };

_LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) =>
    _LoginRequest(
      username: json['username'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$LoginRequestToJson(_LoginRequest instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
    };

_RegisterRequest _$RegisterRequestFromJson(Map<String, dynamic> json) =>
    _RegisterRequest(
      username: json['username'] as String,
      password: json['password'] as String,
      phone: json['phone'] as String,
      studentId: json['studentId'] as String?,
      nickname: json['nickname'] as String?,
    );

Map<String, dynamic> _$RegisterRequestToJson(_RegisterRequest instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'phone': instance.phone,
      'studentId': instance.studentId,
      'nickname': instance.nickname,
    };

_UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => _UserProfile(
  id: (json['id'] as num).toInt(),
  username: json['username'] as String,
  nickname: json['nickname'] as String?,
  phone: json['phone'] as String?,
  email: json['email'] as String?,
  studentId: json['studentId'] as String?,
  avatar: json['avatar'] as String?,
  role: json['role'] as String?,
  gender: (json['gender'] as num?)?.toInt(),
  genderText: json['genderText'] as String?,
  status: (json['status'] as num?)?.toInt(),
  lastLoginIp: json['lastLoginIp'] as String?,
  createTime: json['createTime'] == null
      ? null
      : DateTime.parse(json['createTime'] as String),
  lastLoginTime: json['lastLoginTime'] == null
      ? null
      : DateTime.parse(json['lastLoginTime'] as String),
);

Map<String, dynamic> _$UserProfileToJson(_UserProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'nickname': instance.nickname,
      'phone': instance.phone,
      'email': instance.email,
      'studentId': instance.studentId,
      'avatar': instance.avatar,
      'role': instance.role,
      'gender': instance.gender,
      'genderText': instance.genderText,
      'status': instance.status,
      'lastLoginIp': instance.lastLoginIp,
      'createTime': instance.createTime?.toIso8601String(),
      'lastLoginTime': instance.lastLoginTime?.toIso8601String(),
    };

_UpdateProfileRequest _$UpdateProfileRequestFromJson(
  Map<String, dynamic> json,
) => _UpdateProfileRequest(
  nickname: json['nickname'] as String?,
  avatar: json['avatar'] as String?,
  email: json['email'] as String?,
  gender: (json['gender'] as num?)?.toInt(),
  phone: json['phone'] as String?,
);

Map<String, dynamic> _$UpdateProfileRequestToJson(
  _UpdateProfileRequest instance,
) => <String, dynamic>{
  'nickname': instance.nickname,
  'avatar': instance.avatar,
  'email': instance.email,
  'gender': instance.gender,
  'phone': instance.phone,
};

_ChangePasswordRequest _$ChangePasswordRequestFromJson(
  Map<String, dynamic> json,
) => _ChangePasswordRequest(
  oldPassword: json['oldPassword'] as String,
  newPassword: json['newPassword'] as String,
  confirmPassword: json['confirmPassword'] as String,
);

Map<String, dynamic> _$ChangePasswordRequestToJson(
  _ChangePasswordRequest instance,
) => <String, dynamic>{
  'oldPassword': instance.oldPassword,
  'newPassword': instance.newPassword,
  'confirmPassword': instance.confirmPassword,
};
