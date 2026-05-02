// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lost_found.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LostFoundItem {

 int get id; int get userId; int get categoryId; String get itemType; String? get categoryName; String get title; String get description; List<String>? get images; String? get features; String get location; double? get latitude; double? get longitude; DateTime? get happenedTime; String? get campus; String get status; String? get statusText; int? get claimedBy; String? get claimedByNickname; DateTime? get claimedTime; DateTime? get closedTime; String? get closeReason; String? get publisherNickname; String? get publisherAvatar; int? get viewCount; int? get favoriteCount; int? get claimCount; bool? get favorited; DateTime? get createTime; DateTime? get updateTime;
/// Create a copy of LostFoundItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LostFoundItemCopyWith<LostFoundItem> get copyWith => _$LostFoundItemCopyWithImpl<LostFoundItem>(this as LostFoundItem, _$identity);

  /// Serializes this LostFoundItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LostFoundItem&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.itemType, itemType) || other.itemType == itemType)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.images, images)&&(identical(other.features, features) || other.features == features)&&(identical(other.location, location) || other.location == location)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.happenedTime, happenedTime) || other.happenedTime == happenedTime)&&(identical(other.campus, campus) || other.campus == campus)&&(identical(other.status, status) || other.status == status)&&(identical(other.statusText, statusText) || other.statusText == statusText)&&(identical(other.claimedBy, claimedBy) || other.claimedBy == claimedBy)&&(identical(other.claimedByNickname, claimedByNickname) || other.claimedByNickname == claimedByNickname)&&(identical(other.claimedTime, claimedTime) || other.claimedTime == claimedTime)&&(identical(other.closedTime, closedTime) || other.closedTime == closedTime)&&(identical(other.closeReason, closeReason) || other.closeReason == closeReason)&&(identical(other.publisherNickname, publisherNickname) || other.publisherNickname == publisherNickname)&&(identical(other.publisherAvatar, publisherAvatar) || other.publisherAvatar == publisherAvatar)&&(identical(other.viewCount, viewCount) || other.viewCount == viewCount)&&(identical(other.favoriteCount, favoriteCount) || other.favoriteCount == favoriteCount)&&(identical(other.claimCount, claimCount) || other.claimCount == claimCount)&&(identical(other.favorited, favorited) || other.favorited == favorited)&&(identical(other.createTime, createTime) || other.createTime == createTime)&&(identical(other.updateTime, updateTime) || other.updateTime == updateTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,userId,categoryId,itemType,categoryName,title,description,const DeepCollectionEquality().hash(images),features,location,latitude,longitude,happenedTime,campus,status,statusText,claimedBy,claimedByNickname,claimedTime,closedTime,closeReason,publisherNickname,publisherAvatar,viewCount,favoriteCount,claimCount,favorited,createTime,updateTime]);

@override
String toString() {
  return 'LostFoundItem(id: $id, userId: $userId, categoryId: $categoryId, itemType: $itemType, categoryName: $categoryName, title: $title, description: $description, images: $images, features: $features, location: $location, latitude: $latitude, longitude: $longitude, happenedTime: $happenedTime, campus: $campus, status: $status, statusText: $statusText, claimedBy: $claimedBy, claimedByNickname: $claimedByNickname, claimedTime: $claimedTime, closedTime: $closedTime, closeReason: $closeReason, publisherNickname: $publisherNickname, publisherAvatar: $publisherAvatar, viewCount: $viewCount, favoriteCount: $favoriteCount, claimCount: $claimCount, favorited: $favorited, createTime: $createTime, updateTime: $updateTime)';
}


}

