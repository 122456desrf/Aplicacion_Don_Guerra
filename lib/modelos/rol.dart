// Roles de usuario: administrador, artesano y cliente.

enum Rol { admin, artesano, cliente }

extension RolX on Rol {
  String get nombre => switch (this) {
        Rol.admin => 'Administrador',
        Rol.artesano => 'Artesano',
        Rol.cliente => 'Cliente',
      };
}
