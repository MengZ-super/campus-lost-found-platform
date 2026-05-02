// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'claim.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Claim {

 int get id; int get lostFoundId; int get userId; String? get claimType; String? get description; String? get features; String? get contact; List<String>? get proofImages; DateTime? get expectTime; String get status; String? get statusText; String? get remark; int? get reviewedBy; String? get reviewerNickname; DateTime? get reviewedTime; String? get lostFoundTitle; String? get lostFoundLocation; List<String>? get lostFoundImages; String? get applicantNickname; String? get applicantAvatar; DateTime? get createTime; DateTime? get updateTime;
/// Create a copy of Claim
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClaimCopyWith<Claim> get copyWith => _$ClaimCopyWithImpl<Claim>(this as Claim, _$identity);

  /// Serializes this Claim to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Claim&&(identical(other.id, id) || other.id == id)&&(identical(other.lostFoundId, lostFoundId) || other.lostFoundId == lostFoundId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.claimType, claimType) || other.claimType == claimType)&&(identical(other.description, description) || other.description == description)&&(identical(other.features, features) || other.features == features)&&(identical(other.contact, contact) || other.contact == contact)&&const DeepCollectionEquality().equals(other.proofImages, proofImages)&&(identical(other.expectTime, expectTime) || other.expectTime == expectTime)&&(identical(other.status, status) || other.status == status)&&(identical(other.statusText, statusText) || other.statusText == statusText)&&(identical(other.remark, remark) || other.remark == remark)&&(identical(other.reviewedBy, reviewedBy) || other.reviewedBy == reviewedBy)&&(identical(other.reviewerNickname, reviewerNickname) || other.reviewerNickname == reviewerNickname)&&(identical(other.reviewedTime, reviewedTime) || other.reviewedTime == reviewedTime)&&(identical(other.lostFoundTitle, lostFoundTitle) || other.lostFoundTitle == lostFoundTitle)&&(identical(other.lostFoundLocation, lostFoundLocation) || other.lostFoundLocation == lostFoundLocation)&&const DeepCollectionEquality().equals(other.lostFoundImages, lostFoundImages)&&(identical(other.applicantNickname, applicantNickname) || other.applicantNickname == applicantNickname)&&(identical(other.applicantAvatar, applicantAvatar) || other.applicantAvatar == applicantAvatar)&&(identical(other.createTime, createTime) || other.createTime == createTime)&&(identical(other.updateTime, updateTime) || other.updateTime == updateTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,lostFoundId,userId,claimType,description,features,contact,const DeepCollectionEquality().hash(proofImages),expectTime,status,statusText,remark,reviewedBy,reviewerNickname,reviewedTime,lostFoundTitle,lostFoundLocation,const DeepCollectionEquality().hash(lostFoundImages),applicantNickname,applicantAvatar,createTime,updateTime]);

@override
String toString() {
  return 'Claim(id: $id, lostFoundId: $lostFoundId, userId: $userId, claimType: $claimType, description: $description, features: $features, contact: $contact, proofImages: $proofImages, expectTime: $expectTime, status: $status, statusText: $statusText, remark: $remark, reviewedBy: $reviewedBy, reviewerNickname: $reviewerNickname, reviewedTime: $reviewedTime, lostFoundTitle: $lostFoundTitle, lostFoundLocation: $lostFoundLocation, lostFoundImages: $lostFoundImages, applicantNickname: $applicantNickname, applicantAvatar: $applicantAvatar, createTime: $createTime, updateTime: $updateTime)';
}


}

