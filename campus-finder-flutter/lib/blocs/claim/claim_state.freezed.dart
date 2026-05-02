// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'claim_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ClaimState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClaimState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ClaimState()';
}


}

/// @nodoc
class $ClaimStateCopyWith<$Res>  {
$ClaimStateCopyWith(ClaimState _, $Res Function(ClaimState) __);
}


/// Adds pattern-matching-related methods to [ClaimState].
extension ClaimStatePatterns on ClaimState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ClaimInitial value)?  initial,TResult Function( ClaimLoading value)?  loading,TResult Function( ClaimsLoaded value)?  claimsLoaded,TResult Function( ClaimSubmitting value)?  submitting,TResult Function( ClaimSubmitted value)?  submitted,TResult Function( ClaimError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ClaimInitial() when initial != null:
return initial(_that);case ClaimLoading() when loading != null:
return loading(_that);case ClaimsLoaded() when claimsLoaded != null:
return claimsLoaded(_that);case ClaimSubmitting() when submitting != null:
return submitting(_that);case ClaimSubmitted() when submitted != null:
return submitted(_that);case ClaimError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ClaimInitial value)  initial,required TResult Function( ClaimLoading value)  loading,required TResult Function( ClaimsLoaded value)  claimsLoaded,required TResult Function( ClaimSubmitting value)  submitting,required TResult Function( ClaimSubmitted value)  submitted,required TResult Function( ClaimError value)  error,}){
final _that = this;
switch (_that) {
case ClaimInitial():
return initial(_that);case ClaimLoading():
return loading(_that);case ClaimsLoaded():
return claimsLoaded(_that);case ClaimSubmitting():
return submitting(_that);case ClaimSubmitted():
return submitted(_that);case ClaimError():
return error(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ClaimInitial value)?  initial,TResult? Function( ClaimLoading value)?  loading,TResult? Function( ClaimsLoaded value)?  claimsLoaded,TResult? Function( ClaimSubmitting value)?  submitting,TResult? Function( ClaimSubmitted value)?  submitted,TResult? Function( ClaimError value)?  error,}){
final _that = this;
switch (_that) {
case ClaimInitial() when initial != null:
return initial(_that);case ClaimLoading() when loading != null:
return loading(_that);case ClaimsLoaded() when claimsLoaded != null:
return claimsLoaded(_that);case ClaimSubmitting() when submitting != null:
return submitting(_that);case ClaimSubmitted() when submitted != null:
return submitted(_that);case ClaimError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<Claim> claims)?  claimsLoaded,TResult Function()?  submitting,TResult Function( Claim claim)?  submitted,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ClaimInitial() when initial != null:
return initial();case ClaimLoading() when loading != null:
return loading();case ClaimsLoaded() when claimsLoaded != null:
return claimsLoaded(_that.claims);case ClaimSubmitting() when submitting != null:
return submitting();case ClaimSubmitted() when submitted != null:
return submitted(_that.claim);case ClaimError() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<Claim> claims)  claimsLoaded,required TResult Function()  submitting,required TResult Function( Claim claim)  submitted,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case ClaimInitial():
return initial();case ClaimLoading():
return loading();case ClaimsLoaded():
return claimsLoaded(_that.claims);case ClaimSubmitting():
return submitting();case ClaimSubmitted():
return submitted(_that.claim);case ClaimError():
return error(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<Claim> claims)?  claimsLoaded,TResult? Function()?  submitting,TResult? Function( Claim claim)?  submitted,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case ClaimInitial() when initial != null:
return initial();case ClaimLoading() when loading != null:
return loading();case ClaimsLoaded() when claimsLoaded != null:
return claimsLoaded(_that.claims);case ClaimSubmitting() when submitting != null:
return submitting();case ClaimSubmitted() when submitted != null:
return submitted(_that.claim);case ClaimError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class ClaimInitial implements ClaimState {
  const ClaimInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClaimInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ClaimState.initial()';
}


}




/// @nodoc


class ClaimLoading implements ClaimState {
  const ClaimLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClaimLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ClaimState.loading()';
}


}




/// @nodoc


class ClaimsLoaded implements ClaimState {
  const ClaimsLoaded({required final  List<Claim> claims}): _claims = claims;
  

