import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'services/api_client.dart';
import 'services/token_storage.dart';
import 'services/auth_service.dart';
import 'services/user_service.dart';
import 'blocs/auth/auth_bloc.dart';
import 'blocs/auth/auth_event.dart';
import 'blocs/profile/profile_bloc.dart';
import 'config/theme.dart';
import 'config/router.dart';

class CampusFinderApp extends StatelessWidget {
  final SecureStorage storage;
  final ApiClient apiClient;

  const CampusFinderApp({
    super.key,
    required this.storage,
    required this.apiClient,
  });

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<ApiClient>.value(
      value: apiClient,
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
      child: MaterialApp.router(
        title: '校园失物招领',
        theme: appTheme,
        routerConfig: createRouter(),
        debugShowCheckedModeBanner: false,
      ),
      ),
    );
  }
}
