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
}