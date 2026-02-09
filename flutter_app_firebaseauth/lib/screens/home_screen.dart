import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = AuthService();
    return Scaffold(
      appBar: AppBar( title: const Text('Inicio'),
      actions: [
        IconButton(
          onPressed: auth.logout, 
          icon: const Icon(Icons.logout),
        ),
      ],
    ),
    body: const Center(
      child: Text('Sesion inicada', style: TextStyle(fontSize: 20.0),),
    ),
    // Integrar TODO
    );
  }
}