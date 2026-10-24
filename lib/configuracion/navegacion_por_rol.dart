// Lleva al dashboard según el rol y cierra sesión.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../modelos/modelos.dart';
import '../pantallas/administrador/dashboard_admin_pantalla.dart';
import '../pantallas/artesano/dashboard_artesano_pantalla.dart';
import '../pantallas/autenticacion/inicio_sesion_pantalla.dart';
import '../pantallas/cliente/dashboard_cliente_pantalla.dart';
import '../proveedores/autenticacion_provider.dart';

/// Lleva al usuario a su dashboard según su rol.
void irAlDashboardSegunRol(BuildContext context, Rol rol) {
  final Widget destino = switch (rol) {
    Rol.admin => const DashboardAdminPantalla(),
    Rol.artesano => const DashboardArtesanoPantalla(),
    Rol.cliente => const DashboardClientePantalla(),
  };
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (_) => destino),
    (route) => false,
  );
}

void cerrarSesionYVolverAlLogin(BuildContext context) {
  context.read<AutenticacionProvider>().cerrarSesion();
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (_) => const InicioSesionPantalla()),
    (route) => false,
  );
}
