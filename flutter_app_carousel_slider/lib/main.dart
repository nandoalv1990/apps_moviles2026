import 'package:flutter/material.dart';
import 'package:flutter_app_carousel_slider/views/carousel_slider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CarouselSlider();
  }
}
