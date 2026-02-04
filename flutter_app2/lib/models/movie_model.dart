// Clase que representa un modelo de película
class MovieModel {
  final String id;
  final String title;
  final String description;
  final double rating;
  final String posterURL;

  // Constructor de la clase MovieModel
MovieModel({
    required this.id,
    required this.title,
    required this.description,
    required this.rating,
    required this.posterURL,
  });

  // Método de "fábrica" para crear una instancia de MovieModel desde Firestore
factory MovieModel.fromFirestore(Map<String, dynamic> data, String id){
    return MovieModel(
      id: id,
      title: data['title'],
      description: data['descripton'],
      rating: data['rating'],
      posterURL: data['posterURL'],
    );
  }
// Convierte la instancia de MovieModel a un mapa para almacenamiento

  Map<String, dynamic> toMap() {
    return {
      'title':title,
      'description':description,
      'rating': rating,
      'posterURL': posterURL,
      'createdAt':DateTime.now(),
    };
  }
}