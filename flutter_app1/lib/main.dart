import 'package:flutter/material.dart';
import 'package:flutter_app1/config/preferecias.dart';
import './src/register_screen.dart';
import './config/preferecias.dart';
void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    Preferecias.setTema();
    super.initState();
  }

  @override 
  void dispose(){
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void changePlatformB(){
    Preferecias.setTema();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Preferecias.tema,
      builder: (BuildContext context, Brightness tema, _) => MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: tema,
        ),
        debugShowCheckedModeBanner: false,
        home: const RegisterScreen(),
      ),
    );
  }
}
