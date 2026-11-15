import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:oms_new/core/error/failures.dart';
import 'package:oms_new/features/auth/domain/entities/user_entity.dart';
import 'package:oms_new/features/auth/domain/repositories/auth_repository.dart';
import 'package:oms_new/features/auth/domain/usecases/login_usecase.dart';
import 'package:oms_new/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:oms_new/features/auth/presentation/cubit/auth_state.dart';

class MockLoginUseCase extends Mock implements LoginUseCase {}
class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockLoginUseCase mockLoginUseCase;
  late MockAuthRepository mockAuthRepository;
  late AuthCubit authCubit;

  setUpAll(() {
    registerFallbackValue(const LoginParams(username: '', password: ''));
  });

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    mockAuthRepository = MockAuthRepository();
    authCubit = AuthCubit(
      loginUseCase: mockLoginUseCase,
      authRepository: mockAuthRepository,
    );
  });

  tearDown(() {
    authCubit.close();
  });

  const tUser = UserEntity(
    id: 'doc-001',
    name: 'Dr. Mohamed Mostafa',
    username: 'doctor',
    role: UserRole.treatingDoctor,
    token: 'jwt_mock_token',
  );

  test('initial state is AuthInitial', () {
    expect(authCubit.state, equals(const AuthInitial()));
  });

  blocTest<AuthCubit, AuthState>(
    'emits [AuthLoading, Authenticated] when login is successful',
    build: () {
      when(() => mockLoginUseCase(any()))
          .thenAnswer((_) async => const Right(tUser));
      return authCubit;
    },
    act: (cubit) => cubit.login(
      username: 'doctor',
      password: 'password123',
      role: UserRole.treatingDoctor,
    ),
    expect: () => [
      const AuthLoading(),
      const Authenticated(tUser),
    ],
  );

  blocTest<AuthCubit, AuthState>(
    'emits [AuthLoading, AuthError] when login fails',
    build: () {
      when(() => mockLoginUseCase(any()))
          .thenAnswer((_) async => const Left(AuthFailure('Invalid credentials')));
      return authCubit;
    },
    act: (cubit) => cubit.login(
      username: 'wrong_user',
      password: 'wrong_password',
    ),
    expect: () => [
      const AuthLoading(),
      const AuthError('Invalid credentials'),
    ],
  );

  blocTest<AuthCubit, AuthState>(
    'emits [AuthLoading, Unauthenticated] on logout',
    build: () {
      when(() => mockAuthRepository.logout())
          .thenAnswer((_) async => const Right(unit));
      return authCubit;
    },
    act: (cubit) => cubit.logout(),
    expect: () => [
      const AuthLoading(),
      const Unauthenticated(),
    ],
  );

  blocTest<AuthCubit, AuthState>(
    'emits [Authenticated] when session check finds cached user',
    build: () {
      when(() => mockAuthRepository.getCurrentUser())
          .thenAnswer((_) async => const Some(tUser));
      return authCubit;
    },
    act: (cubit) => cubit.checkCurrentSession(),
    expect: () => [
      const Authenticated(tUser),
    ],
  );
}
