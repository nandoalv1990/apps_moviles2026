import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImagePicker extends StatefulWidget {
  final Function(File?) onImageSelected;

  const ProfileImagePicker({super.key, required this.onImageSelected});

  @override
  State<ProfileImagePicker> createState() => _ProfileImagePickerState();
  }
  class _ProfileImagePickerState extends State<ProfileImagePicker>{
    File? _image;

    Future<void> _pickImage() async {
      final picker = ImagePicker();
      final picked = await picker.pickImage(source: ImageSource.gallery);
      if (picked != null){
        setState(() => _image = File(picked.path));
        widget.onImageSelected(_image);
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