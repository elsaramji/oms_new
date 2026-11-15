import 'package:equatable/equatable.dart';

enum UserRole {
  doctorAssistant,
  treatingDoctor,
}

class UserEntity extends Equatable {
  final String id;
  final String name;
  final String username;
  final UserRole role;
  final String token;

  const UserEntity({
    required this.id,
    required this.name,
    required this.username,
    required this.role,
    required this.token,
  });

  bool get isDoctor => role == UserRole.treatingDoctor;
  bool get isAssistant => role == UserRole.doctorAssistant;

  @override
  List<Object?> get props => [id, name, username, role, token];
}
