import 'package:flutter_test/flutter_test.dart';
import 'package:oms_new/core/error/exceptions.dart';
import 'package:oms_new/core/error/failures.dart';

void main() {
  group('Failures', () {
    test('ServerFailure supports value equality and custom message/code', () {
      const failure1 = ServerFailure('Internal Server Error', 500);
      const failure2 = ServerFailure('Internal Server Error', 500);
      const failure3 = ServerFailure('Bad Request', 400);

      expect(failure1, equals(failure2));
      expect(failure1, isNot(equals(failure3)));
      expect(failure1.message, equals('Internal Server Error'));
      expect(failure1.statusCode, equals(500));
    });

    test('CacheFailure supports value equality and default message', () {
      const failure1 = CacheFailure();
      const failure2 = CacheFailure('Cache failure occurred');

      expect(failure1, equals(failure2));
      expect(failure1.message, equals('Cache failure occurred'));
    });

    test('ClinicalSafetyFailure supports value equality', () {
      const failure1 = ClinicalSafetyFailure('Bypassed safety gate');
      const failure2 = ClinicalSafetyFailure('Bypassed safety gate');

      expect(failure1, equals(failure2));
      expect(failure1.props, contains('Bypassed safety gate'));
    });

    test('AuthFailure supports value equality', () {
      const failure1 = AuthFailure('Invalid credentials');
      const failure2 = AuthFailure('Invalid credentials');

      expect(failure1, equals(failure2));
    });
  });

  group('Exceptions', () {
    test('ClinicalSafetyException holds message and violation code with equality', () {
      const exception1 = ClinicalSafetyException(
        'Doctor approval required before committing consultation',
        violationCode: 'UNAPPROVED_AI_DRAFT_COMMIT',
      );
      const exception2 = ClinicalSafetyException(
        'Doctor approval required before committing consultation',
        violationCode: 'UNAPPROVED_AI_DRAFT_COMMIT',
      );

      expect(exception1, equals(exception2));
      expect(exception1.message, contains('Doctor approval required'));
      expect(exception1.violationCode, equals('UNAPPROVED_AI_DRAFT_COMMIT'));
      expect(exception1.toString(), contains('UNAPPROVED_AI_DRAFT_COMMIT'));
    });

    test('ServerException and CacheException format string representation correctly', () {
      const serverException = ServerException('Gateway Timeout', 504);
      const cacheException = CacheException('Disk read failed');

      expect(serverException.toString(), equals('ServerException: Gateway Timeout (code: 504)'));
      expect(cacheException.toString(), equals('CacheException: Disk read failed'));
    });
  });
}
