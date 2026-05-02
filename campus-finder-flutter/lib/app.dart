import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'services/api_client.dart';
import 'services/token_storage.dart';
import 'services/auth_service.dart';
import 'blocs/auth/auth_bloc.dart';
import 'blocs/auth/auth_event.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(
            authService: AuthService(apiClient: apiClient),
            storage: storage,
          )..add(AppStarted()),
        ),
      ],
      child: MaterialApp.router(
        title: '校园失物招领',
        theme: appTheme,
        routerConfig: createRouter(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
