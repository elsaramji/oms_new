import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:oms_new/core/error/exceptions.dart';
import 'package:oms_new/core/error/failures.dart';
import 'package:oms_new/features/auth/data/datasources/auth_data_source.dart';
import 'package:oms_new/features/auth/data/models/user_model.dart';
import 'package:oms_new/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:oms_new/features/auth/domain/entities/user_entity.dart';

class MockAuthDataSource extends Mock implements AuthDataSource {}

void main() {
  late MockAuthDataSource mockDataSource;
  late AuthRepositoryImpl repository;

  setUp(() {
    mockDataSource = MockAuthDataSource();
    repository = AuthRepositoryImpl(mockDataSource);
  });

  const tUserModel = UserModel(
    id: 'doc-001',
    name: 'Dr. Mohamed Mostafa',
    username: 'doctor',
    role: UserRole.treatingDoctor,
    token: 'jwt_token_doc',
  );

  group('UserModel JSON serialization', () {
    test('serializes and deserializes correctly', () {
      final json = tUserModel.toJson();
      final fromJson = UserModel.fromJson(json);

      expect(fromJson, equals(tUserModel));
      expect(fromJson.role, equals(UserRole.treatingDoctor));
    });
  });

  group('AuthRepositoryImpl login', () {
    test('returns Right(UserEntity) when data source succeeds', () async {
      when(() => mockDataSource.login(
            username: 'doctor',
            password: 'password123',
            role: UserRole.treatingDoctor,
          )).thenAnswer((_) async => tUserModel);

      final result = await repository.login(
        username: 'doctor',
        password: 'password123',
        role: UserRole.treatingDoctor,
      );

      expect(result, equals(const Right(tUserModel)));
      verify(() => mockDataSource.login(
            username: 'doctor',
            password: 'password123',
            role: UserRole.treatingDoctor,
          )).called(1);
    });

    test('returns Left(AuthFailure) when data source throws ServerException', () async {
      when(() => mockDataSource.login(
            username: 'doctor',
            password: 'wrong_password',
            role: any(named: 'role'),
          )).thenThrow(const ServerException('Invalid credentials', 401));

      final result = await repository.login(
        username: 'doctor',
        password: 'wrong_password',
      );

      expect(result, equals(const Left(AuthFailure('Invalid credentials'))));
    });
  });

  group('AuthRepositoryImpl logout and getCurrentUser', () {
    test('returns Right(unit) on successful logout', () async {
      when(() => mockDataSource.logout()).thenAnswer((_) async {});

      final result = await repository.logout();

      expect(result, equals(const Right(unit)));
      verify(() => mockDataSource.logout()).called(1);
    });

    test('returns Option.of(user) when user is cached', () async {
      when(() => mockDataSource.getCachedUser()).thenAnswer((_) async => tUserModel);

      final result = await repository.getCurrentUser();

      expect(result, equals(const Some(tUserModel)));
    });
  });
}
