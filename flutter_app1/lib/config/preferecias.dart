import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Clase de utilidades para manejar el tema y el estilo de la barra de estado / navegación
// Contiene lógica para aplicar estilos dependientes de la plataforma (Android/iOS)
class Preferecias {
  // Notifier que almacena el brillo actual (claro/oscuro). La UI se puede suscribir para reaccionar.
  static ValueNotifier<Brightness> tema = ValueNotifier(Brightness.light);
  
  // Llama al sistema para obtener el brillo actual y actualiza el ValueNotifier
  // También actualiza los estilos de la barra de estado y navegación
  static void setTema(){
    tema.value = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    changeStatusNavigationBar();
  }

  // Configura los colores y la visibilidad de iconos de la status bar y navigation bar
  // Ajusta propiedades según si estamos en modo oscuro o claro
  static void changeStatusNavigationBar() {
    bool isDark = tema.value == Brightness.dark;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      // Iconos en la status bar: en modo oscuro ponemos iconos claros para contraste
      statusBarIconBrightness: isDark? Brightness.light : Brightness.dark,
      // Nota: aquí se usa Brightness.light en ambos casos para statusBarBrightness; ajustar si hace falta
      statusBarBrightness: isDark? Brightness.light : Brightness.light,
      // Color de la status bar según el modo
      statusBarColor: isDark? Colors.blueGrey : Colors.blueAccent,
      // Iconos y color de la barra de navegación
      systemNavigationBarIconBrightness: isDark? Brightness.light : Brightness.dark,
      systemNavigationBarColor: isDark? Colors.blueGrey.shade200 : Colors.white,
    ));
  }
}