 final  List<Claim> _claims;
 List<Claim> get claims {
  if (_claims is EqualUnmodifiableListView) return _claims;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_claims);
}


/// Create a copy of ClaimState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClaimsLoadedCopyWith<ClaimsLoaded> get copyWith => _$ClaimsLoadedCopyWithImpl<ClaimsLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClaimsLoaded&&const DeepCollectionEquality().equals(other._claims, _claims));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_claims));

@override
String toString() {
  return 'ClaimState.claimsLoaded(claims: $claims)';
}


}

/// @nodoc
abstract mixin class $ClaimsLoadedCopyWith<$Res> implements $ClaimStateCopyWith<$Res> {
  factory $ClaimsLoadedCopyWith(ClaimsLoaded value, $Res Function(ClaimsLoaded) _then) = _$ClaimsLoadedCopyWithImpl;
@useResult
$Res call({
 List<Claim> claims
});




}
/// @nodoc
class _$ClaimsLoadedCopyWithImpl<$Res>
    implements $ClaimsLoadedCopyWith<$Res> {
  _$ClaimsLoadedCopyWithImpl(this._self, this._then);

  final ClaimsLoaded _self;
  final $Res Function(ClaimsLoaded) _then;

/// Create a copy of ClaimState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? claims = null,}) {
  return _then(ClaimsLoaded(
claims: null == claims ? _self._claims : claims // ignore: cast_nullable_to_non_nullable
as List<Claim>,
  ));
}


}

/// @nodoc


class ClaimSubmitting implements ClaimState {
  const ClaimSubmitting();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClaimSubmitting);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ClaimState.submitting()';
}


}




/// @nodoc


class ClaimSubmitted implements ClaimState {
  const ClaimSubmitted({required this.claim});
  

 final  Claim claim;

/// Create a copy of ClaimState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClaimSubmittedCopyWith<ClaimSubmitted> get copyWith => _$ClaimSubmittedCopyWithImpl<ClaimSubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClaimSubmitted&&(identical(other.claim, claim) || other.claim == claim));
}


@override
int get hashCode => Object.hash(runtimeType,claim);

@override
String toString() {
  return 'ClaimState.submitted(claim: $claim)';
}


}

/// @nodoc
abstract mixin class $ClaimSubmittedCopyWith<$Res> implements $ClaimStateCopyWith<$Res> {
  factory $ClaimSubmittedCopyWith(ClaimSubmitted value, $Res Function(ClaimSubmitted) _then) = _$ClaimSubmittedCopyWithImpl;
@useResult
$Res call({
 Claim claim
});


$ClaimCopyWith<$Res> get claim;

}
/// @nodoc
class _$ClaimSubmittedCopyWithImpl<$Res>
    implements $ClaimSubmittedCopyWith<$Res> {
  _$ClaimSubmittedCopyWithImpl(this._self, this._then);

  final ClaimSubmitted _self;
  final $Res Function(ClaimSubmitted) _then;

/// Create a copy of ClaimState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? claim = null,}) {
  return _then(ClaimSubmitted(
claim: null == claim ? _self.claim : claim // ignore: cast_nullable_to_non_nullable
as Claim,
  ));
}

/// Create a copy of ClaimState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClaimCopyWith<$Res> get claim {
  
  return $ClaimCopyWith<$Res>(_self.claim, (value) {
    return _then(_self.copyWith(claim: value));
  });
}
}

/// @nodoc


class ClaimError implements ClaimState {
  const ClaimError({required this.message});
  

 final  String message;

/// Create a copy of ClaimState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClaimErrorCopyWith<ClaimError> get copyWith => _$ClaimErrorCopyWithImpl<ClaimError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClaimError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ClaimState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $ClaimErrorCopyWith<$Res> implements $ClaimStateCopyWith<$Res> {
  factory $ClaimErrorCopyWith(ClaimError value, $Res Function(ClaimError) _then) = _$ClaimErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ClaimErrorCopyWithImpl<$Res>
    implements $ClaimErrorCopyWith<$Res> {
  _$ClaimErrorCopyWithImpl(this._self, this._then);

  final ClaimError _self;
  final $Res Function(ClaimError) _then;

/// Create a copy of ClaimState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ClaimError(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
