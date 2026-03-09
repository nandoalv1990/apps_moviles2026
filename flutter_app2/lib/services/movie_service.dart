import 'package:flutter/material.dart';
import '../models/movie_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MovieService {
  final CollectionReference moviesRef = FirebaseFirestore.instance.collection('movies');

  Stream<List<Movie>> getMovies() {
    return moviesRef.snapshots().map((Snapshot){
      return snapshot.docs.map((doc)=>)
    });
  }
  
}

