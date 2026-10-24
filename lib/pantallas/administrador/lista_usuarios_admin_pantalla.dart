// LISTA de usuarios registrados.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../configuracion/tema_app.dart';
import '../../modelos/modelos.dart';
import '../../proveedores/autenticacion_provider.dart';
import '../../utilidades/formato.dart';
import '../../widgets_compartidos/animaciones.dart';
import '../../widgets_compartidos/boton_cerrar_sesion.dart';
import '../../widgets_compartidos/estado_vacio.dart';

class ListaUsuariosAdminPantalla extends StatelessWidget {
  const ListaUsuariosAdminPantalla({super.key});

  @override
  Widget build(BuildContext context) {
    final usuarios = context.watch<AutenticacionProvider>().usuarios;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuarios'),
        actions: const [BotonCerrarSesion()],
      ),
      body: usuarios.isEmpty
          ? const EstadoVacio(
              icono: Icons.people_outline,
              titulo: 'No hay elementos',
              mensaje: 'Todavía no hay usuarios registrados.')
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: usuarios.length,
              itemBuilder: (_, i) {
                final u = usuarios[i];
                final (Color color, IconData icono) = switch (u.rol) {
                  Rol.admin => (colorTalavera, Icons.admin_panel_settings),
                  Rol.artesano => (colorOcre, Icons.handyman),
                  Rol.cliente => (colorTurquesa, Icons.shopping_bag),
                };
                return Aparicion(
                  retraso: Aparicion.escalon(i),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: colorMarronOscuro.withValues(alpha: 0.07),
                          blurRadius: 14,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: color.withValues(alpha: 0.16),
                          child: Icon(icono, color: color),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(u.nombre,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: colorMarronOscuro)),
                              Text(u.correo,
                                  style: const TextStyle(
                                      fontSize: 12.5, color: colorMarron)),
                              Text('Registro: ${fechaCorta(u.fechaRegistro)}',
                                  style: const TextStyle(
                                      fontSize: 11.5,
                                      color: colorMarronClaro)),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.14),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(u.rol.nombre,
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                  color: color)),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
