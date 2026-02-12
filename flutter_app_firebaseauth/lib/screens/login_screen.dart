import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'register_screen.dart';
//import 'package:flutter_login';

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

    Widget _buildForgotPasswordBtn(){
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
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
    );
  }

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
            // Integrar boton para ver contraseña
            TextField(
              controller: _passCtrl,
              decoration: const InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            // El usuario olvida su contraseña
            spacer,
            ElevatedButton(
              onPressed: _login, 
              child: const Text('Iniciar seson'),
            ),
            spacer,
            _buildForgotPasswordBtn(),
          ],
        ),
        ),
    );
  }
}