import 'package:flutter/material.dart';

class MovieListScreen extends StatelessWidget {
  const MovieListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MovieRate'),),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context, 
           MaterialPageRoute(
              builder: (_) => AddMovieScreen()
            ),
          );
        },
      ),
      body: StreamBuilder<List<Movie>>(
        stream: null,
        builder: (context, snapshot) {
          return const Center(child: Text('No movies'));
        },
      ),
    );
  }
}