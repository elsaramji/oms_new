import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:oms_new/core/error/failures.dart';
import 'package:oms_new/features/auth/domain/entities/user_entity.dart';
import 'package:oms_new/features/auth/domain/repositories/auth_repository.dart';

class LoginParams extends Equatable {
  final String username;
  final String password;
  final UserRole? role;

  const LoginParams({
    required this.username,
    required this.password,
    this.role,
  });

  @override
  List<Object?> get props => [username, password, role];
}

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, UserEntity>> call(LoginParams params) {
    return repository.login(
      username: params.username,
      password: params.password,
      role: params.role,
    );
  }
}
