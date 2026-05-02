import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../models/user.dart';
import '../../utils/validators.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _controllers = {
    'username': TextEditingController(),
    'phone': TextEditingController(),
    'studentId': TextEditingController(),
    'nickname': TextEditingController(),
    'password': TextEditingController(),
    'confirmPassword': TextEditingController(),
  };
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  void _onRegister() {
    if (!_formKey.currentState!.validate()) return;

    final request = RegisterRequest(
      username: _controllers['username']!.text.trim(),
      password: _controllers['password']!.text.trim(),
      phone: _controllers['phone']!.text.trim(),
      studentId: _controllers['studentId']!.text.trim().isEmpty
          ? null
          : _controllers['studentId']!.text.trim(),
      nickname: _controllers['nickname']!.text.trim().isEmpty
          ? null
          : _controllers['nickname']!.text.trim(),
    );

    context.read<AuthBloc>().add(AuthEvent.registerRequested(request: request));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('注册')),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          state.whenOrNull(
            authenticated: (_) => context.go('/home'),
            unauthenticated: (error) {
              if (error != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(error)),
                );
              }
            },
          );
        },
        builder: (context, state) {
          final isLoading = state is _Loading;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _controllers['username'],
                    decoration: const InputDecoration(
                      labelText: '用户名 *',
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                    validator: validateUsername,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: _controllers['phone'],
                    decoration: const InputDecoration(
                      labelText: '手机号 *',
                      prefixIcon: Icon(Icons.phone_outlined),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: validatePhone,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: _controllers['studentId'],
                    decoration: const InputDecoration(
                      labelText: '学号（选填）',
                      prefixIcon: Icon(Icons.badge_outlined),
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: _controllers['nickname'],
                    decoration: const InputDecoration(
                      labelText: '昵称（选填）',
                      prefixIcon: Icon(Icons.face_outlined),
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: _controllers['password'],
                    decoration: InputDecoration(
                      labelText: '密码 *',
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(_obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () => setState(
                            () => _obscurePassword = !_obscurePassword),
                      ),
                    ),
                    obscureText: _obscurePassword,
                    validator: validatePassword,
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: _controllers['confirmPassword'],
                    decoration: InputDecoration(
                      labelText: '确认密码 *',
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(_obscureConfirm
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () => setState(
                            () => _obscureConfirm = !_obscureConfirm),
                      ),
                    ),
                    obscureText: _obscureConfirm,
                    validator: (v) {
                      if (v == null || v.isEmpty) return '请确认密码';
                      if (v != _controllers['password']!.text) return '两次密码不一致';
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: isLoading ? null : _onRegister,
                    child: isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('注册'),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () => context.go('/login'),
                    child: const Text('已有账号？立即登录'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
