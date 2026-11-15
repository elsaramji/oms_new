import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oms_new/core/localization/app_localizations.dart';
import 'package:oms_new/features/auth/domain/entities/user_entity.dart';
import 'package:oms_new/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:oms_new/features/auth/presentation/cubit/auth_state.dart';

class LoginPage extends StatefulWidget {
  final void Function(UserEntity user)? onLoginSuccess;

  const LoginPage({super.key, this.onLoginSuccess});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController(text: 'doctor');
  final _passwordController = TextEditingController(text: 'password123');
  UserRole _selectedRole = UserRole.treatingDoctor;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthCubit>().login(
            username: _usernameController.text.trim(),
            password: _passwordController.text.trim(),
            role: _selectedRole,
          );
    }
  }

  void _fillPreset(String username, UserRole role) {
    setState(() {
      _usernameController.text = username;
      _passwordController.text = 'password123';
      _selectedRole = role;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            widget.onLoginSuccess?.call(state.user);
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.redAccent,
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;

          return Center(
            child: SingleChildScrollView(
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: Container(
                  width: 480,
                  padding: const EdgeInsets.all(32),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Icon(
                          Icons.local_hospital_rounded,
                          size: 56,
                          color: Color(0xFF0284C7),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          l10n.appTitle,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          l10n.login,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: const Color(0xFF64748B),
                          ),
                        ),
                        const SizedBox(height: 24),
                        if (state is AuthError)
                          Container(
                            padding: const EdgeInsets.all(12),
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFEE2E2),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: const Color(0xFFEF4444)),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.error_outline, color: Color(0xFFDC2626)),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    state.message,
                                    style: const TextStyle(color: Color(0xFF991B1B)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        TextFormField(
                          key: const Key('username_field'),
                          controller: _usernameController,
                          decoration: InputDecoration(
                            labelText: l10n.username,
                            prefixIcon: const Icon(Icons.person_outline),
                            border: const OutlineInputBorder(),
                          ),
                          validator: (value) =>
                              (value == null || value.isEmpty) ? 'Required' : null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          key: const Key('password_field'),
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: l10n.password,
                            prefixIcon: const Icon(Icons.lock_outline),
                            border: const OutlineInputBorder(),
                          ),
                          validator: (value) =>
                              (value == null || value.isEmpty) ? 'Required' : null,
                        ),
                        const SizedBox(height: 20),
                        SegmentedButton<UserRole>(
                          segments: [
                            ButtonSegment(
                              value: UserRole.treatingDoctor,
                              label: Text(l10n.treatingDoctor),
                              icon: const Icon(Icons.medical_services),
                            ),
                            ButtonSegment(
                              value: UserRole.doctorAssistant,
                              label: Text(l10n.doctorAssistant),
                              icon: const Icon(Icons.assignment_ind),
                            ),
                          ],
                          selected: {_selectedRole},
                          onSelectionChanged: (set) {
                            setState(() {
                              _selectedRole = set.first;
                            });
                          },
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          key: const Key('login_button'),
                          onPressed: isLoading ? null : _submit,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            backgroundColor: const Color(0xFF0284C7),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : Text(
                                  l10n.login,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                        const SizedBox(height: 20),
                        const Divider(),
                        const SizedBox(height: 12),
                        const Text(
                          'Quick Demo Accounts',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF94A3B8),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                key: const Key('demo_doctor_button'),
                                icon: const Icon(Icons.medical_services, size: 16),
                                label: const Text('Doctor Demo'),
                                onPressed: () =>
                                    _fillPreset('doctor', UserRole.treatingDoctor),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: OutlinedButton.icon(
                                key: const Key('demo_assistant_button'),
                                icon: const Icon(Icons.support_agent, size: 16),
                                label: const Text('Assistant Demo'),
                                onPressed: () =>
                                    _fillPreset('assistant', UserRole.doctorAssistant),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
