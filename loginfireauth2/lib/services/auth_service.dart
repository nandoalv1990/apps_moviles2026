// Este servicio abstrae la lógica de autenticación con Firebase.
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // instancia única de FirebaseAuth utilizada internamente
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Crea un usuario con correo y contraseña.
  ///
  /// Propaga cualquier excepción de Firebase para que la UI la maneje.
  Future<void> register(String email, String password) async {
    await _auth.createUserWithEmailAndPassword(
      email: email, 
      password: password
      );
  }

  /// Inicia sesión con correo y contraseña.
  Future<void> login(String email, String password) async{
    await _auth.signInWithEmailAndPassword(
      email: email, 
      password: password
      );
  }

  /// Cierra la sesión actual.
  Future<void> logout() async {
    await _auth.signOut();
  }

  // retorna usuario actual
  User? get currentUser => _auth.currentUser;

  // A stream of authentication state changes.
  Stream<User?> get authStateChanges => _auth.authStateChanges();
}