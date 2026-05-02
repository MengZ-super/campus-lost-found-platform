// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claim.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Claim _$ClaimFromJson(Map<String, dynamic> json) => _Claim(
  id: (json['id'] as num).toInt(),
  lostFoundId: (json['lostFoundId'] as num).toInt(),
  applicantId: (json['applicantId'] as num).toInt(),
  description: json['description'] as String,
  applicantNickname: json['applicantNickname'] as String?,
  applicantPhone: json['applicantPhone'] as String?,
  features: json['features'] as String?,
  contactInfo: json['contactInfo'] as String?,
  proofImages: (json['proofImages'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  status: json['status'] as String,
  reviewerId: json['reviewerId'] as String?,
  reviewComment: json['reviewComment'] as String?,
  reviewedTime: json['reviewedTime'] == null
      ? null
      : DateTime.parse(json['reviewedTime'] as String),
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
  'applicantId': instance.applicantId,
  'description': instance.description,
  'applicantNickname': instance.applicantNickname,
  'applicantPhone': instance.applicantPhone,
  'features': instance.features,
  'contactInfo': instance.contactInfo,
  'proofImages': instance.proofImages,
  'status': instance.status,
  'reviewerId': instance.reviewerId,
  'reviewComment': instance.reviewComment,
  'reviewedTime': instance.reviewedTime?.toIso8601String(),
  'createTime': instance.createTime?.toIso8601String(),
  'updateTime': instance.updateTime?.toIso8601String(),
};

_CreateClaimRequest _$CreateClaimRequestFromJson(Map<String, dynamic> json) =>
    _CreateClaimRequest(
      description: json['description'] as String,
      features: json['features'] as String?,
      contactInfo: json['contactInfo'] as String,
      proofImages: (json['proofImages'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$CreateClaimRequestToJson(_CreateClaimRequest instance) =>
    <String, dynamic>{
      'description': instance.description,
      'features': instance.features,
      'contactInfo': instance.contactInfo,
      'proofImages': instance.proofImages,
    };

_ReviewClaimRequest _$ReviewClaimRequestFromJson(Map<String, dynamic> json) =>
    _ReviewClaimRequest(
      status: json['status'] as String,
      comment: json['comment'] as String?,
    );

Map<String, dynamic> _$ReviewClaimRequestToJson(_ReviewClaimRequest instance) =>
    <String, dynamic>{'status': instance.status, 'comment': instance.comment};
