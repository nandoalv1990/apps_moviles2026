import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        email: _emailCtrl, 
        phone: _phoneCtrl, 
        name: _nameCtrl, 
        password: _passCtrl,
        imagePath: _profileImage?.path
      );
      setState(() => _loading = true;
    }

   // Future.delayed
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}