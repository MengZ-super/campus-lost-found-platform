import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/claim.dart';
import '../../services/claim_service.dart';
import 'claim_event.dart';
import 'claim_state.dart';

class ClaimBloc extends Bloc<ClaimEvent, ClaimState> {
  final ClaimService _service;
  int? _lostFoundId;

  ClaimBloc({required ClaimService service})
      : _service = service,
        super(const ClaimState.initial()) {
    on<LoadClaims>(_onLoadClaims);
    on<SubmitClaim>(_onSubmitClaim);
    on<ReviewClaim>(_onReviewClaim);
    on<CancelClaim>(_onCancelClaim);
  }

  Future<void> _onLoadClaims(
      LoadClaims event, Emitter<ClaimState> emit) async {
    _lostFoundId = event.lostFoundId;
    emit(const ClaimState.loading());
    try {
      final claims = await _service.listByLostFound(event.lostFoundId);
      emit(ClaimState.claimsLoaded(claims: claims));
    } catch (e) {
      emit(ClaimState.error(message: e.toString()));
    }
  }

  Future<void> _onSubmitClaim(
      SubmitClaim event, Emitter<ClaimState> emit) async {
    emit(const ClaimState.submitting());
    try {
      final claim = await _service.apply(event.request);
      emit(ClaimState.submitted(claim: claim));
    } catch (e) {
      emit(ClaimState.error(message: e.toString()));
    }
  }

  Future<void> _onReviewClaim(
      ReviewClaim event, Emitter<ClaimState> emit) async {
    try {
      await _service.review(
        event.claimId,
        ReviewClaimRequest(action: event.action, remark: event.remark),
      );
      // Reload claims after review
      if (_lostFoundId != null) {
        final claims = await _service.listByLostFound(_lostFoundId!);
        emit(ClaimState.claimsLoaded(claims: claims));
      }
    } catch (e) {
      emit(ClaimState.error(message: e.toString()));
    }
  }

  Future<void> _onCancelClaim(
      CancelClaim event, Emitter<ClaimState> emit) async {
    try {
      await _service.cancel(event.claimId);
      if (_lostFoundId != null) {
        final claims = await _service.listByLostFound(_lostFoundId!);
        emit(ClaimState.claimsLoaded(claims: claims));
      }
    } catch (e) {
      emit(ClaimState.error(message: e.toString()));
    }
  }
}
