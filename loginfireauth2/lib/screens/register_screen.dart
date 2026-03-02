// Pantalla de registro de nuevos usuarios.
// Contiene formulario con validación y manejo de contraseñas.
import 'package:flutter/material.dart';
import '../screens/login_screen.dart';
import '../services/auth_service.dart';

// Stateful porque controla el estado de los campos y la visibilidad
// de las contraseñas.
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() =>  RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  // clave del formulario para ejecutar validaciones
  final _formKey = GlobalKey<FormState>();
  // controladores de texto para leer valores introducidos
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _auth = AuthService();
  final _passConCtrl = TextEditingController();
  // bandeja de visibilidad para mostrar/ocultar contraseña
  bool _isPasswordVisible = false;


  /// Trata de crear un nuevo usuario después de validar el formulario.
  /// Muestra mensajes en SnackBar y regresa a la pantalla anterior si todo
  /// sale bien.
  Future<void> _register() async {
    // primero validamos el formulario
    if (!(_formKey.currentState?.validate() ?? false)) return;
    try {
      await _auth.register(_emailCtrl.text.trim(), _passCtrl.text.trim());
      if (!mounted) return; // proteger el uso de context
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Revise su bandeja de correo'))
        );
      Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No se pudo registrar'))
        );
      }
    }
  }

  // separador vertical entre campos
  final spacer = const SizedBox(height: 20.0,);


  Widget _buildEmailTxtf () {
    return Container(
      alignment: Alignment.center,
      child: TextFormField(
              controller: _emailCtrl,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingrese un email';
                }
                if (!RegExp(r"^[^@\s]+@[^@\s]+\.[^@\s]+$").hasMatch(value)) {
                  return 'Email no válido';
                }
                return null;
              },
            ),
    );
  }

  // campo para la contraseña principal con botón para mostrar/ocultar
  Widget _buildPasswordTxtf () {
  return Container(
    alignment: Alignment.center,
    child: TextFormField(
              controller: _passCtrl,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                  icon: Icon(_isPasswordVisible ? Icons.visibility_off : Icons.visibility),
                ),
              ),
              obscureText: !_isPasswordVisible,
              keyboardType: TextInputType.visiblePassword,
              autofocus: false,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingrese una contraseña';
                }
                if (value.length < 6) {
                  return 'Mínimo 6 caracteres';
                }
                return null;
              },
            ),
  );
}

// campo para repetir contraseña; compara con el otro campo
Widget _buildConfirmPassTxtf () {
  return Container(
    alignment: Alignment.center,
    child: TextFormField(
              controller: _passConCtrl,
              decoration: InputDecoration(
                labelText: 'Repetir contraseña',
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                  icon: Icon(_isPasswordVisible ? Icons.visibility_off : Icons.visibility),
                ),
              ),
              obscureText: !_isPasswordVisible,
              keyboardType: TextInputType.visiblePassword,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Reingrese la contraseña';
                }
                if (value != _passCtrl.text) {
                  return 'Las contraseñas no coinciden';
                }
                return null;
              },
            ),
  );
}

// botón que envía el formulario de registro
Widget _buildRegisterBtn () {
  return Container(
    alignment: Alignment.center,
    child: ElevatedButton(
      onPressed: _register, 
      child: const Text('Registar'),
    ),
  );
}


    // botón para volver a la pantalla de login si el usuario ya tiene cuenta
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
        child: Form(
          key: _formKey,
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
      ),
    );
  }
}