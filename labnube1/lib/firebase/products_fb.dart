import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:labnube1/models/articulos.dart';

class ProductsFireBase {
  FirebaseFirestore? conFS;

  // ignore: non_constant_identifier_names
  CollectionReference? ArticulosCollection;
  //Constructor
  ProductsFireBase() {
    conFS = FirebaseFirestore.instance;
    ArticulosCollection = conFS!.collection('Articulos');
  }

  Future<void> insertArt(Articulos art) async {
    return ArticulosCollection!.doc().set(art.toMap());
  }

  // ignore: non_constant_identifier_names
  Future<void> updateArt(Articulos art, String ID) async {
    return ArticulosCollection!.doc(ID).update(art.toMap());
  }

  // ignore: non_constant_identifier_names
  Future<void> delArt(String ID) async {
    return ArticulosCollection!.doc(ID).delete();
  }

  Stream<QuerySnapshot> callArt() {
    return ArticulosCollection!.snapshots();
  }
}
