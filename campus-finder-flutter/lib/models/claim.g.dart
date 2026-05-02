// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claim.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Claim _$ClaimFromJson(Map<String, dynamic> json) => _Claim(
  id: (json['id'] as num).toInt(),
  lostFoundId: (json['lostFoundId'] as num).toInt(),
  userId: (json['userId'] as num).toInt(),
  claimType: json['claimType'] as String?,
  description: json['description'] as String?,
  features: json['features'] as String?,
  contact: json['contact'] as String?,
  proofImages: (json['proofImages'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  expectTime: json['expectTime'] == null
      ? null
      : DateTime.parse(json['expectTime'] as String),
  status: json['status'] as String,
  statusText: json['statusText'] as String?,
  remark: json['remark'] as String?,
  reviewedBy: (json['reviewedBy'] as num?)?.toInt(),
  reviewerNickname: json['reviewerNickname'] as String?,
  reviewedTime: json['reviewedTime'] == null
      ? null
      : DateTime.parse(json['reviewedTime'] as String),
  lostFoundTitle: json['lostFoundTitle'] as String?,
  lostFoundLocation: json['lostFoundLocation'] as String?,
  lostFoundImages: (json['lostFoundImages'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  applicantNickname: json['applicantNickname'] as String?,
  applicantAvatar: json['applicantAvatar'] as String?,
  createTime: json['createTime'] == null
      ? null
      : DateTime.parse(json['createTime'] as String),
  updateTime: json['updateTime'] == null
      ? null
      : DateTime.parse(json['updateTime'] as String),
);

Map<String, dynamic> _$ClaimToJson(_Claim instance) => <String, dynamic>{
  'id': instance.id,
  'lostFoundId': instance.lostFoundId,
  'userId': instance.userId,
  'claimType': instance.claimType,
  'description': instance.description,
  'features': instance.features,
  'contact': instance.contact,
  'proofImages': instance.proofImages,
  'expectTime': instance.expectTime?.toIso8601String(),
  'status': instance.status,
  'statusText': instance.statusText,
  'remark': instance.remark,
  'reviewedBy': instance.reviewedBy,
  'reviewerNickname': instance.reviewerNickname,
  'reviewedTime': instance.reviewedTime?.toIso8601String(),
  'lostFoundTitle': instance.lostFoundTitle,
  'lostFoundLocation': instance.lostFoundLocation,
  'lostFoundImages': instance.lostFoundImages,
  'applicantNickname': instance.applicantNickname,
  'applicantAvatar': instance.applicantAvatar,
  'createTime': instance.createTime?.toIso8601String(),
  'updateTime': instance.updateTime?.toIso8601String(),
};

_CreateClaimRequest _$CreateClaimRequestFromJson(Map<String, dynamic> json) =>
    _CreateClaimRequest(
      lostFoundId: (json['lostFoundId'] as num).toInt(),
      claimType: json['claimType'] as String,
      description: json['description'] as String,
      features: json['features'] as String?,
      contact: json['contact'] as String,
      proofImages: (json['proofImages'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      expectTime: json['expectTime'] == null
          ? null
          : DateTime.parse(json['expectTime'] as String),
    );

Map<String, dynamic> _$CreateClaimRequestToJson(_CreateClaimRequest instance) =>
    <String, dynamic>{
      'lostFoundId': instance.lostFoundId,
      'claimType': instance.claimType,
      'description': instance.description,
      'features': instance.features,
      'contact': instance.contact,
      'proofImages': instance.proofImages,
      'expectTime': instance.expectTime?.toIso8601String(),
    };

_ReviewClaimRequest _$ReviewClaimRequestFromJson(Map<String, dynamic> json) =>
    _ReviewClaimRequest(
      action: json['action'] as String,
      remark: json['remark'] as String?,
    );

Map<String, dynamic> _$ReviewClaimRequestToJson(_ReviewClaimRequest instance) =>
    <String, dynamic>{'action': instance.action, 'remark': instance.remark};
