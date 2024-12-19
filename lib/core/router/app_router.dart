import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:real_estate_app/core/presentation/screens/shell_screen.dart';
import 'package:real_estate_app/features/home/presentation/screens/home_screen.dart';
import 'package:real_estate_app/features/house_details/presentation/screens/house_details_screen.dart';
import 'package:real_estate_app/features/information/presentation/screens/information_screen.dart';
import 'package:real_estate_app/features/splash/presentation/screens/splash_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();

final goRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/house/:id',
      builder: (context, state) {
        final houseId = int.parse(state.pathParameters['id']!);
        return HouseDetailsScreen(houseId: houseId);
      },
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ShellScreen(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavigatorKey,
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/about',
              builder: (context, state) => const InformationScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
); 