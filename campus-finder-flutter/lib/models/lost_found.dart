import 'package:freezed_annotation/freezed_annotation.dart';

part 'lost_found.freezed.dart';
part 'lost_found.g.dart';

@freezed
abstract class LostFoundItem with _$LostFoundItem {
  const factory LostFoundItem({
    required int id,
    required int userId,
    required int categoryId,
    required String itemType,
    String? categoryName,
    required String title,
    required String description,
    List<String>? images,
    String? features,
    required String location,
    double? latitude,
    double? longitude,
    DateTime? happenedTime,
    String? campus,
    required String status,
    String? statusText,
    int? claimedBy,
    String? claimedByNickname,
    DateTime? claimedTime,
    DateTime? closedTime,
    String? closeReason,
    String? publisherNickname,
    String? publisherAvatar,
    int? viewCount,
    int? favoriteCount,
    int? claimCount,
    bool? favorited,
    DateTime? createTime,
    DateTime? updateTime,
  }) = _LostFoundItem;

  factory LostFoundItem.fromJson(Map<String, dynamic> json) =>
      _$LostFoundItemFromJson(json);
}

@freezed
abstract class CreateLostFoundRequest with _$CreateLostFoundRequest {
  const factory CreateLostFoundRequest({
    required int categoryId,
    required String itemType,
    required String title,
    required String description,
    List<String>? images,
    String? features,
    required String location,
    double? latitude,
    double? longitude,
    required DateTime happenedTime,
    String? campus,
  }) = _CreateLostFoundRequest;

  factory CreateLostFoundRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateLostFoundRequestFromJson(json);

  @override
  Map<String, dynamic> toJson() => {
        'categoryId': categoryId,
        'itemType': itemType,
        'title': title,
        'description': description,
        if (images != null) 'images': images,
        if (features != null) 'features': features,
        'location': location,
        if (latitude != null) 'latitude': latitude,
        if (longitude != null) 'longitude': longitude,
        'happenedTime':
            happenedTime.toIso8601String().split('.').first.replaceAll('T', ' '),
        if (campus != null) 'campus': campus,
      };
}

@freezed
abstract class UpdateLostFoundRequest with _$UpdateLostFoundRequest {
  const factory UpdateLostFoundRequest({
    int? categoryId,
    String? title,
    String? description,
    List<String>? images,
    String? features,
    String? location,
    double? latitude,
    double? longitude,
    DateTime? happenedTime,
    String? campus,
  }) = _UpdateLostFoundRequest;

  factory UpdateLostFoundRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateLostFoundRequestFromJson(json);

  @override
  Map<String, dynamic> toJson() => {
        if (categoryId != null) 'categoryId': categoryId,
        if (title != null) 'title': title,
        if (description != null) 'description': description,
        if (images != null) 'images': images,
        if (features != null) 'features': features,
        if (location != null) 'location': location,
        if (latitude != null) 'latitude': latitude,
        if (longitude != null) 'longitude': longitude,
        if (happenedTime != null)
          'happenedTime':
              happenedTime!.toIso8601String().split('.').first.replaceAll('T', ' '),
        if (campus != null) 'campus': campus,
      };
}
