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

  bool _isPasswordVisible = false;

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

    Widget _buildRegisterBtn(){
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

  Widget _buildLoginBtn (){
    return Container(
      alignment: Alignment.topCenter,
      child: ElevatedButton(
              onPressed: _login, 
              child: const Text('Iniciar seson'),
            ),
    );
  }

  Widget _buildEmailTxtf () {
    return Container(
      alignment: Alignment.center,
      child: TextField(
              controller: _emailCtrl,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
    );
  }

// Ocultar / ver contraseña
Widget _buildPasswordTxtf () {
  return Container(
    alignment: Alignment.center,
    child: TextField(
              key: Key('passw-input'),
              textInputAction: TextInputAction.done,
              controller: _passCtrl,
              autofocus: false,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                suffixIcon: IconButton(
                  icon: Icon(_isPasswordVisible ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
              obscureText: !_isPasswordVisible,
              keyboardType: TextInputType.visiblePassword,
            ),
  );
}

Widget _buildResetPassBtn () {
  return Container(
    alignment: Alignment.bottomCenter,
    child: TextButton(
      onPressed: () {}, 
      child: const Text('Olvidé mi contraseña'),
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
            _buildEmailTxtf(),
            spacer,
            _buildPasswordTxtf(),
            spacer,
            _buildResetPassBtn(),
            spacer,
            _buildLoginBtn(),
            spacer,
            _buildRegisterBtn(),
          ],
        ),
        ),
    );
  }
}