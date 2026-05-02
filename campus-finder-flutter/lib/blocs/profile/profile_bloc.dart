import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/user.dart';
import '../../services/user_service.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserService _userService;

  ProfileBloc({required UserService userService})
      : _userService = userService,
        super(const ProfileState.initial()) {
    on<LoadProfile>(_onLoadProfile);
    on<UpdateProfile>(_onUpdateProfile);
    on<ChangePassword>(_onChangePassword);
  }

  Future<void> _onLoadProfile(
      LoadProfile event, Emitter<ProfileState> emit) async {
    emit(const ProfileState.loading());
    try {
      final profile = await _userService.getProfile();
      emit(ProfileState.loaded(profile: profile));
    } catch (e) {
      emit(ProfileState.error(message: e.toString()));
    }
  }

  Future<void> _onUpdateProfile(
      UpdateProfile event, Emitter<ProfileState> emit) async {
    final currentState = state;
    UserProfile currentProfile;
    if (currentState is ProfileLoaded) {
      currentProfile = currentState.profile;
    } else if (currentState is ProfileSaving) {
      currentProfile = currentState.profile;
    } else {
      return;
    }

    emit(ProfileState.saving(profile: currentProfile));
    try {
      final updated = await _userService.updateProfile(event.request);
      emit(ProfileState.loaded(profile: updated));
    } catch (e) {
      emit(ProfileState.error(message: e.toString()));
    }
  }

  Future<void> _onChangePassword(
      ChangePassword event, Emitter<ProfileState> emit) async {
    emit(const ProfileState.passwordChangeLoading());
    try {
      await _userService.changePassword(event.request);
      emit(const ProfileState.passwordChangeSuccess());
    } catch (e) {
      emit(ProfileState.passwordChangeError(message: e.toString()));
    }
  }
}
