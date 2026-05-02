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

 int get id; int get lostFoundId; int get applicantId; String get description; String? get applicantNickname; String? get applicantPhone; String? get features; String? get contactInfo; List<String>? get proofImages; String get status; String? get reviewerId; String? get reviewComment; DateTime? get reviewedTime; DateTime? get createTime; DateTime? get updateTime;
/// Create a copy of Claim
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClaimCopyWith<Claim> get copyWith => _$ClaimCopyWithImpl<Claim>(this as Claim, _$identity);

  /// Serializes this Claim to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Claim&&(identical(other.id, id) || other.id == id)&&(identical(other.lostFoundId, lostFoundId) || other.lostFoundId == lostFoundId)&&(identical(other.applicantId, applicantId) || other.applicantId == applicantId)&&(identical(other.description, description) || other.description == description)&&(identical(other.applicantNickname, applicantNickname) || other.applicantNickname == applicantNickname)&&(identical(other.applicantPhone, applicantPhone) || other.applicantPhone == applicantPhone)&&(identical(other.features, features) || other.features == features)&&(identical(other.contactInfo, contactInfo) || other.contactInfo == contactInfo)&&const DeepCollectionEquality().equals(other.proofImages, proofImages)&&(identical(other.status, status) || other.status == status)&&(identical(other.reviewerId, reviewerId) || other.reviewerId == reviewerId)&&(identical(other.reviewComment, reviewComment) || other.reviewComment == reviewComment)&&(identical(other.reviewedTime, reviewedTime) || other.reviewedTime == reviewedTime)&&(identical(other.createTime, createTime) || other.createTime == createTime)&&(identical(other.updateTime, updateTime) || other.updateTime == updateTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,lostFoundId,applicantId,description,applicantNickname,applicantPhone,features,contactInfo,const DeepCollectionEquality().hash(proofImages),status,reviewerId,reviewComment,reviewedTime,createTime,updateTime);

@override
String toString() {
  return 'Claim(id: $id, lostFoundId: $lostFoundId, applicantId: $applicantId, description: $description, applicantNickname: $applicantNickname, applicantPhone: $applicantPhone, features: $features, contactInfo: $contactInfo, proofImages: $proofImages, status: $status, reviewerId: $reviewerId, reviewComment: $reviewComment, reviewedTime: $reviewedTime, createTime: $createTime, updateTime: $updateTime)';
}


}

