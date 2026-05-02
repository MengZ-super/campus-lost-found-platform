import 'package:freezed_annotation/freezed_annotation.dart';

part 'claim.freezed.dart';
part 'claim.g.dart';

@freezed
abstract class Claim with _$Claim {
  const factory Claim({
    required int id,
    required int lostFoundId,
    required int applicantId,
    required String description,
    String? applicantNickname,
    String? applicantPhone,
    String? features,
    String? contactInfo,
    List<String>? proofImages,
    required String status,
    String? reviewerId,
    String? reviewComment,
    DateTime? reviewedTime,
    DateTime? createTime,
    DateTime? updateTime,
  }) = _Claim;

  factory Claim.fromJson(Map<String, dynamic> json) => _$ClaimFromJson(json);
}

@freezed
abstract class CreateClaimRequest with _$CreateClaimRequest {
  const factory CreateClaimRequest({
    required String description,
    String? features,
    required String contactInfo,
    List<String>? proofImages,
  }) = _CreateClaimRequest;

  factory CreateClaimRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateClaimRequestFromJson(json);

  @override
  Map<String, dynamic> toJson() => {
        'description': description,
        if (features != null) 'features': features,
        'contactInfo': contactInfo,
        if (proofImages != null) 'proofImages': proofImages,
      };
}

@freezed
abstract class ReviewClaimRequest with _$ReviewClaimRequest {
  const factory ReviewClaimRequest({
    required String status,
    String? comment,
  }) = _ReviewClaimRequest;

  factory ReviewClaimRequest.fromJson(Map<String, dynamic> json) =>
      _$ReviewClaimRequestFromJson(json);

  @override
  Map<String, dynamic> toJson() => {
        'status': status,
        if (comment != null) 'comment': comment,
      };
}
