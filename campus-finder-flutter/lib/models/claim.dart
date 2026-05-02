import 'package:freezed_annotation/freezed_annotation.dart';

part 'claim.freezed.dart';
part 'claim.g.dart';

@freezed
abstract class Claim with _$Claim {
  const factory Claim({
    required int id,
    required int lostFoundId,
    required int userId,
    String? claimType,
    String? description,
    String? features,
    String? contact,
    List<String>? proofImages,
    DateTime? expectTime,
    required String status,
    String? statusText,
    String? remark,
    int? reviewedBy,
    String? reviewerNickname,
    DateTime? reviewedTime,
    String? lostFoundTitle,
    String? lostFoundLocation,
    List<String>? lostFoundImages,
    String? applicantNickname,
    String? applicantAvatar,
    DateTime? createTime,
    DateTime? updateTime,
  }) = _Claim;

  factory Claim.fromJson(Map<String, dynamic> json) => _$ClaimFromJson(json);
}

@freezed
abstract class CreateClaimRequest with _$CreateClaimRequest {
  const factory CreateClaimRequest({
    required int lostFoundId,
    required String claimType,
    required String description,
    String? features,
    required String contact,
    List<String>? proofImages,
    DateTime? expectTime,
  }) = _CreateClaimRequest;

  factory CreateClaimRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateClaimRequestFromJson(json);

  @override
  Map<String, dynamic> toJson() => {
        'lostFoundId': lostFoundId,
        'claimType': claimType,
        'description': description,
        if (features != null) 'features': features,
        'contact': contact,
        if (proofImages != null) 'proofImages': proofImages,
        if (expectTime != null)
          'expectTime':
              expectTime!.toIso8601String().split('.').first.replaceAll('T', ' '),
      };
}

@freezed
abstract class ReviewClaimRequest with _$ReviewClaimRequest {
  const factory ReviewClaimRequest({
    required String action,
    String? remark,
  }) = _ReviewClaimRequest;

  factory ReviewClaimRequest.fromJson(Map<String, dynamic> json) =>
      _$ReviewClaimRequestFromJson(json);

  @override
  Map<String, dynamic> toJson() => {
        'action': action,
        if (remark != null) 'remark': remark,
      };
}
