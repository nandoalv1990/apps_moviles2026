/// Modelo simple que representa un usuario de la aplicación.
///
/// Campos:
/// - `name` Nombre completo del usuario
/// - `phone` Teléfono
/// - `email` Email (útil para login)
/// - `password` Contraseña (en una app real no guardes contraseñas en texto claro)
/// - `imagePath` Ruta local opcional a la imagen de perfil
class AppUser {
  final String name;
  final String phone;
  final String email;
  final String password;
  final String? imagePath;

  AppUser({
    required this.email,
    required this.phone,
    required this.name,
    required this.password,
    this.imagePath,
  });

  /// Convierte el modelo a un mapa (útil para tests o envío a backend)
  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
        'email': email,
        'password': password,
        'imagePath': imagePath,
      };

  /// Construye AppUser desde un mapa (ej. respuesta de API)
  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
        name: json['name'] as String,
        phone: json['phone'] as String,
        email: json['email'] as String,
        password: json['password'] as String,
        imagePath: json['imagePath'] as String?,
      );
}