import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'services/api_client.dart';
import 'services/push_service.dart';
import 'services/token_storage.dart';
import 'services/auth_service.dart';
import 'services/user_service.dart';
import 'services/lost_found_service.dart';
import 'services/category_service.dart';
import 'services/upload_service.dart';
import 'blocs/auth/auth_bloc.dart';
import 'blocs/auth/auth_event.dart';
import 'blocs/auth/auth_state.dart';
import 'blocs/profile/profile_bloc.dart';
import 'config/theme.dart';
import 'config/router.dart';

class CampusFinderApp extends StatelessWidget {
  final SecureStorage storage;
  final ApiClient apiClient;
  final PushService pushService;

  const CampusFinderApp({
    super.key,
    required this.storage,
    required this.apiClient,
    required this.pushService,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<LostFoundService>(
          create: (_) => LostFoundService(apiClient: apiClient),
        ),
        RepositoryProvider<CategoryService>(
          create: (_) => CategoryService(apiClient: apiClient),
        ),
        RepositoryProvider<UploadService>(
          create: (_) => UploadService(apiClient: apiClient),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              authService: AuthService(apiClient: apiClient),
              storage: storage,
            )..add(const AuthEvent.appStarted()),
          ),
          BlocProvider<ProfileBloc>(
            create: (context) => ProfileBloc(
              userService: UserService(apiClient: apiClient),
            ),
          ),
        ],
        child: _AuthAliasListener(
          pushService: pushService,
          child: MaterialApp.router(
            title: '校园失物招领',
            theme: appTheme,
            routerConfig: createRouter(),
            debugShowCheckedModeBanner: false,
          ),
        ),
      ),
    );
  }
}

class _AuthAliasListener extends StatelessWidget {
  final PushService pushService;
  final Widget child;

  const _AuthAliasListener({
    required this.pushService,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) {
        if (previous is AuthAuthenticated && current is AuthAuthenticated) {
          return previous.user.id != current.user.id;
        }
        return previous is AuthAuthenticated != current is AuthAuthenticated;
      },
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          pushService.setAlias(state.user.id.toString());
        } else if (state is AuthUnauthenticated) {
          pushService.deleteAlias();
        }
      },
      child: child,
    );
  }
}
