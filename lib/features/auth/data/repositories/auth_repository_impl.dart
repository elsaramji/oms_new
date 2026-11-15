import 'package:fpdart/fpdart.dart';
import 'package:oms_new/core/error/exceptions.dart';
import 'package:oms_new/core/error/failures.dart';
import 'package:oms_new/features/auth/data/datasources/auth_data_source.dart';
import 'package:oms_new/features/auth/domain/entities/user_entity.dart';
import 'package:oms_new/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource dataSource;

  AuthRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, UserEntity>> login({
    required String username,
    required String password,
    UserRole? role,
  }) async {
    try {
      final user = await dataSource.login(
        username: username,
        password: password,
        role: role,
      );
      return Right(user);
    } on ServerException catch (e) {
      return Left(AuthFailure(e.message));
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    try {
      await dataSource.logout();
      return const Right(unit);
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Option<UserEntity>> getCurrentUser() async {
    final cached = await dataSource.getCachedUser();
    return Option.fromNullable(cached);
  }
}
