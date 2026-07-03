import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _userCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  @override
  void dispose() {
    _userCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  void _login() => context.pushReplacement('/dashboard');

  @override
  Widget build(BuildContext context) {
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
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton(onPressed: _login, style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF1B3670), padding: const EdgeInsets.symmetric(vertical: 16)),
                  child: const Text('Ingresar', style: TextStyle(fontSize: 16))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
