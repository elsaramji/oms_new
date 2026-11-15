import 'package:fpdart/fpdart.dart';
import 'package:oms_new/core/error/failures.dart';
import 'package:oms_new/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login({
    required String username,
    required String password,
    UserRole? role,
  });

  Future<Either<Failure, Unit>> logout();

  Future<Option<UserEntity>> getCurrentUser();
}
