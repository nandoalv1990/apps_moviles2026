import 'package:flutter/material.dart';
import 'package:labnube1/firebase/products_fb.dart';

class ListaArticulos extends StatefulWidget {
  const ListaArticulos({super.key});

  @override
  State<ListaArticulos> createState() => _ListaArticulosState();
}

class _ListaArticulosState extends State<ListaArticulos> {
  ProductsFireBase? products;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    products = ProductsFireBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: products!.callArt(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return Text(snapshot.data!.docs[index].get('Nombre'));
              },
            );
          } else if (snapshot.hasError) {
            return const Text('Err01');
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
