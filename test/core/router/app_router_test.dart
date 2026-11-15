import 'package:flutter_test/flutter_test.dart';
import 'package:oms_new/core/router/app_router.dart';
import 'package:oms_new/features/auth/domain/entities/user_entity.dart';

void main() {
  const doctorUser = UserEntity(
    id: 'doc-001',
    name: 'Dr. Tarek',
    username: 'doctor',
    role: UserRole.treatingDoctor,
    token: 'jwt_doc',
  );

  const assistantUser = UserEntity(
    id: 'ast-001',
    name: 'Salma',
    username: 'assistant',
    role: UserRole.doctorAssistant,
    token: 'jwt_ast',
  );

  group('AppRouteGuard', () {
    test('redirects unauthenticated users to login', () {
      final route = AppRouteGuard.resolveRoute(
        targetPath: AppRoutes.doctorWorkspace,
        currentUser: null,
      );
      expect(route, equals(AppRoutes.login));
    });

    test('permits treatingDoctor to access doctor workspace', () {
      final route = AppRouteGuard.resolveRoute(
        targetPath: AppRoutes.doctorWorkspace,
        currentUser: doctorUser,
      );
      expect(route, equals(AppRoutes.doctorWorkspace));
    });

    test('blocks doctorAssistant from accessing doctor workspace, raises error, and redirects to intake', () {
      UnauthorizedAccessException? capturedException;

      final route = AppRouteGuard.resolveRoute(
        targetPath: AppRoutes.doctorWorkspace,
        currentUser: assistantUser,
        onUnauthorized: (err) {
          capturedException = err;
        },
      );

      expect(route, equals(AppRoutes.assistantIntake));
      expect(capturedException, isNotNull);
      expect(capturedException!.attemptedPath, equals(AppRoutes.doctorWorkspace));
      expect(capturedException!.userRole, equals(UserRole.doctorAssistant));
    });

    test('permits assistant to access intake workspace', () {
      final route = AppRouteGuard.resolveRoute(
        targetPath: AppRoutes.assistantIntake,
        currentUser: assistantUser,
      );
      expect(route, equals(AppRoutes.assistantIntake));
    });

    test('redirects authenticated doctor from login to doctor workspace', () {
      final route = AppRouteGuard.resolveRoute(
        targetPath: AppRoutes.login,
        currentUser: doctorUser,
      );
      expect(route, equals(AppRoutes.doctorWorkspace));
    });

    test('redirects authenticated assistant from login to intake workspace', () {
      final route = AppRouteGuard.resolveRoute(
        targetPath: AppRoutes.login,
        currentUser: assistantUser,
      );
      expect(route, equals(AppRoutes.assistantIntake));
    });
  });
}
