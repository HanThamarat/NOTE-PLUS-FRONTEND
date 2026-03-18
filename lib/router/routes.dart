import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:noteplus_app/pages/auth/auth-page.dart';
import 'package:noteplus_app/pages/auth/check-auth.dart';
import 'package:noteplus_app/pages/analytics/analytics-page.dart';
import 'package:noteplus_app/pages/home/home-page.dart';
import 'package:noteplus_app/pages/layouts/master.dart';
import 'package:noteplus_app/pages/projects/projects-page.dart';
import 'package:noteplus_app/pages/setting/settings-page.dart';
import 'package:noteplus_app/pages/team/team-page.dart';

class Routes {
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext ctx, GoRouterState state) {
          return const InitialAppPage();
        },
        routes: <RouteBase>[
          GoRoute(
              path: '/auth',
              builder: (BuildContext ctx, GoRouterState state) {
                return const AuthPage();
              },
          ),
          ShellRoute(
            builder: (BuildContext context, GoRouterState state, Widget child) {
              return MasterLayout(
                currentPath: state.uri.path,
                child: child,
              );
            },
            routes: <GoRoute>[
              GoRoute(
                path: '/home',
                builder: (BuildContext ctx, GoRouterState state) {
                  return const HomePage();
                },
              ),
              GoRoute(
                path: '/projects',
                builder: (BuildContext ctx, GoRouterState state) {
                  return const ProjectsPage();
                },
              ),
              GoRoute(
                path: '/team',
                builder: (BuildContext ctx, GoRouterState state) {
                  return const TeamPage();
                },
              ),
              GoRoute(
                path: '/analytics',
                builder: (BuildContext ctx, GoRouterState state) {
                  return const AnalyticsPage();
                },
              ),
              GoRoute(
                path: '/settings',
                builder: (BuildContext ctx, GoRouterState state) {
                  return const SettingsPage();
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
