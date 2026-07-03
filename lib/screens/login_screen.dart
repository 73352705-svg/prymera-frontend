import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});
  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _userCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  @override
  void dispose() {
    _userCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  void _login() {
    ref.read(authProvider.notifier).login(_userCtrl.text.trim(), _passCtrl.text);
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);
    ref.listen<AuthState>(authProvider, (_, state) {
      if (state.loggedIn) context.pushReplacement('/dashboard');
    });

    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.admin_panel_settings, size: 72, color: Color(0xFF1B3670)),
              const SizedBox(height: 8),
              const Text('Prymera', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF1B3670))),
              const Text('Panel de Supervision', style: TextStyle(fontSize: 14, color: Colors.grey)),
              const SizedBox(height: 32),
              TextField(controller: _userCtrl, decoration: const InputDecoration(labelText: 'Usuario', prefixIcon: Icon(Icons.person))),
              const SizedBox(height: 16),
              TextField(controller: _passCtrl, obscureText: true, decoration: const InputDecoration(labelText: 'Contrasena', prefixIcon: Icon(Icons.lock))),
              if (auth.error != null) Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(auth.error!, style: const TextStyle(color: Colors.red, fontSize: 13)),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: auth.loading ? null : _login,
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF1B3670), padding: const EdgeInsets.symmetric(vertical: 16)),
                  child: auth.loading
                      ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                      : const Text('Ingresar', style: TextStyle(fontSize: 16))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
