import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/auth_service.dart';
import '../../services/token_storage.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;
  final SecureStorage _storage;

  AuthBloc({
    required AuthService authService,
    required SecureStorage storage,
  })  : _authService = authService,
        _storage = storage,
        super(const AuthState.initial()) {
    on<AppStarted>(_onAppStarted);
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onAppStarted(
      AppStarted event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    try {
      final accessToken = await _storage.getAccessToken();
      if (accessToken == null) {
        return emit(const AuthState.unauthenticated());
      }
      final user = await _authService.me();
      emit(AuthState.authenticated(user: user));
    } catch (_) {
      try {
        final refreshToken = await _storage.getRefreshToken();
        if (refreshToken == null) {
          return emit(const AuthState.unauthenticated());
        }
        final authResponse = await _authService.refresh(refreshToken);
        await _storage.saveTokens(
          accessToken: authResponse.accessToken,
          refreshToken: authResponse.refreshToken,
        );
        final user = await _authService.me();
        emit(AuthState.authenticated(user: user));
      } catch (_) {
        await _storage.clearAll();
        emit(const AuthState.unauthenticated());
      }
    }
  }

  Future<void> _onLoginRequested(
      LoginRequested event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    try {
      final response = await _authService.login(event.username, event.password);
      await _storage.saveTokens(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
      );
      emit(AuthState.authenticated(user: response.user));
    } catch (e) {
      emit(AuthState.unauthenticated(error: e.toString()));
    }
  }

  Future<void> _onRegisterRequested(
      RegisterRequested event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    try {
      final response = await _authService.register(event.request);
      await _storage.saveTokens(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
      );
      emit(AuthState.authenticated(user: response.user));
    } catch (e) {
      emit(AuthState.unauthenticated(error: e.toString()));
    }
  }

  Future<void> _onLogoutRequested(
      LogoutRequested event, Emitter<AuthState> emit) async {
    try {
      await _authService.logout();
    } catch (_) {}
    await _storage.clearAll();
    emit(const AuthState.unauthenticated());
  }
}
