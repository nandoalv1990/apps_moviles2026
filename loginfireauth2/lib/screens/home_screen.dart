// pantalla principal que se muestra tras iniciar sesión
// muestra el email del usuario y permite cerrar sesión
import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = AuthService();
    final userEmail = auth.currentUser?.email ?? '';
    return Scaffold(
      appBar: AppBar( title: Text('Bienvenido $userEmail'),
      actions: [
        IconButton(
          onPressed: auth.logout,
          icon: const Icon(Icons.logout),
        ),
      ],
    ),
    body: Center(
      child: Text('', style: TextStyle(fontSize: 20.0),),
    ),
    // Integrar TODO
    );
  }
}