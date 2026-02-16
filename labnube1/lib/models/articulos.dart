class Articulos {
  // ignore: non_constant_identifier_names
  String? Imagen, Nombre;
  // ignore: non_constant_identifier_names
  int? Popularidad;

  Articulos({
    // ignore: non_constant_identifier_names
    this.Imagen,
    // ignore: non_constant_identifier_names
    this.Nombre,
    // ignore: non_constant_identifier_names
    this.Popularidad,
  });

  toMap() {
    return {
      'Imagen': Imagen,
      'Nombre': Nombre,
      'Popularidad': Popularidad,
    };
  }
}
