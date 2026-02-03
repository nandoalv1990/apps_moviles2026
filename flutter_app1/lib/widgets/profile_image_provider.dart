import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/// Widget simple para seleccionar una imagen de perfil desde la galería.
///
/// Uso:
/// ```dart
/// ProfileImagePicker(onImageSelected: (file) { /* usa file?.path */ });
/// ```
///
/// Notas:
/// - Usa `image_picker` para abrir la galería. En Android/iOS puede que necesites
///   declarar permisos en el manifiesto (Android) o Info.plist (iOS).
/// - Llama a `onImageSelected` con `null` si no se selecciona imagen.
class ProfileImagePicker extends StatefulWidget {
  final Function(File?) onImageSelected;

  const ProfileImagePicker({super.key, required this.onImageSelected});

  @override
  State<ProfileImagePicker> createState() => _ProfileImagePickerState();
}

class _ProfileImagePickerState extends State<ProfileImagePicker>{
  File? _image;

  Future<void> _pickImage() async {
    // Implementación basada en image_picker que abre la galería.
    // Ajusta o añade permisos según tu plataforma si es necesario.
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null){
      setState(() => _image = File(picked.path));
      // Propagamos la selección hacia el padre
      widget.onImageSelected(_image);
    } else {
      // Si el usuario cancela, avisamos con null (opcional)
      widget.onImageSelected(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: CircleAvatar(
        radius: 50.0,
        backgroundColor: Colors.grey,
        backgroundImage: _image != null ? FileImage(_image!) : null,
        child: _image == null ? const Icon(Icons.camera, size: 30.0,) : null,
      ),
    );
  }
}