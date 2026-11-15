import 'package:equatable/equatable.dart';

class ServerException implements Exception {
  final String message;
  final int? statusCode;

  const ServerException([this.message = 'Server exception occurred', this.statusCode]);

  @override
  String toString() => 'ServerException: $message (code: $statusCode)';
}

class CacheException implements Exception {
  final String message;

  const CacheException([this.message = 'Cache exception occurred']);

  @override
  String toString() => 'CacheException: $message';
}

class ClinicalSafetyException extends Equatable implements Exception {
  final String message;
  final String? violationCode;

  const ClinicalSafetyException(
    this.message, {
    this.violationCode,
  });

  @override
  List<Object?> get props => [message, violationCode];

  @override
  String toString() => 'ClinicalSafetyException: $message (code: $violationCode)';
}
