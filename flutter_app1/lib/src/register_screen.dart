import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app1/widgets/profile_image_provider.dart';
import '../models/user_model.dart';

// Pantalla de registro: formulario sencillo para crear una cuenta
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Clave del formulario para validar
  final _formkey = GlobalKey<FormState>();

  // Controladores para los campos de texto
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _secretCtrl = TextEditingController();

  // Imagen de perfil seleccionada (opcional)
  File? _profileImage;
  // Estado de carga cuando se envía el formulario
  bool _loading = false;

  @override
  void dispose() {
    // Limpiamos los controladores para liberar recursos
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _secretCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    // Corregido: si la validación falla, salimos. Antes la condición estaba invertida.
    if (!_formkey.currentState!.validate()) return;

    // Retroalimentación háptica al enviar
    HapticFeedback.mediumImpact();

    // Construimos el usuario con los valores del formulario
    final user = AppUser(
      email: _emailCtrl.text,
      phone: _phoneCtrl.text,
      name: _nameCtrl.text,
      password: _passCtrl.text,
      imagePath: _profileImage?.path,
    );

    // Marcamos que estamos en estado de carga (por ejemplo para mostrar un spinner)
    setState(() => _loading = true);

    // Aquí es donde normalmente llamarías al backend o guardarías los datos.
    // Por ejemplo: await authService.register(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear cuenta'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                // Widget que permite al usuario seleccionar una imagen de perfil
                ProfileImagePicker(
                  onImageSelected: (img) {
                    // Si quieres que la UI muestre inmediatamente la imagen seleccionada,
                    // envuelve la asignación en setState:
                    setState(() => _profileImage = img);
                  },
                ),
                const SizedBox(height: 24.0,),
                _input(_nameCtrl, 'Nombre', Icons.person),
                _input(_phoneCtrl, 'Teléfono', Icons.phone),
                _input(_emailCtrl, 'Email', Icons.email),
                _password(_passCtrl, 'Contraseña'),
                _password(_secretCtrl, 'Confirmar contraseña', confirm: _passCtrl),
                const SizedBox(height: 24.0,),
                SizedBox(
                  width: double.infinity,
                  height: 48.0,
                  child: _loading
                    ? const Center(child: CircularProgressIndicator(),)
                    : ElevatedButton(
                        onPressed: _submit,
                        child: const Text('Crear cuenta'),
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Entrada de texto genérica con validación mínima
  Widget _input(TextEditingController c, String label, IconData icon, {TextInputType keyboard = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: c,
        keyboardType: keyboard,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: const OutlineInputBorder(),
        ),
        validator: (v) => (v == null || v.isEmpty)? 'Campo requerido' : null,
      ),
    );
  }

  // Campo de contraseña con confirmación opcional
  Widget _password(TextEditingController c, String label, {TextEditingController? confirm}){
    return Padding(
      padding: const EdgeInsetsGeometry.only(bottom: 12.0),
      child: TextFormField(
        controller: c,
        obscureText: true,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: const Icon(Icons.lock),
          border: const OutlineInputBorder(),
        ),
        validator: (v) {
          if (v == null || v.isEmpty) return 'Campo requerido';
          if (confirm != null && v != confirm.text){
            return 'Las contraseñas no coinciden';
          }
          return null;
        },
      ),
    );
  }
}