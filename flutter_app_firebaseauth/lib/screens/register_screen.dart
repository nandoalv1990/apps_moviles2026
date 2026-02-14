import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    // Construir el register screen
    return Container();
  }
}