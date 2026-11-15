import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:oms_new/core/error/failures.dart';
import 'package:oms_new/features/auth/domain/entities/user_entity.dart';
import 'package:oms_new/features/auth/domain/repositories/auth_repository.dart';
import 'package:oms_new/features/auth/domain/usecases/login_usecase.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockRepository;
  late LoginUseCase useCase;

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = LoginUseCase(mockRepository);
  });

  const tUser = UserEntity(
    id: 'user-001',
    name: 'Dr. Tarek Omar',
    username: 'doctor_tarek',
    role: UserRole.treatingDoctor,
    token: 'jwt_mock_token_doctor',
  );

  test('successfully authenticates doctor and returns UserEntity', () async {
    const params = LoginParams(
      username: 'doctor_tarek',
      password: 'valid_password',
      role: UserRole.treatingDoctor,
    );

    when(() => mockRepository.login(
          username: params.username,
          password: params.password,
          role: params.role,
        )).thenAnswer((_) async => const Right(tUser));

    final result = await useCase(params);

    expect(result, equals(const Right(tUser)));
    verify(() => mockRepository.login(
          username: params.username,
          password: params.password,
          role: params.role,
        )).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('returns AuthFailure when repository login fails', () async {
    const params = LoginParams(
      username: 'invalid_user',
      password: 'wrong_password',
    );

    when(() => mockRepository.login(
          username: params.username,
          password: params.password,
          role: params.role,
        )).thenAnswer((_) async => const Left(AuthFailure('Invalid credentials')));

    final result = await useCase(params);

    expect(result, equals(const Left(AuthFailure('Invalid credentials'))));
    verify(() => mockRepository.login(
          username: params.username,
          password: params.password,
          role: params.role,
        )).called(1);
  });
}
