import 'package:freezed_annotation/freezed_annotation.dart';
import '../../models/claim.dart';

part 'claim_event.freezed.dart';

@freezed
abstract class ClaimEvent with _$ClaimEvent {
  const factory ClaimEvent.loadClaims({required int lostFoundId}) = LoadClaims;
  const factory ClaimEvent.submitClaim({
    required CreateClaimRequest request,
  }) = SubmitClaim;
  const factory ClaimEvent.reviewClaim({
    required int claimId,
    required String action,
    String? remark,
  }) = ReviewClaim;
  const factory ClaimEvent.cancelClaim({required int claimId}) = CancelClaim;
}
