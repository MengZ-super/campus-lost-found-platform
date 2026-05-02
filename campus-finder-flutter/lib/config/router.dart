import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../blocs/auth/auth_bloc.dart';
import '../pages/splash/splash_page.dart';
import '../pages/auth/login_page.dart';
import '../pages/auth/register_page.dart';
import '../pages/home/home_page.dart';
import '../pages/lost_found/list_page.dart';
import '../pages/lost_found/detail_page.dart';
import '../pages/lost_found/publish_page.dart';
import '../pages/lost_found/edit_page.dart';
import '../pages/my/my_publishes_page.dart';
import '../pages/my/my_claims_page.dart';
import '../pages/profile/profile_page.dart';
import '../pages/profile/change_password_page.dart';

final _rootKey = GlobalKey<NavigatorState>();
final _shellKey = GlobalKey<NavigatorState>();

GoRouter createRouter() {
  return GoRouter(
    navigatorKey: _rootKey,
    initialLocation: '/splash',
    redirect: (context, state) {
      final authState = context.read<AuthBloc>().state;
      final isLoggedIn = authState is _Authenticated;
      final onSplash = state.matchedLocation == '/splash';
      final onAuth = state.matchedLocation == '/login' || state.matchedLocation == '/register';

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
        builder: (_, __) => const SplashPage(),
      ),
      GoRoute(
        path: '/login',
        builder: (_, __) => const LoginPage(),
      ),
      GoRoute(
        path: '/register',
        builder: (_, __) => const RegisterPage(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (_, __, navigationShell) =>
            ScaffoldWithNavBar(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(path: '/home', builder: (_, __) => const HomePage()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/lost-found',
              builder: (_, __) => const LostFoundListPage(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: '/my', builder: (_, __) => const ProfilePage()),
          ]),
        ],
      ),
      GoRoute(
        path: '/lost-found/:id',
        builder: (_, state) => LostFoundDetailPage(
          id: int.tryParse(state.pathParameters['id'] ?? '') ?? 0,
        ),
      ),
      GoRoute(
        path: '/publish',
        builder: (_, __) => const PublishLostFoundPage(),
      ),
      GoRoute(
        path: '/edit/:id',
        builder: (_, state) => EditLostFoundPage(
          id: int.tryParse(state.pathParameters['id'] ?? '') ?? 0,
        ),
      ),
      GoRoute(
        path: '/my/publishes',
        builder: (_, __) => const MyPublishesPage(),
      ),
      GoRoute(
        path: '/my/claims',
        builder: (_, __) => const MyClaimsPage(),
      ),
      GoRoute(
        path: '/change-password',
        builder: (_, __) => const ChangePasswordPage(),
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
        onDestinationSelected: (index) =>
            navigationShell.goBranch(index, initialLocation: index == navigationShell.currentIndex),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: '首页'),
          NavigationDestination(icon: Icon(Icons.search_outlined), selectedIcon: Icon(Icons.search), label: '失物招领'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: '我的'),
        ],
      ),
    );
  }
}
