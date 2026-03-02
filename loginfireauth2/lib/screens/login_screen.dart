// Pantalla de inicio de sesión. Captura email y contraseña y usa
// AuthService para autenticar.
import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'register_screen.dart';
import 'home_screen.dart';
//import 'package:flutter_login';

// StatefulWidget porque mantiene el estado de los campos y si la
// contraseña está visible
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // controladores para leer los valores de los TextFields
  final _emailCtrl =TextEditingController();
  final _passCtrl = TextEditingController();
  // servicio de autenticación compartido
  final _auth = AuthService();
  // flag para alternar visibilidad de la contraseña
  bool _isPasswordVisible = false;

  /// Intenta iniciar sesión con el servicio y navega a Home si OK.
  ///
  /// Si falla muestra un SnackBar con error. También protege el uso de
  /// `context` con checks de `mounted`.
  Future<void> _login() async {
    try {
      await _auth.login(
        _emailCtrl.text.trim(), 
        _passCtrl.text.trim(),
      );
      if (!mounted) return;
      // reemplazamos la ruta actual para que el usuario no pueda volver
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Por favor revise sus datos')
          )
        );
      }
    }
  }

  // espaciador reutilizable entre widgets
  final spacer = const SizedBox(height: 20.0,);

    // botón que lleva a la pantalla de registro
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

  // botón principal de la pantalla para disparar el login
  Widget _buildLoginBtn (){
    return Container(
      alignment: Alignment.topCenter,
      child: ElevatedButton(
              onPressed: _login, 
              child: const Text('Iniciar sesión'),
            ),
    );
  }

  // campo de texto para ingresar el email con validación básica
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
      // Pendiente integrar funcionalidad
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