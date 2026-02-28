import 'package:flutter/material.dart';
import '../screens/login_screen.dart';
import '../services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() =>  RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _auth = AuthService();
  final _passConCtrl = TextEditingController();

  Future<void> _register() async {
    try {
      await _auth.register(
        _emailCtrl.text.trim(), 
        _passCtrl.text.trim(),
      );
      Navigator.pop(context);
    }catch (e){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se pudo registrar'))
      );
    }
  }

  final spacer = const SizedBox(height: 20.0,);


  Widget _buildEmailTxtf () {
    return Container(
      alignment: Alignment.center,
      child: TextField(
              controller: _emailCtrl,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
    );
  }

  Widget _buildPasswordTxtf () {
  return Container(
    alignment: Alignment.center,
    child: TextField(
              controller: _passCtrl,
              decoration: const InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
  );
}

Widget _buildConfirmPassTxtf () {
  return Container(
    alignment: Alignment.center,
    child: TextField(
              controller: _passConCtrl,
              decoration: const InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
  );
}

Widget _buildRegisterBtn () {
  return Container(
    alignment: Alignment.center,
    child: ElevatedButton(
      onPressed: _register, 
      child: const Text('Registar'),
    ),
  );
}


    Widget _buildLoginrBtn(){
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (_) => const LoginScreen()
                    ),
                  );
              },
              child: const Text('Ya tengo una cuenta'),
              ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Construir el register screen
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nueva cuenta"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _buildEmailTxtf(),
            spacer,
            _buildPasswordTxtf(),
            spacer,
            _buildConfirmPassTxtf(),
            spacer,
            _buildRegisterBtn(),
            spacer,
            _buildLoginrBtn(),
          ],
        ),
      ),
    );
  }
}