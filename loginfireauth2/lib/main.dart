import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'services/auth_service.dart';

// Punto de entrada de la aplicación.
// Inicializa Firebase y luego arranca el widget raíz.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

// Widget raíz de la app. Detecta el estado de autenticación y muestra
// la pantalla de inicio o la de login según corresponda.
// Utiliza StreamBuilder para escuchar los cambios de sesión en tiempo real.
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: AuthService().authStateChanges, 
        builder: (context, snapshot){
          // mientras se establece la conexión con Firebase mostramos un
          // indicador de carga
          if (snapshot.connectionState == ConnectionState.waiting){
            return const Scaffold(
              body: Center(child: CircularProgressIndicator(),),
            );
          }
          // si hay usuario logueado mostramos Home; si no, Login
          return snapshot.hasData ? const HomeScreen() : const LoginScreen();
        }
        ),
    );
  }
}
