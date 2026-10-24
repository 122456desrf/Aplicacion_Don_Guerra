// Botón de cerrar sesión para las barras superiores.
import 'package:flutter/material.dart';
import '../configuracion/navegacion_por_rol.dart';

class BotonCerrarSesion extends StatelessWidget {
  const BotonCerrarSesion({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.logout),
      tooltip: 'Cerrar sesión',
      onPressed: () => cerrarSesionYVolverAlLogin(context),
    );
  }
}
