import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class Preferecias {
  static ValueNotifier<Brightness> tema = ValueNotifier(Brightness.light);
  
  static void setTema(){
    tema.value = WidgetsBinding.instance!.platformDispatcher.platformBrightness;
    changeStatusNavigationBar();
  }

  static changeStatusNavigationBar() {
    bool isDark = tema.value == Brightness.dark;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: isDark? Brightness.light : Brightness.dark,
      statusBarBrightness: isDark? Brightness.light : Brightness.light,
      statusBarColor: isDark? Colors.blueGrey : Colors.blueAccent,
      systemNavigationBarIconBrightness: isDark? Brightness.light : Brightness.dark,
      systemNavigationBarColor: isDark? Colors.blueGrey.shade200 : Colors.white,
    ));
  }
}