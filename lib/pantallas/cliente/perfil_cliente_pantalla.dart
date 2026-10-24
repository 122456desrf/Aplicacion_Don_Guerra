// Perfil del cliente y cierre de sesión.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../configuracion/navegacion_por_rol.dart';
import '../../configuracion/tema_app.dart';
import '../../modelos/modelos.dart';
import '../../proveedores/autenticacion_provider.dart';
import '../../proveedores/pedidos_provider.dart';
import '../../widgets_compartidos/animaciones.dart';
import '../../widgets_compartidos/tarjeta_estadistica.dart';

class PerfilClientePantalla extends StatelessWidget {
  const PerfilClientePantalla({super.key});

  @override
  Widget build(BuildContext context) {
    final u = context.watch<AutenticacionProvider>().actual!;
    final pedidos = context.watch<PedidosProvider>().pedidosDe(u.id);
    final activos = pedidos.where((p) => p.estado.index < 3).length;

    return Scaffold(
      appBar: AppBar(title: const Text('Mi perfil')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Aparicion(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 24),
              decoration: BoxDecoration(
                gradient: degradadoCalido,
                borderRadius: BorderRadius.circular(24),
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  const Positioned(
                      right: -30,
                      top: -40,
                      child: BurbujaDecorativa(tamano: 130)),
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: const CircleAvatar(
                          radius: 42,
                          backgroundColor: colorBeige,
                          child: Text('👩‍🎨', style: TextStyle(fontSize: 44)),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(u.nombre,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              color: Colors.white)),
                      Text(u.correo,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.85))),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.22),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(u.rol.nombre,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 112,
            child: Row(
              children: [
                Expanded(
                    child: Aparicion(
                  retraso: Aparicion.escalon(1),
                  child: TarjetaEstadistica(
                      icono: Icons.local_shipping_outlined,
                      valor: '$activos',
                      etiqueta: 'Pedidos activos',
                      color: colorOcre),
                )),
                const SizedBox(width: 12),
                Expanded(
                    child: Aparicion(
                  retraso: Aparicion.escalon(2),
                  child: TarjetaEstadistica(
                      icono: Icons.history,
                      valor: '${pedidos.length}',
                      etiqueta: 'Pedidos en total',
                      color: colorTurquesa),
                )),
              ],
            ),
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: () => cerrarSesionYVolverAlLogin(context),
            icon: const Icon(Icons.logout),
            label: const Text('Cerrar sesión'),
          ),
        ],
      ),
    );
  }
}