/// @nodoc
abstract mixin class $ClaimCopyWith<$Res>  {
  factory $ClaimCopyWith(Claim value, $Res Function(Claim) _then) = _$ClaimCopyWithImpl;
@useResult
$Res call({
 int id, int lostFoundId, int applicantId, String description, String? applicantNickname, String? applicantPhone, String? features, String? contactInfo, List<String>? proofImages, String status, String? reviewerId, String? reviewComment, DateTime? reviewedTime, DateTime? createTime, DateTime? updateTime
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? lostFoundId = null,Object? applicantId = null,Object? description = null,Object? applicantNickname = freezed,Object? applicantPhone = freezed,Object? features = freezed,Object? contactInfo = freezed,Object? proofImages = freezed,Object? status = null,Object? reviewerId = freezed,Object? reviewComment = freezed,Object? reviewedTime = freezed,Object? createTime = freezed,Object? updateTime = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,lostFoundId: null == lostFoundId ? _self.lostFoundId : lostFoundId // ignore: cast_nullable_to_non_nullable
as int,applicantId: null == applicantId ? _self.applicantId : applicantId // ignore: cast_nullable_to_non_nullable
as int,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,applicantNickname: freezed == applicantNickname ? _self.applicantNickname : applicantNickname // ignore: cast_nullable_to_non_nullable
as String?,applicantPhone: freezed == applicantPhone ? _self.applicantPhone : applicantPhone // ignore: cast_nullable_to_non_nullable
as String?,features: freezed == features ? _self.features : features // ignore: cast_nullable_to_non_nullable
as String?,contactInfo: freezed == contactInfo ? _self.contactInfo : contactInfo // ignore: cast_nullable_to_non_nullable
as String?,proofImages: freezed == proofImages ? _self.proofImages : proofImages // ignore: cast_nullable_to_non_nullable
as List<String>?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,reviewerId: freezed == reviewerId ? _self.reviewerId : reviewerId // ignore: cast_nullable_to_non_nullable
as String?,reviewComment: freezed == reviewComment ? _self.reviewComment : reviewComment // ignore: cast_nullable_to_non_nullable
as String?,reviewedTime: freezed == reviewedTime ? _self.reviewedTime : reviewedTime // ignore: cast_nullable_to_non_nullable
as DateTime?,createTime: freezed == createTime ? _self.createTime : createTime // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int lostFoundId,  int applicantId,  String description,  String? applicantNickname,  String? applicantPhone,  String? features,  String? contactInfo,  List<String>? proofImages,  String status,  String? reviewerId,  String? reviewComment,  DateTime? reviewedTime,  DateTime? createTime,  DateTime? updateTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Claim() when $default != null:
return $default(_that.id,_that.lostFoundId,_that.applicantId,_that.description,_that.applicantNickname,_that.applicantPhone,_that.features,_that.contactInfo,_that.proofImages,_that.status,_that.reviewerId,_that.reviewComment,_that.reviewedTime,_that.createTime,_that.updateTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int lostFoundId,  int applicantId,  String description,  String? applicantNickname,  String? applicantPhone,  String? features,  String? contactInfo,  List<String>? proofImages,  String status,  String? reviewerId,  String? reviewComment,  DateTime? reviewedTime,  DateTime? createTime,  DateTime? updateTime)  $default,) {final _that = this;
switch (_that) {
case _Claim():
return $default(_that.id,_that.lostFoundId,_that.applicantId,_that.description,_that.applicantNickname,_that.applicantPhone,_that.features,_that.contactInfo,_that.proofImages,_that.status,_that.reviewerId,_that.reviewComment,_that.reviewedTime,_that.createTime,_that.updateTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int lostFoundId,  int applicantId,  String description,  String? applicantNickname,  String? applicantPhone,  String? features,  String? contactInfo,  List<String>? proofImages,  String status,  String? reviewerId,  String? reviewComment,  DateTime? reviewedTime,  DateTime? createTime,  DateTime? updateTime)?  $default,) {final _that = this;
switch (_that) {
case _Claim() when $default != null:
return $default(_that.id,_that.lostFoundId,_that.applicantId,_that.description,_that.applicantNickname,_that.applicantPhone,_that.features,_that.contactInfo,_that.proofImages,_that.status,_that.reviewerId,_that.reviewComment,_that.reviewedTime,_that.createTime,_that.updateTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Claim implements Claim {
  const _Claim({required this.id, required this.lostFoundId, required this.applicantId, required this.description, this.applicantNickname, this.applicantPhone, this.features, this.contactInfo, final  List<String>? proofImages, required this.status, this.reviewerId, this.reviewComment, this.reviewedTime, this.createTime, this.updateTime}): _proofImages = proofImages;
  factory _Claim.fromJson(Map<String, dynamic> json) => _$ClaimFromJson(json);

@override final  int id;
@override final  int lostFoundId;
@override final  int applicantId;
@override final  String description;
@override final  String? applicantNickname;
@override final  String? applicantPhone;
@override final  String? features;
@override final  String? contactInfo;
 final  List<String>? _proofImages;
@override List<String>? get proofImages {
  final value = _proofImages;
  if (value == null) return null;
  if (_proofImages is EqualUnmodifiableListView) return _proofImages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String status;
@override final  String? reviewerId;
@override final  String? reviewComment;
@override final  DateTime? reviewedTime;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Claim&&(identical(other.id, id) || other.id == id)&&(identical(other.lostFoundId, lostFoundId) || other.lostFoundId == lostFoundId)&&(identical(other.applicantId, applicantId) || other.applicantId == applicantId)&&(identical(other.description, description) || other.description == description)&&(identical(other.applicantNickname, applicantNickname) || other.applicantNickname == applicantNickname)&&(identical(other.applicantPhone, applicantPhone) || other.applicantPhone == applicantPhone)&&(identical(other.features, features) || other.features == features)&&(identical(other.contactInfo, contactInfo) || other.contactInfo == contactInfo)&&const DeepCollectionEquality().equals(other._proofImages, _proofImages)&&(identical(other.status, status) || other.status == status)&&(identical(other.reviewerId, reviewerId) || other.reviewerId == reviewerId)&&(identical(other.reviewComment, reviewComment) || other.reviewComment == reviewComment)&&(identical(other.reviewedTime, reviewedTime) || other.reviewedTime == reviewedTime)&&(identical(other.createTime, createTime) || other.createTime == createTime)&&(identical(other.updateTime, updateTime) || other.updateTime == updateTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,lostFoundId,applicantId,description,applicantNickname,applicantPhone,features,contactInfo,const DeepCollectionEquality().hash(_proofImages),status,reviewerId,reviewComment,reviewedTime,createTime,updateTime);

@override
String toString() {
  return 'Claim(id: $id, lostFoundId: $lostFoundId, applicantId: $applicantId, description: $description, applicantNickname: $applicantNickname, applicantPhone: $applicantPhone, features: $features, contactInfo: $contactInfo, proofImages: $proofImages, status: $status, reviewerId: $reviewerId, reviewComment: $reviewComment, reviewedTime: $reviewedTime, createTime: $createTime, updateTime: $updateTime)';
}


}

/// @nodoc
abstract mixin class _$ClaimCopyWith<$Res> implements $ClaimCopyWith<$Res> {
  factory _$ClaimCopyWith(_Claim value, $Res Function(_Claim) _then) = __$ClaimCopyWithImpl;
@override @useResult
$Res call({
 int id, int lostFoundId, int applicantId, String description, String? applicantNickname, String? applicantPhone, String? features, String? contactInfo, List<String>? proofImages, String status, String? reviewerId, String? reviewComment, DateTime? reviewedTime, DateTime? createTime, DateTime? updateTime
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? lostFoundId = null,Object? applicantId = null,Object? description = null,Object? applicantNickname = freezed,Object? applicantPhone = freezed,Object? features = freezed,Object? contactInfo = freezed,Object? proofImages = freezed,Object? status = null,Object? reviewerId = freezed,Object? reviewComment = freezed,Object? reviewedTime = freezed,Object? createTime = freezed,Object? updateTime = freezed,}) {
  return _then(_Claim(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,lostFoundId: null == lostFoundId ? _self.lostFoundId : lostFoundId // ignore: cast_nullable_to_non_nullable
as int,applicantId: null == applicantId ? _self.applicantId : applicantId // ignore: cast_nullable_to_non_nullable
as int,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,applicantNickname: freezed == applicantNickname ? _self.applicantNickname : applicantNickname // ignore: cast_nullable_to_non_nullable
as String?,applicantPhone: freezed == applicantPhone ? _self.applicantPhone : applicantPhone // ignore: cast_nullable_to_non_nullable
as String?,features: freezed == features ? _self.features : features // ignore: cast_nullable_to_non_nullable
as String?,contactInfo: freezed == contactInfo ? _self.contactInfo : contactInfo // ignore: cast_nullable_to_non_nullable
as String?,proofImages: freezed == proofImages ? _self._proofImages : proofImages // ignore: cast_nullable_to_non_nullable
as List<String>?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,reviewerId: freezed == reviewerId ? _self.reviewerId : reviewerId // ignore: cast_nullable_to_non_nullable
as String?,reviewComment: freezed == reviewComment ? _self.reviewComment : reviewComment // ignore: cast_nullable_to_non_nullable
as String?,reviewedTime: freezed == reviewedTime ? _self.reviewedTime : reviewedTime // ignore: cast_nullable_to_non_nullable
as DateTime?,createTime: freezed == createTime ? _self.createTime : createTime // ignore: cast_nullable_to_non_nullable
as DateTime?,updateTime: freezed == updateTime ? _self.updateTime : updateTime // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$CreateClaimRequest {

 String get description; String? get features; String get contactInfo; List<String>? get proofImages;
/// Create a copy of CreateClaimRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateClaimRequestCopyWith<CreateClaimRequest> get copyWith => _$CreateClaimRequestCopyWithImpl<CreateClaimRequest>(this as CreateClaimRequest, _$identity);

  /// Serializes this CreateClaimRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateClaimRequest&&(identical(other.description, description) || other.description == description)&&(identical(other.features, features) || other.features == features)&&(identical(other.contactInfo, contactInfo) || other.contactInfo == contactInfo)&&const DeepCollectionEquality().equals(other.proofImages, proofImages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,description,features,contactInfo,const DeepCollectionEquality().hash(proofImages));

@override
String toString() {
  return 'CreateClaimRequest(description: $description, features: $features, contactInfo: $contactInfo, proofImages: $proofImages)';
}


}

/// @nodoc
abstract mixin class $CreateClaimRequestCopyWith<$Res>  {
  factory $CreateClaimRequestCopyWith(CreateClaimRequest value, $Res Function(CreateClaimRequest) _then) = _$CreateClaimRequestCopyWithImpl;
@useResult
$Res call({
 String description, String? features, String contactInfo, List<String>? proofImages
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
@pragma('vm:prefer-inline') @override $Res call({Object? description = null,Object? features = freezed,Object? contactInfo = null,Object? proofImages = freezed,}) {
  return _then(_self.copyWith(
description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,features: freezed == features ? _self.features : features // ignore: cast_nullable_to_non_nullable
as String?,contactInfo: null == contactInfo ? _self.contactInfo : contactInfo // ignore: cast_nullable_to_non_nullable
as String,proofImages: freezed == proofImages ? _self.proofImages : proofImages // ignore: cast_nullable_to_non_nullable
as List<String>?,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String description,  String? features,  String contactInfo,  List<String>? proofImages)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateClaimRequest() when $default != null:
return $default(_that.description,_that.features,_that.contactInfo,_that.proofImages);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String description,  String? features,  String contactInfo,  List<String>? proofImages)  $default,) {final _that = this;
switch (_that) {
case _CreateClaimRequest():
return $default(_that.description,_that.features,_that.contactInfo,_that.proofImages);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String description,  String? features,  String contactInfo,  List<String>? proofImages)?  $default,) {final _that = this;
switch (_that) {
case _CreateClaimRequest() when $default != null:
return $default(_that.description,_that.features,_that.contactInfo,_that.proofImages);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateClaimRequest implements CreateClaimRequest {
  const _CreateClaimRequest({required this.description, this.features, required this.contactInfo, final  List<String>? proofImages}): _proofImages = proofImages;
  factory _CreateClaimRequest.fromJson(Map<String, dynamic> json) => _$CreateClaimRequestFromJson(json);

@override final  String description;
@override final  String? features;
@override final  String contactInfo;
 final  List<String>? _proofImages;
@override List<String>? get proofImages {
  final value = _proofImages;
  if (value == null) return null;
  if (_proofImages is EqualUnmodifiableListView) return _proofImages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateClaimRequest&&(identical(other.description, description) || other.description == description)&&(identical(other.features, features) || other.features == features)&&(identical(other.contactInfo, contactInfo) || other.contactInfo == contactInfo)&&const DeepCollectionEquality().equals(other._proofImages, _proofImages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,description,features,contactInfo,const DeepCollectionEquality().hash(_proofImages));

@override
String toString() {
  return 'CreateClaimRequest(description: $description, features: $features, contactInfo: $contactInfo, proofImages: $proofImages)';
}


}

/// @nodoc
abstract mixin class _$CreateClaimRequestCopyWith<$Res> implements $CreateClaimRequestCopyWith<$Res> {
  factory _$CreateClaimRequestCopyWith(_CreateClaimRequest value, $Res Function(_CreateClaimRequest) _then) = __$CreateClaimRequestCopyWithImpl;
@override @useResult
$Res call({
 String description, String? features, String contactInfo, List<String>? proofImages
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
@override @pragma('vm:prefer-inline') $Res call({Object? description = null,Object? features = freezed,Object? contactInfo = null,Object? proofImages = freezed,}) {
  return _then(_CreateClaimRequest(
description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,features: freezed == features ? _self.features : features // ignore: cast_nullable_to_non_nullable
as String?,contactInfo: null == contactInfo ? _self.contactInfo : contactInfo // ignore: cast_nullable_to_non_nullable
as String,proofImages: freezed == proofImages ? _self._proofImages : proofImages // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}


}


/// @nodoc
mixin _$ReviewClaimRequest {

 String get status; String? get comment;
/// Create a copy of ReviewClaimRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReviewClaimRequestCopyWith<ReviewClaimRequest> get copyWith => _$ReviewClaimRequestCopyWithImpl<ReviewClaimRequest>(this as ReviewClaimRequest, _$identity);

  /// Serializes this ReviewClaimRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReviewClaimRequest&&(identical(other.status, status) || other.status == status)&&(identical(other.comment, comment) || other.comment == comment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,comment);

@override
String toString() {
  return 'ReviewClaimRequest(status: $status, comment: $comment)';
}


}

/// @nodoc
abstract mixin class $ReviewClaimRequestCopyWith<$Res>  {
  factory $ReviewClaimRequestCopyWith(ReviewClaimRequest value, $Res Function(ReviewClaimRequest) _then) = _$ReviewClaimRequestCopyWithImpl;
@useResult
$Res call({
 String status, String? comment
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
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? comment = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String status,  String? comment)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReviewClaimRequest() when $default != null:
return $default(_that.status,_that.comment);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String status,  String? comment)  $default,) {final _that = this;
switch (_that) {
case _ReviewClaimRequest():
return $default(_that.status,_that.comment);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String status,  String? comment)?  $default,) {final _that = this;
switch (_that) {
case _ReviewClaimRequest() when $default != null:
return $default(_that.status,_that.comment);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReviewClaimRequest implements ReviewClaimRequest {
  const _ReviewClaimRequest({required this.status, this.comment});
  factory _ReviewClaimRequest.fromJson(Map<String, dynamic> json) => _$ReviewClaimRequestFromJson(json);

@override final  String status;
@override final  String? comment;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReviewClaimRequest&&(identical(other.status, status) || other.status == status)&&(identical(other.comment, comment) || other.comment == comment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,comment);

@override
String toString() {
  return 'ReviewClaimRequest(status: $status, comment: $comment)';
}


}

/// @nodoc
abstract mixin class _$ReviewClaimRequestCopyWith<$Res> implements $ReviewClaimRequestCopyWith<$Res> {
  factory _$ReviewClaimRequestCopyWith(_ReviewClaimRequest value, $Res Function(_ReviewClaimRequest) _then) = __$ReviewClaimRequestCopyWithImpl;
@override @useResult
$Res call({
 String status, String? comment
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
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? comment = freezed,}) {
  return _then(_ReviewClaimRequest(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
