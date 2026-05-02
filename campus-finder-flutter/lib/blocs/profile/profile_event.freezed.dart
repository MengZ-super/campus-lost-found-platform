// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProfileEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileEvent()';
}


}

/// @nodoc
class $ProfileEventCopyWith<$Res>  {
$ProfileEventCopyWith(ProfileEvent _, $Res Function(ProfileEvent) __);
}


/// Adds pattern-matching-related methods to [ProfileEvent].
extension ProfileEventPatterns on ProfileEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoadProfile value)?  loadProfile,TResult Function( UpdateProfile value)?  updateProfile,TResult Function( ChangePassword value)?  changePassword,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoadProfile() when loadProfile != null:
return loadProfile(_that);case UpdateProfile() when updateProfile != null:
return updateProfile(_that);case ChangePassword() when changePassword != null:
return changePassword(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoadProfile value)  loadProfile,required TResult Function( UpdateProfile value)  updateProfile,required TResult Function( ChangePassword value)  changePassword,}){
final _that = this;
switch (_that) {
case LoadProfile():
return loadProfile(_that);case UpdateProfile():
return updateProfile(_that);case ChangePassword():
return changePassword(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoadProfile value)?  loadProfile,TResult? Function( UpdateProfile value)?  updateProfile,TResult? Function( ChangePassword value)?  changePassword,}){
final _that = this;
switch (_that) {
case LoadProfile() when loadProfile != null:
return loadProfile(_that);case UpdateProfile() when updateProfile != null:
return updateProfile(_that);case ChangePassword() when changePassword != null:
return changePassword(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadProfile,TResult Function( UpdateProfileRequest request)?  updateProfile,TResult Function( ChangePasswordRequest request)?  changePassword,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoadProfile() when loadProfile != null:
return loadProfile();case UpdateProfile() when updateProfile != null:
return updateProfile(_that.request);case ChangePassword() when changePassword != null:
return changePassword(_that.request);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadProfile,required TResult Function( UpdateProfileRequest request)  updateProfile,required TResult Function( ChangePasswordRequest request)  changePassword,}) {final _that = this;
switch (_that) {
case LoadProfile():
return loadProfile();case UpdateProfile():
return updateProfile(_that.request);case ChangePassword():
return changePassword(_that.request);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadProfile,TResult? Function( UpdateProfileRequest request)?  updateProfile,TResult? Function( ChangePasswordRequest request)?  changePassword,}) {final _that = this;
switch (_that) {
case LoadProfile() when loadProfile != null:
return loadProfile();case UpdateProfile() when updateProfile != null:
return updateProfile(_that.request);case ChangePassword() when changePassword != null:
return changePassword(_that.request);case _:
  return null;

}
}

}

/// @nodoc


class LoadProfile implements ProfileEvent {
  const LoadProfile();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadProfile);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileEvent.loadProfile()';
}


}




/// @nodoc


class UpdateProfile implements ProfileEvent {
  const UpdateProfile({required this.request});
  

 final  UpdateProfileRequest request;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateProfileCopyWith<UpdateProfile> get copyWith => _$UpdateProfileCopyWithImpl<UpdateProfile>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateProfile&&(identical(other.request, request) || other.request == request));
}


@override
int get hashCode => Object.hash(runtimeType,request);

@override
String toString() {
  return 'ProfileEvent.updateProfile(request: $request)';
}


}

/// @nodoc
abstract mixin class $UpdateProfileCopyWith<$Res> implements $ProfileEventCopyWith<$Res> {
  factory $UpdateProfileCopyWith(UpdateProfile value, $Res Function(UpdateProfile) _then) = _$UpdateProfileCopyWithImpl;
@useResult
$Res call({
 UpdateProfileRequest request
});


$UpdateProfileRequestCopyWith<$Res> get request;

}
/// @nodoc
class _$UpdateProfileCopyWithImpl<$Res>
    implements $UpdateProfileCopyWith<$Res> {
  _$UpdateProfileCopyWithImpl(this._self, this._then);

  final UpdateProfile _self;
  final $Res Function(UpdateProfile) _then;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? request = null,}) {
  return _then(UpdateProfile(
request: null == request ? _self.request : request // ignore: cast_nullable_to_non_nullable
as UpdateProfileRequest,
  ));
}

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UpdateProfileRequestCopyWith<$Res> get request {
  
  return $UpdateProfileRequestCopyWith<$Res>(_self.request, (value) {
    return _then(_self.copyWith(request: value));
  });
}
}

/// @nodoc


class ChangePassword implements ProfileEvent {
  const ChangePassword({required this.request});
  

 final  ChangePasswordRequest request;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChangePasswordCopyWith<ChangePassword> get copyWith => _$ChangePasswordCopyWithImpl<ChangePassword>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChangePassword&&(identical(other.request, request) || other.request == request));
}


@override
int get hashCode => Object.hash(runtimeType,request);

@override
String toString() {
  return 'ProfileEvent.changePassword(request: $request)';
}


}

/// @nodoc
abstract mixin class $ChangePasswordCopyWith<$Res> implements $ProfileEventCopyWith<$Res> {
  factory $ChangePasswordCopyWith(ChangePassword value, $Res Function(ChangePassword) _then) = _$ChangePasswordCopyWithImpl;
@useResult
$Res call({
 ChangePasswordRequest request
});


$ChangePasswordRequestCopyWith<$Res> get request;

}
/// @nodoc
class _$ChangePasswordCopyWithImpl<$Res>
    implements $ChangePasswordCopyWith<$Res> {
  _$ChangePasswordCopyWithImpl(this._self, this._then);

  final ChangePassword _self;
  final $Res Function(ChangePassword) _then;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? request = null,}) {
  return _then(ChangePassword(
request: null == request ? _self.request : request // ignore: cast_nullable_to_non_nullable
as ChangePasswordRequest,
  ));
}

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChangePasswordRequestCopyWith<$Res> get request {
  
  return $ChangePasswordRequestCopyWith<$Res>(_self.request, (value) {
    return _then(_self.copyWith(request: value));
  });
}
}

// dart format on
