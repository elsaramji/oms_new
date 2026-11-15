import 'package:oms_new/core/error/exceptions.dart';
import 'package:oms_new/features/auth/data/models/user_model.dart';
import 'package:oms_new/features/auth/domain/entities/user_entity.dart';

abstract class AuthDataSource {
  Future<UserModel> login({
    required String username,
    required String password,
    UserRole? role,
  });

  Future<void> logout();

  Future<UserModel?> getCachedUser();
}

class MockAuthDataSource implements AuthDataSource {
  UserModel? _currentUser;

  static const List<Map<String, dynamic>> _seededAccounts = [
    {
      'id': 'doc-001',
      'name': 'د. محمد مصطفى (Dr. Mohamed Mostafa)',
      'username': 'doctor',
      'password': 'password123',
      'role': 'treatingDoctor',
      'token': 'mock_jwt_treating_doctor_token_123',
    },
    {
      'id': 'ast-001',
      'name': 'نوران علي (Nouran Aly)',
      'username': 'assistant',
      'password': 'password123',
      'role': 'doctorAssistant',
      'token': 'mock_jwt_doctor_assistant_token_456',
    },
  ];

  @override
  Future<UserModel> login({
    required String username,
    required String password,
    UserRole? role,
  }) async {
    await Future.delayed(const Duration(milliseconds: 50));

    final match = _seededAccounts.firstWhere(
      (acc) =>
          acc['username'] == username &&
          acc['password'] == password &&
          (role == null ||
              (role == UserRole.treatingDoctor && acc['role'] == 'treatingDoctor') ||
              (role == UserRole.doctorAssistant && acc['role'] == 'doctorAssistant')),
      orElse: () => {},
    );

    if (match.isEmpty) {
      throw const ServerException('Invalid username, password, or role selection', 401);
    }

    final user = UserModel.fromJson(match);
    _currentUser = user;
    return user;
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 20));
    _currentUser = null;
  }

  @override
  Future<UserModel?> getCachedUser() async {
    return _currentUser;
  }
}
