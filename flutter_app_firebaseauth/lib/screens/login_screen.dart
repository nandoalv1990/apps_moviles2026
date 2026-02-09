import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCtrl =TextEditingController();
  final _passCtrl = TextEditingController();
  final _auth = AuthService();

  Future<void> _login() async {
    try {
      await _auth.login(
        _emailCtrl.text.trim(), 
        _passCtrl.text.trim(),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor revise sus datos')
          )
        );
    }
  }

  final spacer = const SizedBox(height: 20.0,);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inicio de sesion'),),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _emailCtrl,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            spacer,
            TextField(
              controller: _passCtrl,
              decoration: const InputDecoration(labelText: 'Contrasena'),
              obscureText: true,
            ),
            spacer,
            ElevatedButton(
              onPressed: _login, 
              child: const Text('Iniciar seson'),
            ),
            spacer,
            TextButton(
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (_) => const RegisterScreen()
                    ),
                  );
              },
              child: const Text('Crear cuenta'),
              ),
          ],
        ),
        ),
    );
  }
}