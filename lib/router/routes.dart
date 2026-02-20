import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:noteplus_app/pages/auth/auth-page.dart';
import 'package:noteplus_app/pages/auth/check-auth.dart';
import 'package:noteplus_app/pages/home/home-page.dart';

class Routes {
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext ctx, GoRouterState state) {
          return const InitialAppPage();
        },
        routes: <RouteBase> [
          GoRoute(
            path: '/home',
            builder: (BuildContext ctx, GoRouterState state) {
              return const HomePage();
            },
          ),
          GoRoute(
            path: '/auth',
            builder: (BuildContext ctx, GoRouterState state) {
              return const AuthPage();
            },
          ),
        ]
      ),
    ],
  );
}