/// @nodoc
abstract mixin class $LostFoundItemCopyWith<$Res>  {
  factory $LostFoundItemCopyWith(LostFoundItem value, $Res Function(LostFoundItem) _then) = _$LostFoundItemCopyWithImpl;
@useResult
$Res call({
 int id, int userId, int categoryId, String itemType, String? categoryName, String title, String description, List<String>? images, String? features, String location, double? latitude, double? longitude, DateTime? happenedTime, String? campus, String status, String? statusText, int? claimedBy, String? claimedByNickname, DateTime? claimedTime, DateTime? closedTime, String? closeReason, String? publisherNickname, String? publisherAvatar, int? viewCount, int? favoriteCount, int? claimCount, bool? favorited, DateTime? createTime, DateTime? updateTime
});




}
/// @nodoc
class _$LostFoundItemCopyWithImpl<$Res>
    implements $LostFoundItemCopyWith<$Res> {
  _$LostFoundItemCopyWithImpl(this._self, this._then);

  final LostFoundItem _self;
  final $Res Function(LostFoundItem) _then;

/// Create a copy of LostFoundItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? categoryId = null,Object? itemType = null,Object? categoryName = freezed,Object? title = null,Object? description = null,Object? images = freezed,Object? features = freezed,Object? location = null,Object? latitude = freezed,Object? longitude = freezed,Object? happenedTime = freezed,Object? campus = freezed,Object? status = null,Object? statusText = freezed,Object? claimedBy = freezed,Object? claimedByNickname = freezed,Object? claimedTime = freezed,Object? closedTime = freezed,Object? closeReason = freezed,Object? publisherNickname = freezed,Object? publisherAvatar = freezed,Object? viewCount = freezed,Object? favoriteCount = freezed,Object? claimCount = freezed,Object? favorited = freezed,Object? createTime = freezed,Object? updateTime = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int,itemType: null == itemType ? _self.itemType : itemType // ignore: cast_nullable_to_non_nullable
as String,categoryName: freezed == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,images: freezed == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as List<String>?,features: freezed == features ? _self.features : features // ignore: cast_nullable_to_non_nullable
as String?,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,happenedTime: freezed == happenedTime ? _self.happenedTime : happenedTime // ignore: cast_nullable_to_non_nullable
as DateTime?,campus: freezed == campus ? _self.campus : campus // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,statusText: freezed == statusText ? _self.statusText : statusText // ignore: cast_nullable_to_non_nullable
as String?,claimedBy: freezed == claimedBy ? _self.claimedBy : claimedBy // ignore: cast_nullable_to_non_nullable
as int?,claimedByNickname: freezed == claimedByNickname ? _self.claimedByNickname : claimedByNickname // ignore: cast_nullable_to_non_nullable
as String?,claimedTime: freezed == claimedTime ? _self.claimedTime : claimedTime // ignore: cast_nullable_to_non_nullable
as DateTime?,closedTime: freezed == closedTime ? _self.closedTime : closedTime // ignore: cast_nullable_to_non_nullable
as DateTime?,closeReason: freezed == closeReason ? _self.closeReason : closeReason // ignore: cast_nullable_to_non_nullable
as String?,publisherNickname: freezed == publisherNickname ? _self.publisherNickname : publisherNickname // ignore: cast_nullable_to_non_nullable
as String?,publisherAvatar: freezed == publisherAvatar ? _self.publisherAvatar : publisherAvatar // ignore: cast_nullable_to_non_nullable
as String?,viewCount: freezed == viewCount ? _self.viewCount : viewCount // ignore: cast_nullable_to_non_nullable
as int?,favoriteCount: freezed == favoriteCount ? _self.favoriteCount : favoriteCount // ignore: cast_nullable_to_non_nullable
as int?,claimCount: freezed == claimCount ? _self.claimCount : claimCount // ignore: cast_nullable_to_non_nullable
as int?,favorited: freezed == favorited ? _self.favorited : favorited // ignore: cast_nullable_to_non_nullable
as bool?,createTime: freezed == createTime ? _self.createTime : createTime // ignore: cast_nullable_to_non_nullable
as DateTime?,updateTime: freezed == updateTime ? _self.updateTime : updateTime // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [LostFoundItem].
extension LostFoundItemPatterns on LostFoundItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LostFoundItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LostFoundItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LostFoundItem value)  $default,){
final _that = this;
switch (_that) {
case _LostFoundItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LostFoundItem value)?  $default,){
final _that = this;
switch (_that) {
case _LostFoundItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int userId,  int categoryId,  String itemType,  String? categoryName,  String title,  String description,  List<String>? images,  String? features,  String location,  double? latitude,  double? longitude,  DateTime? happenedTime,  String? campus,  String status,  String? statusText,  int? claimedBy,  String? claimedByNickname,  DateTime? claimedTime,  DateTime? closedTime,  String? closeReason,  String? publisherNickname,  String? publisherAvatar,  int? viewCount,  int? favoriteCount,  int? claimCount,  bool? favorited,  DateTime? createTime,  DateTime? updateTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LostFoundItem() when $default != null:
return $default(_that.id,_that.userId,_that.categoryId,_that.itemType,_that.categoryName,_that.title,_that.description,_that.images,_that.features,_that.location,_that.latitude,_that.longitude,_that.happenedTime,_that.campus,_that.status,_that.statusText,_that.claimedBy,_that.claimedByNickname,_that.claimedTime,_that.closedTime,_that.closeReason,_that.publisherNickname,_that.publisherAvatar,_that.viewCount,_that.favoriteCount,_that.claimCount,_that.favorited,_that.createTime,_that.updateTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int userId,  int categoryId,  String itemType,  String? categoryName,  String title,  String description,  List<String>? images,  String? features,  String location,  double? latitude,  double? longitude,  DateTime? happenedTime,  String? campus,  String status,  String? statusText,  int? claimedBy,  String? claimedByNickname,  DateTime? claimedTime,  DateTime? closedTime,  String? closeReason,  String? publisherNickname,  String? publisherAvatar,  int? viewCount,  int? favoriteCount,  int? claimCount,  bool? favorited,  DateTime? createTime,  DateTime? updateTime)  $default,) {final _that = this;
switch (_that) {
case _LostFoundItem():
return $default(_that.id,_that.userId,_that.categoryId,_that.itemType,_that.categoryName,_that.title,_that.description,_that.images,_that.features,_that.location,_that.latitude,_that.longitude,_that.happenedTime,_that.campus,_that.status,_that.statusText,_that.claimedBy,_that.claimedByNickname,_that.claimedTime,_that.closedTime,_that.closeReason,_that.publisherNickname,_that.publisherAvatar,_that.viewCount,_that.favoriteCount,_that.claimCount,_that.favorited,_that.createTime,_that.updateTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int userId,  int categoryId,  String itemType,  String? categoryName,  String title,  String description,  List<String>? images,  String? features,  String location,  double? latitude,  double? longitude,  DateTime? happenedTime,  String? campus,  String status,  String? statusText,  int? claimedBy,  String? claimedByNickname,  DateTime? claimedTime,  DateTime? closedTime,  String? closeReason,  String? publisherNickname,  String? publisherAvatar,  int? viewCount,  int? favoriteCount,  int? claimCount,  bool? favorited,  DateTime? createTime,  DateTime? updateTime)?  $default,) {final _that = this;
switch (_that) {
case _LostFoundItem() when $default != null:
return $default(_that.id,_that.userId,_that.categoryId,_that.itemType,_that.categoryName,_that.title,_that.description,_that.images,_that.features,_that.location,_that.latitude,_that.longitude,_that.happenedTime,_that.campus,_that.status,_that.statusText,_that.claimedBy,_that.claimedByNickname,_that.claimedTime,_that.closedTime,_that.closeReason,_that.publisherNickname,_that.publisherAvatar,_that.viewCount,_that.favoriteCount,_that.claimCount,_that.favorited,_that.createTime,_that.updateTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LostFoundItem implements LostFoundItem {
  const _LostFoundItem({required this.id, required this.userId, required this.categoryId, required this.itemType, this.categoryName, required this.title, required this.description, final  List<String>? images, this.features, required this.location, this.latitude, this.longitude, this.happenedTime, this.campus, required this.status, this.statusText, this.claimedBy, this.claimedByNickname, this.claimedTime, this.closedTime, this.closeReason, this.publisherNickname, this.publisherAvatar, this.viewCount, this.favoriteCount, this.claimCount, this.favorited, this.createTime, this.updateTime}): _images = images;
  factory _LostFoundItem.fromJson(Map<String, dynamic> json) => _$LostFoundItemFromJson(json);

@override final  int id;
@override final  int userId;
@override final  int categoryId;
@override final  String itemType;
@override final  String? categoryName;
@override final  String title;
@override final  String description;
 final  List<String>? _images;
@override List<String>? get images {
  final value = _images;
  if (value == null) return null;
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? features;
@override final  String location;
@override final  double? latitude;
@override final  double? longitude;
@override final  DateTime? happenedTime;
@override final  String? campus;
@override final  String status;
@override final  String? statusText;
@override final  int? claimedBy;
@override final  String? claimedByNickname;
@override final  DateTime? claimedTime;
@override final  DateTime? closedTime;
@override final  String? closeReason;
@override final  String? publisherNickname;
@override final  String? publisherAvatar;
@override final  int? viewCount;
@override final  int? favoriteCount;
@override final  int? claimCount;
@override final  bool? favorited;
@override final  DateTime? createTime;
@override final  DateTime? updateTime;

/// Create a copy of LostFoundItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LostFoundItemCopyWith<_LostFoundItem> get copyWith => __$LostFoundItemCopyWithImpl<_LostFoundItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LostFoundItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LostFoundItem&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.itemType, itemType) || other.itemType == itemType)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._images, _images)&&(identical(other.features, features) || other.features == features)&&(identical(other.location, location) || other.location == location)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.happenedTime, happenedTime) || other.happenedTime == happenedTime)&&(identical(other.campus, campus) || other.campus == campus)&&(identical(other.status, status) || other.status == status)&&(identical(other.statusText, statusText) || other.statusText == statusText)&&(identical(other.claimedBy, claimedBy) || other.claimedBy == claimedBy)&&(identical(other.claimedByNickname, claimedByNickname) || other.claimedByNickname == claimedByNickname)&&(identical(other.claimedTime, claimedTime) || other.claimedTime == claimedTime)&&(identical(other.closedTime, closedTime) || other.closedTime == closedTime)&&(identical(other.closeReason, closeReason) || other.closeReason == closeReason)&&(identical(other.publisherNickname, publisherNickname) || other.publisherNickname == publisherNickname)&&(identical(other.publisherAvatar, publisherAvatar) || other.publisherAvatar == publisherAvatar)&&(identical(other.viewCount, viewCount) || other.viewCount == viewCount)&&(identical(other.favoriteCount, favoriteCount) || other.favoriteCount == favoriteCount)&&(identical(other.claimCount, claimCount) || other.claimCount == claimCount)&&(identical(other.favorited, favorited) || other.favorited == favorited)&&(identical(other.createTime, createTime) || other.createTime == createTime)&&(identical(other.updateTime, updateTime) || other.updateTime == updateTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,userId,categoryId,itemType,categoryName,title,description,const DeepCollectionEquality().hash(_images),features,location,latitude,longitude,happenedTime,campus,status,statusText,claimedBy,claimedByNickname,claimedTime,closedTime,closeReason,publisherNickname,publisherAvatar,viewCount,favoriteCount,claimCount,favorited,createTime,updateTime]);

@override
String toString() {
  return 'LostFoundItem(id: $id, userId: $userId, categoryId: $categoryId, itemType: $itemType, categoryName: $categoryName, title: $title, description: $description, images: $images, features: $features, location: $location, latitude: $latitude, longitude: $longitude, happenedTime: $happenedTime, campus: $campus, status: $status, statusText: $statusText, claimedBy: $claimedBy, claimedByNickname: $claimedByNickname, claimedTime: $claimedTime, closedTime: $closedTime, closeReason: $closeReason, publisherNickname: $publisherNickname, publisherAvatar: $publisherAvatar, viewCount: $viewCount, favoriteCount: $favoriteCount, claimCount: $claimCount, favorited: $favorited, createTime: $createTime, updateTime: $updateTime)';
}


}

/// @nodoc
abstract mixin class _$LostFoundItemCopyWith<$Res> implements $LostFoundItemCopyWith<$Res> {
  factory _$LostFoundItemCopyWith(_LostFoundItem value, $Res Function(_LostFoundItem) _then) = __$LostFoundItemCopyWithImpl;
@override @useResult
$Res call({
 int id, int userId, int categoryId, String itemType, String? categoryName, String title, String description, List<String>? images, String? features, String location, double? latitude, double? longitude, DateTime? happenedTime, String? campus, String status, String? statusText, int? claimedBy, String? claimedByNickname, DateTime? claimedTime, DateTime? closedTime, String? closeReason, String? publisherNickname, String? publisherAvatar, int? viewCount, int? favoriteCount, int? claimCount, bool? favorited, DateTime? createTime, DateTime? updateTime
});




}
/// @nodoc
class __$LostFoundItemCopyWithImpl<$Res>
    implements _$LostFoundItemCopyWith<$Res> {
  __$LostFoundItemCopyWithImpl(this._self, this._then);

  final _LostFoundItem _self;
  final $Res Function(_LostFoundItem) _then;

/// Create a copy of LostFoundItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? categoryId = null,Object? itemType = null,Object? categoryName = freezed,Object? title = null,Object? description = null,Object? images = freezed,Object? features = freezed,Object? location = null,Object? latitude = freezed,Object? longitude = freezed,Object? happenedTime = freezed,Object? campus = freezed,Object? status = null,Object? statusText = freezed,Object? claimedBy = freezed,Object? claimedByNickname = freezed,Object? claimedTime = freezed,Object? closedTime = freezed,Object? closeReason = freezed,Object? publisherNickname = freezed,Object? publisherAvatar = freezed,Object? viewCount = freezed,Object? favoriteCount = freezed,Object? claimCount = freezed,Object? favorited = freezed,Object? createTime = freezed,Object? updateTime = freezed,}) {
  return _then(_LostFoundItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int,itemType: null == itemType ? _self.itemType : itemType // ignore: cast_nullable_to_non_nullable
as String,categoryName: freezed == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,images: freezed == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<String>?,features: freezed == features ? _self.features : features // ignore: cast_nullable_to_non_nullable
as String?,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,happenedTime: freezed == happenedTime ? _self.happenedTime : happenedTime // ignore: cast_nullable_to_non_nullable
as DateTime?,campus: freezed == campus ? _self.campus : campus // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,statusText: freezed == statusText ? _self.statusText : statusText // ignore: cast_nullable_to_non_nullable
as String?,claimedBy: freezed == claimedBy ? _self.claimedBy : claimedBy // ignore: cast_nullable_to_non_nullable
as int?,claimedByNickname: freezed == claimedByNickname ? _self.claimedByNickname : claimedByNickname // ignore: cast_nullable_to_non_nullable
as String?,claimedTime: freezed == claimedTime ? _self.claimedTime : claimedTime // ignore: cast_nullable_to_non_nullable
as DateTime?,closedTime: freezed == closedTime ? _self.closedTime : closedTime // ignore: cast_nullable_to_non_nullable
as DateTime?,closeReason: freezed == closeReason ? _self.closeReason : closeReason // ignore: cast_nullable_to_non_nullable
as String?,publisherNickname: freezed == publisherNickname ? _self.publisherNickname : publisherNickname // ignore: cast_nullable_to_non_nullable
as String?,publisherAvatar: freezed == publisherAvatar ? _self.publisherAvatar : publisherAvatar // ignore: cast_nullable_to_non_nullable
as String?,viewCount: freezed == viewCount ? _self.viewCount : viewCount // ignore: cast_nullable_to_non_nullable
as int?,favoriteCount: freezed == favoriteCount ? _self.favoriteCount : favoriteCount // ignore: cast_nullable_to_non_nullable
as int?,claimCount: freezed == claimCount ? _self.claimCount : claimCount // ignore: cast_nullable_to_non_nullable
as int?,favorited: freezed == favorited ? _self.favorited : favorited // ignore: cast_nullable_to_non_nullable
as bool?,createTime: freezed == createTime ? _self.createTime : createTime // ignore: cast_nullable_to_non_nullable
as DateTime?,updateTime: freezed == updateTime ? _self.updateTime : updateTime // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$CreateLostFoundRequest {

 int get categoryId; String get itemType; String get title; String get description; List<String>? get images; String? get features; String get location; double? get latitude; double? get longitude; DateTime get happenedTime; String? get campus;
/// Create a copy of CreateLostFoundRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateLostFoundRequestCopyWith<CreateLostFoundRequest> get copyWith => _$CreateLostFoundRequestCopyWithImpl<CreateLostFoundRequest>(this as CreateLostFoundRequest, _$identity);

  /// Serializes this CreateLostFoundRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateLostFoundRequest&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.itemType, itemType) || other.itemType == itemType)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.images, images)&&(identical(other.features, features) || other.features == features)&&(identical(other.location, location) || other.location == location)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.happenedTime, happenedTime) || other.happenedTime == happenedTime)&&(identical(other.campus, campus) || other.campus == campus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,categoryId,itemType,title,description,const DeepCollectionEquality().hash(images),features,location,latitude,longitude,happenedTime,campus);

@override
String toString() {
  return 'CreateLostFoundRequest(categoryId: $categoryId, itemType: $itemType, title: $title, description: $description, images: $images, features: $features, location: $location, latitude: $latitude, longitude: $longitude, happenedTime: $happenedTime, campus: $campus)';
}


}

/// @nodoc
abstract mixin class $CreateLostFoundRequestCopyWith<$Res>  {
  factory $CreateLostFoundRequestCopyWith(CreateLostFoundRequest value, $Res Function(CreateLostFoundRequest) _then) = _$CreateLostFoundRequestCopyWithImpl;
@useResult
$Res call({
 int categoryId, String itemType, String title, String description, List<String>? images, String? features, String location, double? latitude, double? longitude, DateTime happenedTime, String? campus
});




}
/// @nodoc
class _$CreateLostFoundRequestCopyWithImpl<$Res>
    implements $CreateLostFoundRequestCopyWith<$Res> {
  _$CreateLostFoundRequestCopyWithImpl(this._self, this._then);

  final CreateLostFoundRequest _self;
  final $Res Function(CreateLostFoundRequest) _then;

/// Create a copy of CreateLostFoundRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? categoryId = null,Object? itemType = null,Object? title = null,Object? description = null,Object? images = freezed,Object? features = freezed,Object? location = null,Object? latitude = freezed,Object? longitude = freezed,Object? happenedTime = null,Object? campus = freezed,}) {
  return _then(_self.copyWith(
categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int,itemType: null == itemType ? _self.itemType : itemType // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,images: freezed == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as List<String>?,features: freezed == features ? _self.features : features // ignore: cast_nullable_to_non_nullable
as String?,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,happenedTime: null == happenedTime ? _self.happenedTime : happenedTime // ignore: cast_nullable_to_non_nullable
as DateTime,campus: freezed == campus ? _self.campus : campus // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateLostFoundRequest].
extension CreateLostFoundRequestPatterns on CreateLostFoundRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateLostFoundRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateLostFoundRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateLostFoundRequest value)  $default,){
final _that = this;
switch (_that) {
case _CreateLostFoundRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateLostFoundRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CreateLostFoundRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int categoryId,  String itemType,  String title,  String description,  List<String>? images,  String? features,  String location,  double? latitude,  double? longitude,  DateTime happenedTime,  String? campus)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateLostFoundRequest() when $default != null:
return $default(_that.categoryId,_that.itemType,_that.title,_that.description,_that.images,_that.features,_that.location,_that.latitude,_that.longitude,_that.happenedTime,_that.campus);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int categoryId,  String itemType,  String title,  String description,  List<String>? images,  String? features,  String location,  double? latitude,  double? longitude,  DateTime happenedTime,  String? campus)  $default,) {final _that = this;
switch (_that) {
case _CreateLostFoundRequest():
return $default(_that.categoryId,_that.itemType,_that.title,_that.description,_that.images,_that.features,_that.location,_that.latitude,_that.longitude,_that.happenedTime,_that.campus);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int categoryId,  String itemType,  String title,  String description,  List<String>? images,  String? features,  String location,  double? latitude,  double? longitude,  DateTime happenedTime,  String? campus)?  $default,) {final _that = this;
switch (_that) {
case _CreateLostFoundRequest() when $default != null:
return $default(_that.categoryId,_that.itemType,_that.title,_that.description,_that.images,_that.features,_that.location,_that.latitude,_that.longitude,_that.happenedTime,_that.campus);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateLostFoundRequest implements CreateLostFoundRequest {
  const _CreateLostFoundRequest({required this.categoryId, required this.itemType, required this.title, required this.description, final  List<String>? images, this.features, required this.location, this.latitude, this.longitude, required this.happenedTime, this.campus}): _images = images;
  factory _CreateLostFoundRequest.fromJson(Map<String, dynamic> json) => _$CreateLostFoundRequestFromJson(json);

@override final  int categoryId;
@override final  String itemType;
@override final  String title;
@override final  String description;
 final  List<String>? _images;
@override List<String>? get images {
  final value = _images;
  if (value == null) return null;
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? features;
@override final  String location;
@override final  double? latitude;
@override final  double? longitude;
@override final  DateTime happenedTime;
@override final  String? campus;

/// Create a copy of CreateLostFoundRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateLostFoundRequestCopyWith<_CreateLostFoundRequest> get copyWith => __$CreateLostFoundRequestCopyWithImpl<_CreateLostFoundRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateLostFoundRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateLostFoundRequest&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.itemType, itemType) || other.itemType == itemType)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._images, _images)&&(identical(other.features, features) || other.features == features)&&(identical(other.location, location) || other.location == location)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.happenedTime, happenedTime) || other.happenedTime == happenedTime)&&(identical(other.campus, campus) || other.campus == campus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,categoryId,itemType,title,description,const DeepCollectionEquality().hash(_images),features,location,latitude,longitude,happenedTime,campus);

@override
String toString() {
  return 'CreateLostFoundRequest(categoryId: $categoryId, itemType: $itemType, title: $title, description: $description, images: $images, features: $features, location: $location, latitude: $latitude, longitude: $longitude, happenedTime: $happenedTime, campus: $campus)';
}


}

/// @nodoc
abstract mixin class _$CreateLostFoundRequestCopyWith<$Res> implements $CreateLostFoundRequestCopyWith<$Res> {
  factory _$CreateLostFoundRequestCopyWith(_CreateLostFoundRequest value, $Res Function(_CreateLostFoundRequest) _then) = __$CreateLostFoundRequestCopyWithImpl;
@override @useResult
$Res call({
 int categoryId, String itemType, String title, String description, List<String>? images, String? features, String location, double? latitude, double? longitude, DateTime happenedTime, String? campus
});




}
/// @nodoc
class __$CreateLostFoundRequestCopyWithImpl<$Res>
    implements _$CreateLostFoundRequestCopyWith<$Res> {
  __$CreateLostFoundRequestCopyWithImpl(this._self, this._then);

  final _CreateLostFoundRequest _self;
  final $Res Function(_CreateLostFoundRequest) _then;

/// Create a copy of CreateLostFoundRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? categoryId = null,Object? itemType = null,Object? title = null,Object? description = null,Object? images = freezed,Object? features = freezed,Object? location = null,Object? latitude = freezed,Object? longitude = freezed,Object? happenedTime = null,Object? campus = freezed,}) {
  return _then(_CreateLostFoundRequest(
categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int,itemType: null == itemType ? _self.itemType : itemType // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,images: freezed == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<String>?,features: freezed == features ? _self.features : features // ignore: cast_nullable_to_non_nullable
as String?,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,happenedTime: null == happenedTime ? _self.happenedTime : happenedTime // ignore: cast_nullable_to_non_nullable
as DateTime,campus: freezed == campus ? _self.campus : campus // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$UpdateLostFoundRequest {

 int? get categoryId; String? get title; String? get description; List<String>? get images; String? get features; String? get location; double? get latitude; double? get longitude; DateTime? get happenedTime; String? get campus;
/// Create a copy of UpdateLostFoundRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateLostFoundRequestCopyWith<UpdateLostFoundRequest> get copyWith => _$UpdateLostFoundRequestCopyWithImpl<UpdateLostFoundRequest>(this as UpdateLostFoundRequest, _$identity);

  /// Serializes this UpdateLostFoundRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateLostFoundRequest&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.images, images)&&(identical(other.features, features) || other.features == features)&&(identical(other.location, location) || other.location == location)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.happenedTime, happenedTime) || other.happenedTime == happenedTime)&&(identical(other.campus, campus) || other.campus == campus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,categoryId,title,description,const DeepCollectionEquality().hash(images),features,location,latitude,longitude,happenedTime,campus);

@override
String toString() {
  return 'UpdateLostFoundRequest(categoryId: $categoryId, title: $title, description: $description, images: $images, features: $features, location: $location, latitude: $latitude, longitude: $longitude, happenedTime: $happenedTime, campus: $campus)';
}


}

/// @nodoc
abstract mixin class $UpdateLostFoundRequestCopyWith<$Res>  {
  factory $UpdateLostFoundRequestCopyWith(UpdateLostFoundRequest value, $Res Function(UpdateLostFoundRequest) _then) = _$UpdateLostFoundRequestCopyWithImpl;
@useResult
$Res call({
 int? categoryId, String? title, String? description, List<String>? images, String? features, String? location, double? latitude, double? longitude, DateTime? happenedTime, String? campus
});




}
/// @nodoc
class _$UpdateLostFoundRequestCopyWithImpl<$Res>
    implements $UpdateLostFoundRequestCopyWith<$Res> {
  _$UpdateLostFoundRequestCopyWithImpl(this._self, this._then);

  final UpdateLostFoundRequest _self;
  final $Res Function(UpdateLostFoundRequest) _then;

/// Create a copy of UpdateLostFoundRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? categoryId = freezed,Object? title = freezed,Object? description = freezed,Object? images = freezed,Object? features = freezed,Object? location = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? happenedTime = freezed,Object? campus = freezed,}) {
  return _then(_self.copyWith(
categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,images: freezed == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as List<String>?,features: freezed == features ? _self.features : features // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,happenedTime: freezed == happenedTime ? _self.happenedTime : happenedTime // ignore: cast_nullable_to_non_nullable
as DateTime?,campus: freezed == campus ? _self.campus : campus // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UpdateLostFoundRequest].
extension UpdateLostFoundRequestPatterns on UpdateLostFoundRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpdateLostFoundRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpdateLostFoundRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpdateLostFoundRequest value)  $default,){
final _that = this;
switch (_that) {
case _UpdateLostFoundRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpdateLostFoundRequest value)?  $default,){
final _that = this;
switch (_that) {
case _UpdateLostFoundRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? categoryId,  String? title,  String? description,  List<String>? images,  String? features,  String? location,  double? latitude,  double? longitude,  DateTime? happenedTime,  String? campus)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdateLostFoundRequest() when $default != null:
return $default(_that.categoryId,_that.title,_that.description,_that.images,_that.features,_that.location,_that.latitude,_that.longitude,_that.happenedTime,_that.campus);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? categoryId,  String? title,  String? description,  List<String>? images,  String? features,  String? location,  double? latitude,  double? longitude,  DateTime? happenedTime,  String? campus)  $default,) {final _that = this;
switch (_that) {
case _UpdateLostFoundRequest():
return $default(_that.categoryId,_that.title,_that.description,_that.images,_that.features,_that.location,_that.latitude,_that.longitude,_that.happenedTime,_that.campus);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? categoryId,  String? title,  String? description,  List<String>? images,  String? features,  String? location,  double? latitude,  double? longitude,  DateTime? happenedTime,  String? campus)?  $default,) {final _that = this;
switch (_that) {
case _UpdateLostFoundRequest() when $default != null:
return $default(_that.categoryId,_that.title,_that.description,_that.images,_that.features,_that.location,_that.latitude,_that.longitude,_that.happenedTime,_that.campus);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UpdateLostFoundRequest implements UpdateLostFoundRequest {
  const _UpdateLostFoundRequest({this.categoryId, this.title, this.description, final  List<String>? images, this.features, this.location, this.latitude, this.longitude, this.happenedTime, this.campus}): _images = images;
  factory _UpdateLostFoundRequest.fromJson(Map<String, dynamic> json) => _$UpdateLostFoundRequestFromJson(json);

@override final  int? categoryId;
@override final  String? title;
@override final  String? description;
 final  List<String>? _images;
@override List<String>? get images {
  final value = _images;
  if (value == null) return null;
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? features;
@override final  String? location;
@override final  double? latitude;
@override final  double? longitude;
@override final  DateTime? happenedTime;
@override final  String? campus;

/// Create a copy of UpdateLostFoundRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateLostFoundRequestCopyWith<_UpdateLostFoundRequest> get copyWith => __$UpdateLostFoundRequestCopyWithImpl<_UpdateLostFoundRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpdateLostFoundRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateLostFoundRequest&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._images, _images)&&(identical(other.features, features) || other.features == features)&&(identical(other.location, location) || other.location == location)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.happenedTime, happenedTime) || other.happenedTime == happenedTime)&&(identical(other.campus, campus) || other.campus == campus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,categoryId,title,description,const DeepCollectionEquality().hash(_images),features,location,latitude,longitude,happenedTime,campus);

@override
String toString() {
  return 'UpdateLostFoundRequest(categoryId: $categoryId, title: $title, description: $description, images: $images, features: $features, location: $location, latitude: $latitude, longitude: $longitude, happenedTime: $happenedTime, campus: $campus)';
}


}

/// @nodoc
abstract mixin class _$UpdateLostFoundRequestCopyWith<$Res> implements $UpdateLostFoundRequestCopyWith<$Res> {
  factory _$UpdateLostFoundRequestCopyWith(_UpdateLostFoundRequest value, $Res Function(_UpdateLostFoundRequest) _then) = __$UpdateLostFoundRequestCopyWithImpl;
@override @useResult
$Res call({
 int? categoryId, String? title, String? description, List<String>? images, String? features, String? location, double? latitude, double? longitude, DateTime? happenedTime, String? campus
});




}
/// @nodoc
class __$UpdateLostFoundRequestCopyWithImpl<$Res>
    implements _$UpdateLostFoundRequestCopyWith<$Res> {
  __$UpdateLostFoundRequestCopyWithImpl(this._self, this._then);

  final _UpdateLostFoundRequest _self;
  final $Res Function(_UpdateLostFoundRequest) _then;

/// Create a copy of UpdateLostFoundRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? categoryId = freezed,Object? title = freezed,Object? description = freezed,Object? images = freezed,Object? features = freezed,Object? location = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? happenedTime = freezed,Object? campus = freezed,}) {
  return _then(_UpdateLostFoundRequest(
categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,images: freezed == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<String>?,features: freezed == features ? _self.features : features // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,happenedTime: freezed == happenedTime ? _self.happenedTime : happenedTime // ignore: cast_nullable_to_non_nullable
as DateTime?,campus: freezed == campus ? _self.campus : campus // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
