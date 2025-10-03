import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'route_path.dart';

class AppRoute {
    static final _rootNavigatorKey = GlobalKey<NavigatorState>();
      static final _homeNavigatorKey = GlobalKey<NavigatorState>();

    static final GoRouter _routerX = GoRouter(
    initialLocation: RoutePath.splashPagePath,
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    routes: [
      // GoRoute(
      //   name: RoutePath.splashPage,
      //   path: RoutePath.splashPagePath,
      //   builder: (context, state) => SplashPage(),
      // ),

      // ///main page route
      // StatefulShellRoute.indexedStack(
      //   builder: (context, state, navigationShell) {
      //     // the UI shell
      //     return MainPage(
      //       navigationShell: navigationShell,
      //     );
      //   },
      //   branches: [
      //     ///Home branch
      //     StatefulShellBranch(
      //       initialLocation: RoutePath.mainPagePath,
      //       navigatorKey: _homeNavigatorKey,
      //       routes: [
      //         // top route inside branch
      //         GoRoute(
      //           name: RoutePath.mainPage,
      //           path: RoutePath.mainPagePath,
      //           pageBuilder: (context, state) => NoTransitionPage(
      //             child: HomePage(),
      //           ),
      //         ),
      //       ],
      //     ),

      //   ],
      // ),
    ],
    errorBuilder: (context, state) => const Scaffold(
      body: Center(
        child: Text("Something went wrong"),
      ),
    ),
  );

  static GoRouter get router => _routerX;
}