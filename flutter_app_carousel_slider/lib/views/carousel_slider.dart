import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselSlider extends StatefulWidget {
  const CarouselSlider({super.key});

  @override
  State<CarouselSlider> createState() => _CarouselSliderState();
}

class _CarouselSliderState extends State<CarouselSlider> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.amber,
          leading: Row(
            children: [
              <Widget>[
                SizedBox(
                  width: 5.0,
                ),
                IconButton(
                  onPressed: (){}, 
                  icon: const Icon(Icons.arrow_back),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}