import 'package:flutter/material.dart';
import 'package:flutter_app1/config/preferecias.dart';
import './src/register_screen.dart';

// Punto de entrada de la aplicación
void main() {
  runApp(const MainApp());
}

// Widget principal de la aplicación: estado responsable del tema y observador de cambios del sistema
class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with WidgetsBindingObserver {
  @override
  void initState() {
    // Nos registramos como observador para detectar cambios del sistema
    WidgetsBinding.instance.addObserver(this);

    // Inicializamos el tema según la preferencia / brillo del sistema
    Preferecias.setTema();
    super.initState();
  }

  @override 
  void dispose(){
    // Quitamos el observador al destruir el widget
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness(){
    // Se llama cuando cambia el brillo (modo claro/oscuro) del sistema
    // Actualizamos la preferencia para que la UI se adapte automáticamente
    Preferecias.setTema();
  }

  @override
  Widget build(BuildContext context) {
    // Usamos ValueListenableBuilder para reconstruir la app cuando cambie Preferecias.tema
    return ValueListenableBuilder(
      valueListenable: Preferecias.tema,
      builder: (BuildContext context, Brightness tema, _) => MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: tema, // Brightness.light o Brightness.dark
        ),
        debugShowCheckedModeBanner: false,
        home: const RegisterScreen(),
      ),
    );
  }
}
