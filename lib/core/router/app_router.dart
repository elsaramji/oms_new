import 'package:flutter/material.dart';
import 'package:oms_new/features/auth/domain/entities/user_entity.dart';

class AppRoutes {
  static const String login = '/login';
  static const String assistantIntake = '/intake';
  static const String doctorWorkspace = '/doctor-workspace';
}

class UnauthorizedAccessException implements Exception {
  final String attemptedPath;
  final UserRole userRole;

  const UnauthorizedAccessException({
    required this.attemptedPath,
    required this.userRole,
  });

  @override
  String toString() =>
      'UnauthorizedAccessException: Role $userRole is not authorized to access $attemptedPath';
}

class AppRouteGuard {
  /// Evaluates target path against current user session and returns resolved safe path.
  /// Throws [UnauthorizedAccessException] if [throwOnBlocked] is true, or redirects to safe fallback.
  static String resolveRoute({
    required String targetPath,
    required UserEntity? currentUser,
    void Function(UnauthorizedAccessException error)? onUnauthorized,
  }) {
    if (currentUser == null) {
      return AppRoutes.login;
    }

    if (targetPath == AppRoutes.login) {
      return currentUser.isDoctor
          ? AppRoutes.doctorWorkspace
          : AppRoutes.assistantIntake;
    }

    if (targetPath == AppRoutes.doctorWorkspace) {
      if (currentUser.isDoctor) {
        return AppRoutes.doctorWorkspace;
      } else {
        final exception = UnauthorizedAccessException(
          attemptedPath: targetPath,
          userRole: currentUser.role,
        );
        onUnauthorized?.call(exception);
        return AppRoutes.assistantIntake; // Redirect assistant to safe intake path
      }
    }

    if (targetPath == AppRoutes.assistantIntake) {
      return AppRoutes.assistantIntake;
    }

    return targetPath;
  }
}

class AppRouter {
  final UserEntity? Function() getCurrentUser;
  final void Function(UnauthorizedAccessException)? onUnauthorized;

  AppRouter({
    required this.getCurrentUser,
    this.onUnauthorized,
  });

  Route<dynamic> onGenerateRoute(
    RouteSettings settings, {
    Widget Function(BuildContext)? loginBuilder,
    Widget Function(BuildContext)? intakeBuilder,
    Widget Function(BuildContext)? doctorBuilder,
  }) {
    final requestedPath = settings.name ?? AppRoutes.login;
    final resolvedPath = AppRouteGuard.resolveRoute(
      targetPath: requestedPath,
      currentUser: getCurrentUser(),
      onUnauthorized: onUnauthorized,
    );

    switch (resolvedPath) {
      case AppRoutes.doctorWorkspace:
        return MaterialPageRoute(
          settings: const RouteSettings(name: AppRoutes.doctorWorkspace),
          builder: (context) => doctorBuilder != null
              ? doctorBuilder(context)
              : const Scaffold(body: Center(child: Text('Doctor Workspace'))),
        );
      case AppRoutes.assistantIntake:
        return MaterialPageRoute(
          settings: const RouteSettings(name: AppRoutes.assistantIntake),
          builder: (context) => intakeBuilder != null
              ? intakeBuilder(context)
              : const Scaffold(body: Center(child: Text('Assistant Intake'))),
        );
      case AppRoutes.login:
      default:
        return MaterialPageRoute(
          settings: const RouteSettings(name: AppRoutes.login),
          builder: (context) => loginBuilder != null
              ? loginBuilder(context)
              : const Scaffold(body: Center(child: Text('Login Page'))),
        );
    }
  }
}