/// @nodoc
abstract mixin class $ClaimCopyWith<$Res>  {
  factory $ClaimCopyWith(Claim value, $Res Function(Claim) _then) = _$ClaimCopyWithImpl;
@useResult
$Res call({
 int id, int lostFoundId, int userId, String? claimType, String? description, String? features, String? contact, List<String>? proofImages, DateTime? expectTime, String status, String? statusText, String? remark, int? reviewedBy, String? reviewerNickname, DateTime? reviewedTime, String? lostFoundTitle, String? lostFoundLocation, List<String>? lostFoundImages, String? applicantNickname, String? applicantAvatar, DateTime? createTime, DateTime? updateTime
});




}
/// @nodoc
class _$ClaimCopyWithImpl<$Res>
    implements $ClaimCopyWith<$Res> {
  _$ClaimCopyWithImpl(this._self, this._then);

  final Claim _self;
  final $Res Function(Claim) _then;

/// Create a copy of Claim
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? lostFoundId = null,Object? userId = null,Object? claimType = freezed,Object? description = freezed,Object? features = freezed,Object? contact = freezed,Object? proofImages = freezed,Object? expectTime = freezed,Object? status = null,Object? statusText = freezed,Object? remark = freezed,Object? reviewedBy = freezed,Object? reviewerNickname = freezed,Object? reviewedTime = freezed,Object? lostFoundTitle = freezed,Object? lostFoundLocation = freezed,Object? lostFoundImages = freezed,Object? applicantNickname = freezed,Object? applicantAvatar = freezed,Object? createTime = freezed,Object? updateTime = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,lostFoundId: null == lostFoundId ? _self.lostFoundId : lostFoundId // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,claimType: freezed == claimType ? _self.claimType : claimType // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,features: freezed == features ? _self.features : features // ignore: cast_nullable_to_non_nullable
as String?,contact: freezed == contact ? _self.contact : contact // ignore: cast_nullable_to_non_nullable
as String?,proofImages: freezed == proofImages ? _self.proofImages : proofImages // ignore: cast_nullable_to_non_nullable
as List<String>?,expectTime: freezed == expectTime ? _self.expectTime : expectTime // ignore: cast_nullable_to_non_nullable
as DateTime?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,statusText: freezed == statusText ? _self.statusText : statusText // ignore: cast_nullable_to_non_nullable
as String?,remark: freezed == remark ? _self.remark : remark // ignore: cast_nullable_to_non_nullable
as String?,reviewedBy: freezed == reviewedBy ? _self.reviewedBy : reviewedBy // ignore: cast_nullable_to_non_nullable
as int?,reviewerNickname: freezed == reviewerNickname ? _self.reviewerNickname : reviewerNickname // ignore: cast_nullable_to_non_nullable
as String?,reviewedTime: freezed == reviewedTime ? _self.reviewedTime : reviewedTime // ignore: cast_nullable_to_non_nullable
as DateTime?,lostFoundTitle: freezed == lostFoundTitle ? _self.lostFoundTitle : lostFoundTitle // ignore: cast_nullable_to_non_nullable
as String?,lostFoundLocation: freezed == lostFoundLocation ? _self.lostFoundLocation : lostFoundLocation // ignore: cast_nullable_to_non_nullable
as String?,lostFoundImages: freezed == lostFoundImages ? _self.lostFoundImages : lostFoundImages // ignore: cast_nullable_to_non_nullable
as List<String>?,applicantNickname: freezed == applicantNickname ? _self.applicantNickname : applicantNickname // ignore: cast_nullable_to_non_nullable
as String?,applicantAvatar: freezed == applicantAvatar ? _self.applicantAvatar : applicantAvatar // ignore: cast_nullable_to_non_nullable
as String?,createTime: freezed == createTime ? _self.createTime : createTime // ignore: cast_nullable_to_non_nullable
as DateTime?,updateTime: freezed == updateTime ? _self.updateTime : updateTime // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Claim].
extension ClaimPatterns on Claim {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Claim value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Claim() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Claim value)  $default,){
final _that = this;
switch (_that) {
case _Claim():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Claim value)?  $default,){
final _that = this;
switch (_that) {
case _Claim() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int lostFoundId,  int userId,  String? claimType,  String? description,  String? features,  String? contact,  List<String>? proofImages,  DateTime? expectTime,  String status,  String? statusText,  String? remark,  int? reviewedBy,  String? reviewerNickname,  DateTime? reviewedTime,  String? lostFoundTitle,  String? lostFoundLocation,  List<String>? lostFoundImages,  String? applicantNickname,  String? applicantAvatar,  DateTime? createTime,  DateTime? updateTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Claim() when $default != null:
return $default(_that.id,_that.lostFoundId,_that.userId,_that.claimType,_that.description,_that.features,_that.contact,_that.proofImages,_that.expectTime,_that.status,_that.statusText,_that.remark,_that.reviewedBy,_that.reviewerNickname,_that.reviewedTime,_that.lostFoundTitle,_that.lostFoundLocation,_that.lostFoundImages,_that.applicantNickname,_that.applicantAvatar,_that.createTime,_that.updateTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int lostFoundId,  int userId,  String? claimType,  String? description,  String? features,  String? contact,  List<String>? proofImages,  DateTime? expectTime,  String status,  String? statusText,  String? remark,  int? reviewedBy,  String? reviewerNickname,  DateTime? reviewedTime,  String? lostFoundTitle,  String? lostFoundLocation,  List<String>? lostFoundImages,  String? applicantNickname,  String? applicantAvatar,  DateTime? createTime,  DateTime? updateTime)  $default,) {final _that = this;
switch (_that) {
case _Claim():
return $default(_that.id,_that.lostFoundId,_that.userId,_that.claimType,_that.description,_that.features,_that.contact,_that.proofImages,_that.expectTime,_that.status,_that.statusText,_that.remark,_that.reviewedBy,_that.reviewerNickname,_that.reviewedTime,_that.lostFoundTitle,_that.lostFoundLocation,_that.lostFoundImages,_that.applicantNickname,_that.applicantAvatar,_that.createTime,_that.updateTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int lostFoundId,  int userId,  String? claimType,  String? description,  String? features,  String? contact,  List<String>? proofImages,  DateTime? expectTime,  String status,  String? statusText,  String? remark,  int? reviewedBy,  String? reviewerNickname,  DateTime? reviewedTime,  String? lostFoundTitle,  String? lostFoundLocation,  List<String>? lostFoundImages,  String? applicantNickname,  String? applicantAvatar,  DateTime? createTime,  DateTime? updateTime)?  $default,) {final _that = this;
switch (_that) {
case _Claim() when $default != null:
return $default(_that.id,_that.lostFoundId,_that.userId,_that.claimType,_that.description,_that.features,_that.contact,_that.proofImages,_that.expectTime,_that.status,_that.statusText,_that.remark,_that.reviewedBy,_that.reviewerNickname,_that.reviewedTime,_that.lostFoundTitle,_that.lostFoundLocation,_that.lostFoundImages,_that.applicantNickname,_that.applicantAvatar,_that.createTime,_that.updateTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Claim implements Claim {
  const _Claim({required this.id, required this.lostFoundId, required this.userId, this.claimType, this.description, this.features, this.contact, final  List<String>? proofImages, this.expectTime, required this.status, this.statusText, this.remark, this.reviewedBy, this.reviewerNickname, this.reviewedTime, this.lostFoundTitle, this.lostFoundLocation, final  List<String>? lostFoundImages, this.applicantNickname, this.applicantAvatar, this.createTime, this.updateTime}): _proofImages = proofImages,_lostFoundImages = lostFoundImages;
  factory _Claim.fromJson(Map<String, dynamic> json) => _$ClaimFromJson(json);

@override final  int id;
@override final  int lostFoundId;
@override final  int userId;
@override final  String? claimType;
@override final  String? description;
@override final  String? features;
@override final  String? contact;
 final  List<String>? _proofImages;
@override List<String>? get proofImages {
  final value = _proofImages;
  if (value == null) return null;
  if (_proofImages is EqualUnmodifiableListView) return _proofImages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  DateTime? expectTime;
@override final  String status;
@override final  String? statusText;
@override final  String? remark;
@override final  int? reviewedBy;
@override final  String? reviewerNickname;
@override final  DateTime? reviewedTime;
@override final  String? lostFoundTitle;
@override final  String? lostFoundLocation;
 final  List<String>? _lostFoundImages;
@override List<String>? get lostFoundImages {
  final value = _lostFoundImages;
  if (value == null) return null;
  if (_lostFoundImages is EqualUnmodifiableListView) return _lostFoundImages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? applicantNickname;
@override final  String? applicantAvatar;
@override final  DateTime? createTime;
@override final  DateTime? updateTime;

/// Create a copy of Claim
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClaimCopyWith<_Claim> get copyWith => __$ClaimCopyWithImpl<_Claim>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClaimToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Claim&&(identical(other.id, id) || other.id == id)&&(identical(other.lostFoundId, lostFoundId) || other.lostFoundId == lostFoundId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.claimType, claimType) || other.claimType == claimType)&&(identical(other.description, description) || other.description == description)&&(identical(other.features, features) || other.features == features)&&(identical(other.contact, contact) || other.contact == contact)&&const DeepCollectionEquality().equals(other._proofImages, _proofImages)&&(identical(other.expectTime, expectTime) || other.expectTime == expectTime)&&(identical(other.status, status) || other.status == status)&&(identical(other.statusText, statusText) || other.statusText == statusText)&&(identical(other.remark, remark) || other.remark == remark)&&(identical(other.reviewedBy, reviewedBy) || other.reviewedBy == reviewedBy)&&(identical(other.reviewerNickname, reviewerNickname) || other.reviewerNickname == reviewerNickname)&&(identical(other.reviewedTime, reviewedTime) || other.reviewedTime == reviewedTime)&&(identical(other.lostFoundTitle, lostFoundTitle) || other.lostFoundTitle == lostFoundTitle)&&(identical(other.lostFoundLocation, lostFoundLocation) || other.lostFoundLocation == lostFoundLocation)&&const DeepCollectionEquality().equals(other._lostFoundImages, _lostFoundImages)&&(identical(other.applicantNickname, applicantNickname) || other.applicantNickname == applicantNickname)&&(identical(other.applicantAvatar, applicantAvatar) || other.applicantAvatar == applicantAvatar)&&(identical(other.createTime, createTime) || other.createTime == createTime)&&(identical(other.updateTime, updateTime) || other.updateTime == updateTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,lostFoundId,userId,claimType,description,features,contact,const DeepCollectionEquality().hash(_proofImages),expectTime,status,statusText,remark,reviewedBy,reviewerNickname,reviewedTime,lostFoundTitle,lostFoundLocation,const DeepCollectionEquality().hash(_lostFoundImages),applicantNickname,applicantAvatar,createTime,updateTime]);

@override
String toString() {
  return 'Claim(id: $id, lostFoundId: $lostFoundId, userId: $userId, claimType: $claimType, description: $description, features: $features, contact: $contact, proofImages: $proofImages, expectTime: $expectTime, status: $status, statusText: $statusText, remark: $remark, reviewedBy: $reviewedBy, reviewerNickname: $reviewerNickname, reviewedTime: $reviewedTime, lostFoundTitle: $lostFoundTitle, lostFoundLocation: $lostFoundLocation, lostFoundImages: $lostFoundImages, applicantNickname: $applicantNickname, applicantAvatar: $applicantAvatar, createTime: $createTime, updateTime: $updateTime)';
}


}

/// @nodoc
abstract mixin class _$ClaimCopyWith<$Res> implements $ClaimCopyWith<$Res> {
  factory _$ClaimCopyWith(_Claim value, $Res Function(_Claim) _then) = __$ClaimCopyWithImpl;
@override @useResult
$Res call({
 int id, int lostFoundId, int userId, String? claimType, String? description, String? features, String? contact, List<String>? proofImages, DateTime? expectTime, String status, String? statusText, String? remark, int? reviewedBy, String? reviewerNickname, DateTime? reviewedTime, String? lostFoundTitle, String? lostFoundLocation, List<String>? lostFoundImages, String? applicantNickname, String? applicantAvatar, DateTime? createTime, DateTime? updateTime
});




}
/// @nodoc
class __$ClaimCopyWithImpl<$Res>
    implements _$ClaimCopyWith<$Res> {
  __$ClaimCopyWithImpl(this._self, this._then);

  final _Claim _self;
  final $Res Function(_Claim) _then;

/// Create a copy of Claim
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? lostFoundId = null,Object? userId = null,Object? claimType = freezed,Object? description = freezed,Object? features = freezed,Object? contact = freezed,Object? proofImages = freezed,Object? expectTime = freezed,Object? status = null,Object? statusText = freezed,Object? remark = freezed,Object? reviewedBy = freezed,Object? reviewerNickname = freezed,Object? reviewedTime = freezed,Object? lostFoundTitle = freezed,Object? lostFoundLocation = freezed,Object? lostFoundImages = freezed,Object? applicantNickname = freezed,Object? applicantAvatar = freezed,Object? createTime = freezed,Object? updateTime = freezed,}) {
  return _then(_Claim(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,lostFoundId: null == lostFoundId ? _self.lostFoundId : lostFoundId // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,claimType: freezed == claimType ? _self.claimType : claimType // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,features: freezed == features ? _self.features : features // ignore: cast_nullable_to_non_nullable
as String?,contact: freezed == contact ? _self.contact : contact // ignore: cast_nullable_to_non_nullable
as String?,proofImages: freezed == proofImages ? _self._proofImages : proofImages // ignore: cast_nullable_to_non_nullable
as List<String>?,expectTime: freezed == expectTime ? _self.expectTime : expectTime // ignore: cast_nullable_to_non_nullable
as DateTime?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,statusText: freezed == statusText ? _self.statusText : statusText // ignore: cast_nullable_to_non_nullable
as String?,remark: freezed == remark ? _self.remark : remark // ignore: cast_nullable_to_non_nullable
as String?,reviewedBy: freezed == reviewedBy ? _self.reviewedBy : reviewedBy // ignore: cast_nullable_to_non_nullable
as int?,reviewerNickname: freezed == reviewerNickname ? _self.reviewerNickname : reviewerNickname // ignore: cast_nullable_to_non_nullable
as String?,reviewedTime: freezed == reviewedTime ? _self.reviewedTime : reviewedTime // ignore: cast_nullable_to_non_nullable
as DateTime?,lostFoundTitle: freezed == lostFoundTitle ? _self.lostFoundTitle : lostFoundTitle // ignore: cast_nullable_to_non_nullable
as String?,lostFoundLocation: freezed == lostFoundLocation ? _self.lostFoundLocation : lostFoundLocation // ignore: cast_nullable_to_non_nullable
as String?,lostFoundImages: freezed == lostFoundImages ? _self._lostFoundImages : lostFoundImages // ignore: cast_nullable_to_non_nullable
as List<String>?,applicantNickname: freezed == applicantNickname ? _self.applicantNickname : applicantNickname // ignore: cast_nullable_to_non_nullable
as String?,applicantAvatar: freezed == applicantAvatar ? _self.applicantAvatar : applicantAvatar // ignore: cast_nullable_to_non_nullable
as String?,createTime: freezed == createTime ? _self.createTime : createTime // ignore: cast_nullable_to_non_nullable
as DateTime?,updateTime: freezed == updateTime ? _self.updateTime : updateTime // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$CreateClaimRequest {

 int get lostFoundId; String get claimType; String get description; String? get features; String get contact; List<String>? get proofImages; DateTime? get expectTime;
/// Create a copy of CreateClaimRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateClaimRequestCopyWith<CreateClaimRequest> get copyWith => _$CreateClaimRequestCopyWithImpl<CreateClaimRequest>(this as CreateClaimRequest, _$identity);

  /// Serializes this CreateClaimRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateClaimRequest&&(identical(other.lostFoundId, lostFoundId) || other.lostFoundId == lostFoundId)&&(identical(other.claimType, claimType) || other.claimType == claimType)&&(identical(other.description, description) || other.description == description)&&(identical(other.features, features) || other.features == features)&&(identical(other.contact, contact) || other.contact == contact)&&const DeepCollectionEquality().equals(other.proofImages, proofImages)&&(identical(other.expectTime, expectTime) || other.expectTime == expectTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lostFoundId,claimType,description,features,contact,const DeepCollectionEquality().hash(proofImages),expectTime);

@override
String toString() {
  return 'CreateClaimRequest(lostFoundId: $lostFoundId, claimType: $claimType, description: $description, features: $features, contact: $contact, proofImages: $proofImages, expectTime: $expectTime)';
}


}

/// @nodoc
abstract mixin class $CreateClaimRequestCopyWith<$Res>  {
  factory $CreateClaimRequestCopyWith(CreateClaimRequest value, $Res Function(CreateClaimRequest) _then) = _$CreateClaimRequestCopyWithImpl;
@useResult
$Res call({
 int lostFoundId, String claimType, String description, String? features, String contact, List<String>? proofImages, DateTime? expectTime
});




}
/// @nodoc
class _$CreateClaimRequestCopyWithImpl<$Res>
    implements $CreateClaimRequestCopyWith<$Res> {
  _$CreateClaimRequestCopyWithImpl(this._self, this._then);

  final CreateClaimRequest _self;
  final $Res Function(CreateClaimRequest) _then;

/// Create a copy of CreateClaimRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lostFoundId = null,Object? claimType = null,Object? description = null,Object? features = freezed,Object? contact = null,Object? proofImages = freezed,Object? expectTime = freezed,}) {
  return _then(_self.copyWith(
lostFoundId: null == lostFoundId ? _self.lostFoundId : lostFoundId // ignore: cast_nullable_to_non_nullable
as int,claimType: null == claimType ? _self.claimType : claimType // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,features: freezed == features ? _self.features : features // ignore: cast_nullable_to_non_nullable
as String?,contact: null == contact ? _self.contact : contact // ignore: cast_nullable_to_non_nullable
as String,proofImages: freezed == proofImages ? _self.proofImages : proofImages // ignore: cast_nullable_to_non_nullable
as List<String>?,expectTime: freezed == expectTime ? _self.expectTime : expectTime // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateClaimRequest].
extension CreateClaimRequestPatterns on CreateClaimRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateClaimRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateClaimRequest() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateClaimRequest value)  $default,){
final _that = this;
switch (_that) {
case _CreateClaimRequest():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateClaimRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CreateClaimRequest() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int lostFoundId,  String claimType,  String description,  String? features,  String contact,  List<String>? proofImages,  DateTime? expectTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateClaimRequest() when $default != null:
return $default(_that.lostFoundId,_that.claimType,_that.description,_that.features,_that.contact,_that.proofImages,_that.expectTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int lostFoundId,  String claimType,  String description,  String? features,  String contact,  List<String>? proofImages,  DateTime? expectTime)  $default,) {final _that = this;
switch (_that) {
case _CreateClaimRequest():
return $default(_that.lostFoundId,_that.claimType,_that.description,_that.features,_that.contact,_that.proofImages,_that.expectTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int lostFoundId,  String claimType,  String description,  String? features,  String contact,  List<String>? proofImages,  DateTime? expectTime)?  $default,) {final _that = this;
switch (_that) {
case _CreateClaimRequest() when $default != null:
return $default(_that.lostFoundId,_that.claimType,_that.description,_that.features,_that.contact,_that.proofImages,_that.expectTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateClaimRequest implements CreateClaimRequest {
  const _CreateClaimRequest({required this.lostFoundId, required this.claimType, required this.description, this.features, required this.contact, final  List<String>? proofImages, this.expectTime}): _proofImages = proofImages;
  factory _CreateClaimRequest.fromJson(Map<String, dynamic> json) => _$CreateClaimRequestFromJson(json);

@override final  int lostFoundId;
@override final  String claimType;
@override final  String description;
@override final  String? features;
@override final  String contact;
 final  List<String>? _proofImages;
@override List<String>? get proofImages {
  final value = _proofImages;
  if (value == null) return null;
  if (_proofImages is EqualUnmodifiableListView) return _proofImages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  DateTime? expectTime;

/// Create a copy of CreateClaimRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateClaimRequestCopyWith<_CreateClaimRequest> get copyWith => __$CreateClaimRequestCopyWithImpl<_CreateClaimRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateClaimRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateClaimRequest&&(identical(other.lostFoundId, lostFoundId) || other.lostFoundId == lostFoundId)&&(identical(other.claimType, claimType) || other.claimType == claimType)&&(identical(other.description, description) || other.description == description)&&(identical(other.features, features) || other.features == features)&&(identical(other.contact, contact) || other.contact == contact)&&const DeepCollectionEquality().equals(other._proofImages, _proofImages)&&(identical(other.expectTime, expectTime) || other.expectTime == expectTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lostFoundId,claimType,description,features,contact,const DeepCollectionEquality().hash(_proofImages),expectTime);

@override
String toString() {
  return 'CreateClaimRequest(lostFoundId: $lostFoundId, claimType: $claimType, description: $description, features: $features, contact: $contact, proofImages: $proofImages, expectTime: $expectTime)';
}


}

/// @nodoc
abstract mixin class _$CreateClaimRequestCopyWith<$Res> implements $CreateClaimRequestCopyWith<$Res> {
  factory _$CreateClaimRequestCopyWith(_CreateClaimRequest value, $Res Function(_CreateClaimRequest) _then) = __$CreateClaimRequestCopyWithImpl;
@override @useResult
$Res call({
 int lostFoundId, String claimType, String description, String? features, String contact, List<String>? proofImages, DateTime? expectTime
});




}
/// @nodoc
class __$CreateClaimRequestCopyWithImpl<$Res>
    implements _$CreateClaimRequestCopyWith<$Res> {
  __$CreateClaimRequestCopyWithImpl(this._self, this._then);

  final _CreateClaimRequest _self;
  final $Res Function(_CreateClaimRequest) _then;

/// Create a copy of CreateClaimRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lostFoundId = null,Object? claimType = null,Object? description = null,Object? features = freezed,Object? contact = null,Object? proofImages = freezed,Object? expectTime = freezed,}) {
  return _then(_CreateClaimRequest(
lostFoundId: null == lostFoundId ? _self.lostFoundId : lostFoundId // ignore: cast_nullable_to_non_nullable
as int,claimType: null == claimType ? _self.claimType : claimType // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,features: freezed == features ? _self.features : features // ignore: cast_nullable_to_non_nullable
as String?,contact: null == contact ? _self.contact : contact // ignore: cast_nullable_to_non_nullable
as String,proofImages: freezed == proofImages ? _self._proofImages : proofImages // ignore: cast_nullable_to_non_nullable
as List<String>?,expectTime: freezed == expectTime ? _self.expectTime : expectTime // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$ReviewClaimRequest {

 String get action; String? get remark;
/// Create a copy of ReviewClaimRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReviewClaimRequestCopyWith<ReviewClaimRequest> get copyWith => _$ReviewClaimRequestCopyWithImpl<ReviewClaimRequest>(this as ReviewClaimRequest, _$identity);

  /// Serializes this ReviewClaimRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReviewClaimRequest&&(identical(other.action, action) || other.action == action)&&(identical(other.remark, remark) || other.remark == remark));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,action,remark);

@override
String toString() {
  return 'ReviewClaimRequest(action: $action, remark: $remark)';
}


}

/// @nodoc
abstract mixin class $ReviewClaimRequestCopyWith<$Res>  {
  factory $ReviewClaimRequestCopyWith(ReviewClaimRequest value, $Res Function(ReviewClaimRequest) _then) = _$ReviewClaimRequestCopyWithImpl;
@useResult
$Res call({
 String action, String? remark
});




}
/// @nodoc
class _$ReviewClaimRequestCopyWithImpl<$Res>
    implements $ReviewClaimRequestCopyWith<$Res> {
  _$ReviewClaimRequestCopyWithImpl(this._self, this._then);

  final ReviewClaimRequest _self;
  final $Res Function(ReviewClaimRequest) _then;

/// Create a copy of ReviewClaimRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? action = null,Object? remark = freezed,}) {
  return _then(_self.copyWith(
action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as String,remark: freezed == remark ? _self.remark : remark // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ReviewClaimRequest].
extension ReviewClaimRequestPatterns on ReviewClaimRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReviewClaimRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReviewClaimRequest() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReviewClaimRequest value)  $default,){
final _that = this;
switch (_that) {
case _ReviewClaimRequest():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReviewClaimRequest value)?  $default,){
final _that = this;
switch (_that) {
case _ReviewClaimRequest() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String action,  String? remark)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReviewClaimRequest() when $default != null:
return $default(_that.action,_that.remark);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String action,  String? remark)  $default,) {final _that = this;
switch (_that) {
case _ReviewClaimRequest():
return $default(_that.action,_that.remark);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String action,  String? remark)?  $default,) {final _that = this;
switch (_that) {
case _ReviewClaimRequest() when $default != null:
return $default(_that.action,_that.remark);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReviewClaimRequest implements ReviewClaimRequest {
  const _ReviewClaimRequest({required this.action, this.remark});
  factory _ReviewClaimRequest.fromJson(Map<String, dynamic> json) => _$ReviewClaimRequestFromJson(json);

@override final  String action;
@override final  String? remark;

/// Create a copy of ReviewClaimRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReviewClaimRequestCopyWith<_ReviewClaimRequest> get copyWith => __$ReviewClaimRequestCopyWithImpl<_ReviewClaimRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReviewClaimRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReviewClaimRequest&&(identical(other.action, action) || other.action == action)&&(identical(other.remark, remark) || other.remark == remark));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,action,remark);

@override
String toString() {
  return 'ReviewClaimRequest(action: $action, remark: $remark)';
}


}

/// @nodoc
abstract mixin class _$ReviewClaimRequestCopyWith<$Res> implements $ReviewClaimRequestCopyWith<$Res> {
  factory _$ReviewClaimRequestCopyWith(_ReviewClaimRequest value, $Res Function(_ReviewClaimRequest) _then) = __$ReviewClaimRequestCopyWithImpl;
@override @useResult
$Res call({
 String action, String? remark
});




}
/// @nodoc
class __$ReviewClaimRequestCopyWithImpl<$Res>
    implements _$ReviewClaimRequestCopyWith<$Res> {
  __$ReviewClaimRequestCopyWithImpl(this._self, this._then);

  final _ReviewClaimRequest _self;
  final $Res Function(_ReviewClaimRequest) _then;

/// Create a copy of ReviewClaimRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? action = null,Object? remark = freezed,}) {
  return _then(_ReviewClaimRequest(
action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as String,remark: freezed == remark ? _self.remark : remark // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
