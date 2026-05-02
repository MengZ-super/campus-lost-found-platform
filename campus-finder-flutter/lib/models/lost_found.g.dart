// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lost_found.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LostFoundItem _$LostFoundItemFromJson(Map<String, dynamic> json) =>
    _LostFoundItem(
      id: (json['id'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
      categoryId: (json['categoryId'] as num).toInt(),
      itemType: json['itemType'] as String,
      categoryName: json['categoryName'] as String?,
      title: json['title'] as String,
      description: json['description'] as String,
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      features: json['features'] as String?,
      location: json['location'] as String,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      happenedTime: json['happenedTime'] == null
          ? null
          : DateTime.parse(json['happenedTime'] as String),
      campus: json['campus'] as String?,
      status: json['status'] as String,
      statusText: json['statusText'] as String?,
      claimedBy: (json['claimedBy'] as num?)?.toInt(),
      claimedByNickname: json['claimedByNickname'] as String?,
      claimedTime: json['claimedTime'] == null
          ? null
          : DateTime.parse(json['claimedTime'] as String),
      closedTime: json['closedTime'] == null
          ? null
          : DateTime.parse(json['closedTime'] as String),
      closeReason: json['closeReason'] as String?,
      publisherNickname: json['publisherNickname'] as String?,
      publisherAvatar: json['publisherAvatar'] as String?,
      viewCount: (json['viewCount'] as num?)?.toInt(),
      favoriteCount: (json['favoriteCount'] as num?)?.toInt(),
      claimCount: (json['claimCount'] as num?)?.toInt(),
      favorited: json['favorited'] as bool?,
      createTime: json['createTime'] == null
          ? null
          : DateTime.parse(json['createTime'] as String),
      updateTime: json['updateTime'] == null
          ? null
          : DateTime.parse(json['updateTime'] as String),
    );

Map<String, dynamic> _$LostFoundItemToJson(_LostFoundItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'categoryId': instance.categoryId,
      'itemType': instance.itemType,
      'categoryName': instance.categoryName,
      'title': instance.title,
      'description': instance.description,
      'images': instance.images,
      'features': instance.features,
      'location': instance.location,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'happenedTime': instance.happenedTime?.toIso8601String(),
      'campus': instance.campus,
      'status': instance.status,
      'statusText': instance.statusText,
      'claimedBy': instance.claimedBy,
      'claimedByNickname': instance.claimedByNickname,
      'claimedTime': instance.claimedTime?.toIso8601String(),
      'closedTime': instance.closedTime?.toIso8601String(),
      'closeReason': instance.closeReason,
      'publisherNickname': instance.publisherNickname,
      'publisherAvatar': instance.publisherAvatar,
      'viewCount': instance.viewCount,
      'favoriteCount': instance.favoriteCount,
      'claimCount': instance.claimCount,
      'favorited': instance.favorited,
      'createTime': instance.createTime?.toIso8601String(),
      'updateTime': instance.updateTime?.toIso8601String(),
    };

_CreateLostFoundRequest _$CreateLostFoundRequestFromJson(
  Map<String, dynamic> json,
) => _CreateLostFoundRequest(
  categoryId: (json['categoryId'] as num).toInt(),
  itemType: json['itemType'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  images: (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
  features: json['features'] as String?,
  location: json['location'] as String,
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  happenedTime: DateTime.parse(json['happenedTime'] as String),
  campus: json['campus'] as String?,
);

Map<String, dynamic> _$CreateLostFoundRequestToJson(
  _CreateLostFoundRequest instance,
) => <String, dynamic>{
  'categoryId': instance.categoryId,
  'itemType': instance.itemType,
  'title': instance.title,
  'description': instance.description,
  'images': instance.images,
  'features': instance.features,
  'location': instance.location,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'happenedTime': instance.happenedTime.toIso8601String(),
  'campus': instance.campus,
};

_UpdateLostFoundRequest _$UpdateLostFoundRequestFromJson(
  Map<String, dynamic> json,
) => _UpdateLostFoundRequest(
  categoryId: (json['categoryId'] as num?)?.toInt(),
  title: json['title'] as String?,
  description: json['description'] as String?,
  images: (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
  features: json['features'] as String?,
  location: json['location'] as String?,
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  happenedTime: json['happenedTime'] == null
      ? null
      : DateTime.parse(json['happenedTime'] as String),
  campus: json['campus'] as String?,
);

Map<String, dynamic> _$UpdateLostFoundRequestToJson(
  _UpdateLostFoundRequest instance,
) => <String, dynamic>{
  'categoryId': instance.categoryId,
  'title': instance.title,
  'description': instance.description,
  'images': instance.images,
  'features': instance.features,
  'location': instance.location,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'happenedTime': instance.happenedTime?.toIso8601String(),
  'campus': instance.campus,
};
