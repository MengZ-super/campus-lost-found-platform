// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'claim_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ClaimEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClaimEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ClaimEvent()';
}


}

/// @nodoc
class $ClaimEventCopyWith<$Res>  {
$ClaimEventCopyWith(ClaimEvent _, $Res Function(ClaimEvent) __);
}


/// Adds pattern-matching-related methods to [ClaimEvent].
extension ClaimEventPatterns on ClaimEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoadClaims value)?  loadClaims,TResult Function( SubmitClaim value)?  submitClaim,TResult Function( ReviewClaim value)?  reviewClaim,TResult Function( CancelClaim value)?  cancelClaim,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoadClaims() when loadClaims != null:
return loadClaims(_that);case SubmitClaim() when submitClaim != null:
return submitClaim(_that);case ReviewClaim() when reviewClaim != null:
return reviewClaim(_that);case CancelClaim() when cancelClaim != null:
return cancelClaim(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoadClaims value)  loadClaims,required TResult Function( SubmitClaim value)  submitClaim,required TResult Function( ReviewClaim value)  reviewClaim,required TResult Function( CancelClaim value)  cancelClaim,}){
final _that = this;
switch (_that) {
case LoadClaims():
return loadClaims(_that);case SubmitClaim():
return submitClaim(_that);case ReviewClaim():
return reviewClaim(_that);case CancelClaim():
return cancelClaim(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoadClaims value)?  loadClaims,TResult? Function( SubmitClaim value)?  submitClaim,TResult? Function( ReviewClaim value)?  reviewClaim,TResult? Function( CancelClaim value)?  cancelClaim,}){
final _that = this;
switch (_that) {
case LoadClaims() when loadClaims != null:
return loadClaims(_that);case SubmitClaim() when submitClaim != null:
return submitClaim(_that);case ReviewClaim() when reviewClaim != null:
return reviewClaim(_that);case CancelClaim() when cancelClaim != null:
return cancelClaim(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int lostFoundId)?  loadClaims,TResult Function( CreateClaimRequest request)?  submitClaim,TResult Function( int claimId,  String action,  String? remark)?  reviewClaim,TResult Function( int claimId)?  cancelClaim,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoadClaims() when loadClaims != null:
return loadClaims(_that.lostFoundId);case SubmitClaim() when submitClaim != null:
return submitClaim(_that.request);case ReviewClaim() when reviewClaim != null:
return reviewClaim(_that.claimId,_that.action,_that.remark);case CancelClaim() when cancelClaim != null:
return cancelClaim(_that.claimId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int lostFoundId)  loadClaims,required TResult Function( CreateClaimRequest request)  submitClaim,required TResult Function( int claimId,  String action,  String? remark)  reviewClaim,required TResult Function( int claimId)  cancelClaim,}) {final _that = this;
switch (_that) {
case LoadClaims():
return loadClaims(_that.lostFoundId);case SubmitClaim():
return submitClaim(_that.request);case ReviewClaim():
return reviewClaim(_that.claimId,_that.action,_that.remark);case CancelClaim():
return cancelClaim(_that.claimId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int lostFoundId)?  loadClaims,TResult? Function( CreateClaimRequest request)?  submitClaim,TResult? Function( int claimId,  String action,  String? remark)?  reviewClaim,TResult? Function( int claimId)?  cancelClaim,}) {final _that = this;
switch (_that) {
case LoadClaims() when loadClaims != null:
return loadClaims(_that.lostFoundId);case SubmitClaim() when submitClaim != null:
return submitClaim(_that.request);case ReviewClaim() when reviewClaim != null:
return reviewClaim(_that.claimId,_that.action,_that.remark);case CancelClaim() when cancelClaim != null:
return cancelClaim(_that.claimId);case _:
  return null;

}
}

}

/// @nodoc


class LoadClaims implements ClaimEvent {
  const LoadClaims({required this.lostFoundId});
  

 final  int lostFoundId;

/// Create a copy of ClaimEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadClaimsCopyWith<LoadClaims> get copyWith => _$LoadClaimsCopyWithImpl<LoadClaims>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadClaims&&(identical(other.lostFoundId, lostFoundId) || other.lostFoundId == lostFoundId));
}


@override
int get hashCode => Object.hash(runtimeType,lostFoundId);

@override
String toString() {
  return 'ClaimEvent.loadClaims(lostFoundId: $lostFoundId)';
}


}

