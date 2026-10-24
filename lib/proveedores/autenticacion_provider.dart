// Estado de sesión: login, registro, usuarios y usuario actual.
import 'package:flutter/foundation.dart';
import '../modelos/modelos.dart';

/// Maneja la sesión y la lista de usuarios (en memoria).
class AutenticacionProvider extends ChangeNotifier {
  final List<Usuario> _usuarios = [
    Usuario(
        id: 1,
        nombre: 'Don Guerra',
        correo: 'admin@donguerra.com',
        contrasena: 'Admin123',
        rol: Rol.admin,
        fechaRegistro: DateTime(2026, 9, 1)),
    Usuario(
        id: 2,
        nombre: 'Luis Alfarero',
        correo: 'artesano@donguerra.com',
        contrasena: 'Artesano123',
        rol: Rol.artesano,
        fechaRegistro: DateTime(2026, 9, 2)),
    Usuario(
        id: 3,
        nombre: 'Sofía Rodríguez',
        correo: 'cliente@donguerra.com',
        contrasena: 'Cliente123',
        rol: Rol.cliente,
        fechaRegistro: DateTime(2026, 9, 10)),
  ];

  Usuario? _actual;

  Usuario? get actual => _actual;
  List<Usuario> get usuarios => List.unmodifiable(_usuarios);

  /// Devuelve null si todo salió bien, o el mensaje de error.
  String? iniciarSesion(String correo, String contrasena) {
    final c = correo.trim().toLowerCase();
    for (final u in _usuarios) {
      if (u.correo == c && u.contrasena == contrasena) {
        _actual = u;
        notifyListeners();
        return null;
      }
    }
    return 'Correo o contraseña incorrectos';
  }

  String? registrar({
    required String nombre,
    required String correo,
    required String contrasena,
    required Rol rol,
  }) {
    final c = correo.trim().toLowerCase();
    if (_usuarios.any((u) => u.correo == c)) {
      return 'Ya existe una cuenta con ese correo';
    }
    final nuevo = Usuario(
      id: _usuarios.length + 1,
      nombre: nombre.trim(),
      correo: c,
      contrasena: contrasena,
      rol: rol,
      fechaRegistro: DateTime.now(),
    );
    _usuarios.add(nuevo);
    _actual = nuevo;
    notifyListeners();
    return null;
  }

  void cerrarSesion() {
    _actual = null;
    notifyListeners();
  }
}
