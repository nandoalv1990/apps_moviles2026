import 'package:flutter/material.dart';
import '../models/card_item.dart';
import '../widgets/swipe_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CardItem> cards = [
    CardItem(name: 'Ana', image: 'image', description: 'description'),
    CardItem(name: 'Jane', image: 'image', description: 'description'),
    CardItem(name: 'Maria', image: 'image', description: 'description'),
  ];

  
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}