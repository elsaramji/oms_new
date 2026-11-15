import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final int? statusCode;

  const Failure(this.message, {this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];
}

class ServerFailure extends Failure {
  const ServerFailure([String message = 'Server failure occurred', int? statusCode])
      : super(message, statusCode: statusCode);
}

class CacheFailure extends Failure {
  const CacheFailure([String message = 'Cache failure occurred'])
      : super(message);
}

class ClinicalSafetyFailure extends Failure {
  const ClinicalSafetyFailure([String message = 'Clinical safety violation occurred'])
      : super(message);
}

class AuthFailure extends Failure {
  const AuthFailure([String message = 'Authentication failure occurred'])
      : super(message);
}
