import 'package:card_swipe_app/widgets/swipe_card.dart';
import 'package:flutter/material.dart';
import '../models/card_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<CardItem> cards = [
    CardItem(name: 'Ana', image: 'https://picsum.photos/400/600?1', description: 'description'),
    CardItem(name: 'Jane', image: 'https://picsum.photos/400/600?2', description: 'description'),
    CardItem(name: 'Maria', image: 'https://picsum.photos/400/600?3', description: 'description'),
  ];
  
  void refresh() {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (_) => const HomeScreen()),
  );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dinter'),
        actions: [
          IconButton(
            onPressed: refresh, 
            icon: const Icon(Icons.refresh))
        ],
      ),
      body: Center(
        child: cards.isEmpty? const Text('No Cards') : 
          Dismissible(
            key: ValueKey(cards.last.name), 
            direction: DismissDirection.horizontal, 
            onDismissed: (direction) {
              setState(() {
                cards.removeLast();
              });
            },
            child: SizedBox(
              width: 320,
              height: 500,
              child: SwipeCard(item: cards.last),
            ),
        ),
      ),
    );
  }
}