/// @nodoc
abstract mixin class $LoadClaimsCopyWith<$Res> implements $ClaimEventCopyWith<$Res> {
  factory $LoadClaimsCopyWith(LoadClaims value, $Res Function(LoadClaims) _then) = _$LoadClaimsCopyWithImpl;
@useResult
$Res call({
 int lostFoundId
});




}
/// @nodoc
class _$LoadClaimsCopyWithImpl<$Res>
    implements $LoadClaimsCopyWith<$Res> {
  _$LoadClaimsCopyWithImpl(this._self, this._then);

  final LoadClaims _self;
  final $Res Function(LoadClaims) _then;

/// Create a copy of ClaimEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? lostFoundId = null,}) {
  return _then(LoadClaims(
lostFoundId: null == lostFoundId ? _self.lostFoundId : lostFoundId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class SubmitClaim implements ClaimEvent {
  const SubmitClaim({required this.request});
  

 final  CreateClaimRequest request;

/// Create a copy of ClaimEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubmitClaimCopyWith<SubmitClaim> get copyWith => _$SubmitClaimCopyWithImpl<SubmitClaim>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubmitClaim&&(identical(other.request, request) || other.request == request));
}


@override
int get hashCode => Object.hash(runtimeType,request);

@override
String toString() {
  return 'ClaimEvent.submitClaim(request: $request)';
}


}

/// @nodoc
abstract mixin class $SubmitClaimCopyWith<$Res> implements $ClaimEventCopyWith<$Res> {
  factory $SubmitClaimCopyWith(SubmitClaim value, $Res Function(SubmitClaim) _then) = _$SubmitClaimCopyWithImpl;
@useResult
$Res call({
 CreateClaimRequest request
});


$CreateClaimRequestCopyWith<$Res> get request;

}
/// @nodoc
class _$SubmitClaimCopyWithImpl<$Res>
    implements $SubmitClaimCopyWith<$Res> {
  _$SubmitClaimCopyWithImpl(this._self, this._then);

  final SubmitClaim _self;
  final $Res Function(SubmitClaim) _then;

/// Create a copy of ClaimEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? request = null,}) {
  return _then(SubmitClaim(
request: null == request ? _self.request : request // ignore: cast_nullable_to_non_nullable
as CreateClaimRequest,
  ));
}

/// Create a copy of ClaimEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CreateClaimRequestCopyWith<$Res> get request {
  
  return $CreateClaimRequestCopyWith<$Res>(_self.request, (value) {
    return _then(_self.copyWith(request: value));
  });
}
}

/// @nodoc


class ReviewClaim implements ClaimEvent {
  const ReviewClaim({required this.claimId, required this.action, this.remark});
  

 final  int claimId;
 final  String action;
 final  String? remark;

/// Create a copy of ClaimEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReviewClaimCopyWith<ReviewClaim> get copyWith => _$ReviewClaimCopyWithImpl<ReviewClaim>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReviewClaim&&(identical(other.claimId, claimId) || other.claimId == claimId)&&(identical(other.action, action) || other.action == action)&&(identical(other.remark, remark) || other.remark == remark));
}


@override
int get hashCode => Object.hash(runtimeType,claimId,action,remark);

@override
String toString() {
  return 'ClaimEvent.reviewClaim(claimId: $claimId, action: $action, remark: $remark)';
}


}

/// @nodoc
abstract mixin class $ReviewClaimCopyWith<$Res> implements $ClaimEventCopyWith<$Res> {
  factory $ReviewClaimCopyWith(ReviewClaim value, $Res Function(ReviewClaim) _then) = _$ReviewClaimCopyWithImpl;
@useResult
$Res call({
 int claimId, String action, String? remark
});




}
/// @nodoc
class _$ReviewClaimCopyWithImpl<$Res>
    implements $ReviewClaimCopyWith<$Res> {
  _$ReviewClaimCopyWithImpl(this._self, this._then);

  final ReviewClaim _self;
  final $Res Function(ReviewClaim) _then;

/// Create a copy of ClaimEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? claimId = null,Object? action = null,Object? remark = freezed,}) {
  return _then(ReviewClaim(
claimId: null == claimId ? _self.claimId : claimId // ignore: cast_nullable_to_non_nullable
as int,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as String,remark: freezed == remark ? _self.remark : remark // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class CancelClaim implements ClaimEvent {
  const CancelClaim({required this.claimId});
  

 final  int claimId;

/// Create a copy of ClaimEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CancelClaimCopyWith<CancelClaim> get copyWith => _$CancelClaimCopyWithImpl<CancelClaim>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CancelClaim&&(identical(other.claimId, claimId) || other.claimId == claimId));
}


@override
int get hashCode => Object.hash(runtimeType,claimId);

@override
String toString() {
  return 'ClaimEvent.cancelClaim(claimId: $claimId)';
}


}

/// @nodoc
abstract mixin class $CancelClaimCopyWith<$Res> implements $ClaimEventCopyWith<$Res> {
  factory $CancelClaimCopyWith(CancelClaim value, $Res Function(CancelClaim) _then) = _$CancelClaimCopyWithImpl;
@useResult
$Res call({
 int claimId
});




}
/// @nodoc
class _$CancelClaimCopyWithImpl<$Res>
    implements $CancelClaimCopyWith<$Res> {
  _$CancelClaimCopyWithImpl(this._self, this._then);

  final CancelClaim _self;
  final $Res Function(CancelClaim) _then;

/// Create a copy of ClaimEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? claimId = null,}) {
  return _then(CancelClaim(
claimId: null == claimId ? _self.claimId : claimId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
