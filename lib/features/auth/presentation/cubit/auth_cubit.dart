import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oms_new/features/auth/domain/entities/user_entity.dart';
import 'package:oms_new/features/auth/domain/repositories/auth_repository.dart';
import 'package:oms_new/features/auth/domain/usecases/login_usecase.dart';
import 'package:oms_new/features/auth/presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final AuthRepository authRepository;

  AuthCubit({
    required this.loginUseCase,
    required this.authRepository,
  }) : super(const AuthInitial());

  Future<void> login({
    required String username,
    required String password,
    UserRole? role,
  }) async {
    emit(const AuthLoading());
    final result = await loginUseCase(
      LoginParams(
        username: username,
        password: password,
        role: role,
      ),
    );

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(Authenticated(user)),
    );
  }

  Future<void> logout() async {
    emit(const AuthLoading());
    await authRepository.logout();
    emit(const Unauthenticated());
  }

  Future<void> checkCurrentSession() async {
    final userOption = await authRepository.getCurrentUser();
    userOption.fold(
      () => emit(const Unauthenticated()),
      (user) => emit(Authenticated(user)),
    );
  }
}
