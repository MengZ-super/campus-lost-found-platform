import 'package:freezed_annotation/freezed_annotation.dart';
import '../../models/claim.dart';

part 'claim_state.freezed.dart';

@freezed
abstract class ClaimState with _$ClaimState {
  const factory ClaimState.initial() = ClaimInitial;
  const factory ClaimState.loading() = ClaimLoading;
  const factory ClaimState.claimsLoaded({required List<Claim> claims}) =
      ClaimsLoaded;
  const factory ClaimState.submitting() = ClaimSubmitting;
  const factory ClaimState.submitted({required Claim claim}) = ClaimSubmitted;
  const factory ClaimState.error({required String message}) = ClaimError;
}
