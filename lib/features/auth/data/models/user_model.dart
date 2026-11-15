import 'package:oms_new/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.name,
    required super.username,
    required super.role,
    required super.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final roleStr = json['role'] as String? ?? 'doctorAssistant';
    final role = (roleStr == 'treatingDoctor' ||
            roleStr == 'TREATING_DOCTOR' ||
            roleStr == 'doctor')
        ? UserRole.treatingDoctor
        : UserRole.doctorAssistant;

    return UserModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      username: json['username'] as String? ?? '',
      role: role,
      token: json['token'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'role': role == UserRole.treatingDoctor ? 'treatingDoctor' : 'doctorAssistant',
      'token': token,
    };
  }
}
