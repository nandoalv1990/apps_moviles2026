// Importamos el paquete material design de Flutter y el modelo CardItem
import 'package:flutter/material.dart';
import '../models/card_item.dart';

/// Widget reutilizable que representa una tarjeta con imagen y título
/// Se usa para mostrar items en una lista o galería que permite deslizar
class SwipeCard extends StatelessWidget {
  // Propiedad que almacena los datos del item (imagen y nombre)
  final CardItem item;

  // Constructor con parámetro requerido que recibe un CardItem
  const SwipeCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    // Retornamos una Card con efecto de sombra
    return Card(
      elevation: 6, // Altura de la sombra (6 puntos)
      // Forma de la tarjeta: esquinas redondeadas de 20 píxeles
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      // ClipRRect recorta los elementos para que se ajusten al borde redondeado
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        // Stack permite superponer widgets uno sobre otro
        child: Stack(
          fit: StackFit.expand, // Expande el Stack para llenar todo el espacio
          children: [
            // Cargamos la imagen desde una URL
            Image.network(
              item.image,
              fit: BoxFit.cover, // La imagen cubre toda el área sin distorsionarse
            ),
            // Contenedor con el gradiente y el texto del título
            Container(
              alignment: Alignment.bottomLeft, // Posiciona el contenido abajo a la izquierda
              padding: const EdgeInsets.all(16), // 16 píxeles de espaciado
              // Decoración con gradiente: negro abajo que se desvanece hacia arriba
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black, Colors.transparent],
                  begin: Alignment.bottomCenter, // Comienza abajo (negro)
                  end: Alignment.center, // Termina al centro (transparente)
                ),
              ),
              // Texto con el nombre del item
              child: Text(
                item.name,
                style: const TextStyle(
                  color: Colors.white, // Texto blanco
                  fontSize: 24, // Tamaño 24
                  fontWeight: FontWeight.bold, // Texto en negrita
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}