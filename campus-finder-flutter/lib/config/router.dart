import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_state.dart';
import '../pages/splash/splash_page.dart';
import '../pages/auth/login_page.dart';
import '../pages/auth/register_page.dart';
import '../pages/home/home_page.dart';
import '../pages/lost_found/list_page.dart';
import '../pages/lost_found/detail_page.dart';
import '../pages/lost_found/publish_page.dart';
import '../pages/lost_found/edit_page.dart';
import '../widgets/map_picker.dart';
import '../pages/my/my_publishes_page.dart';
import '../pages/my/my_claims_page.dart';
import '../pages/profile/profile_page.dart';
import '../pages/profile/change_password_page.dart';

final _rootKey = GlobalKey<NavigatorState>();

GoRouter createRouter() {
  return GoRouter(
    navigatorKey: _rootKey,
    initialLocation: '/splash',
    redirect: (context, state) {
      final authState = context.read<AuthBloc>().state;
      final isLoggedIn = authState is AuthAuthenticated;
      final onSplash = state.matchedLocation == '/splash';
      final onAuth = state.matchedLocation == '/login' ||
          state.matchedLocation == '/register';

      if (!onSplash && !isLoggedIn && !onAuth) {
        return '/login';
      }
      if (onAuth && isLoggedIn) {
        return '/home';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterPage(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            ScaffoldWithNavBar(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomePage(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/lost-found',
              builder: (context, state) => const LostFoundListPage(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/my',
              builder: (context, state) => const ProfilePage(),
            ),
          ]),
        ],
      ),
      GoRoute(
        path: '/lost-found/:id',
        builder: (context, state) => LostFoundDetailPage(
          id: int.tryParse(state.pathParameters['id'] ?? '') ?? 0,
        ),
      ),
      GoRoute(
        path: '/publish',
        builder: (context, state) => const PublishLostFoundPage(),
      ),
      GoRoute(
        path: '/edit/:id',
        builder: (context, state) => EditLostFoundPage(
          id: int.tryParse(state.pathParameters['id'] ?? '') ?? 0,
        ),
      ),
      GoRoute(
        path: '/my/publishes',
        builder: (context, state) => const MyPublishesPage(),
      ),
      GoRoute(
        path: '/my/claims',
        builder: (context, state) => const MyClaimsPage(),
      ),
      GoRoute(
        path: '/change-password',
        builder: (context, state) => const ChangePasswordPage(),
      ),
      GoRoute(
        path: '/map-picker',
        builder: (context, state) {
          final lat = state.uri.queryParameters['lat'];
          final lng = state.uri.queryParameters['lng'];
          return MapPickerPage(
            initialLat: lat != null ? double.tryParse(lat) : null,
            initialLng: lng != null ? double.tryParse(lng) : null,
          );
        },
      ),
    ],
  );
}

class ScaffoldWithNavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithNavBar({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: '首页',
          ),
          NavigationDestination(
            icon: Icon(Icons.search_outlined),
            selectedIcon: Icon(Icons.search),
            label: '失物招领',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: '我的',
          ),
        ],
      ),
    );
  }
}
