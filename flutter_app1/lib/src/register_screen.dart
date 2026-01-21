import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app1/widgets/profile_image_provider.dart';
import '../models/user_model.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formkey = GlobalKey<FormState>();

  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _secretCtrl = TextEditingController();

    File? _profileImage;
    bool _loading =false;

    void _submit(){
      if (_formkey.currentState!.validate()) return;
      HapticFeedback.mediumImpact();
      final user = AppUser(
        email: _emailCtrl.text, 
        phone: _phoneCtrl.text, 
        name: _nameCtrl.text, 
        password: _passCtrl.text,
        imagePath: _profileImage?.path
      );
      setState(() => _loading = true);
    }

   // Future.delayed
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crear cuenta'),),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                ProfileImagePicker(
                  onImageSelected: (img) => _profileImage = img,
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
                  child: _loading? const Center(child: CircularProgressIndicator(),) : 
                  ElevatedButton(
                    onPressed: _submit, 
                    child: const Text('Crear cuenta')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
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
            return 'Las constraseñas no coinciden';
          }
          return null;
        },
      ),
    );
  }
}