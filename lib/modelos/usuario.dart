// Modelo de datos: Usuario.
import 'rol.dart';

class Usuario {
  final int id;
  final String nombre;
  final String correo;
  final String contrasena;
  final Rol rol;
  final DateTime fechaRegistro;

  const Usuario({
    required this.id,
    required this.nombre,
    required this.correo,
    required this.contrasena,
    required this.rol,
    required this.fechaRegistro,
  });
}
