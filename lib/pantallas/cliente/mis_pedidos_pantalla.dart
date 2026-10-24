// LISTA SECUNDARIA: pedidos del cliente (con estado vacío).
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../proveedores/autenticacion_provider.dart';
import '../../proveedores/pedidos_provider.dart';
import '../../widgets_compartidos/animaciones.dart';
import '../../widgets_compartidos/estado_vacio.dart';
import '../../widgets_compartidos/tarjeta_pedido.dart';
import 'pedido_personalizado_pantalla.dart';
import 'seguimiento_pedido_pantalla.dart';

/// LISTA SECUNDARIA (datos dinámicos): pedidos del cliente, con estado vacío.
class MisPedidosPantalla extends StatelessWidget {
  const MisPedidosPantalla({super.key});

  @override
  Widget build(BuildContext context) {
    final usuario = context.watch<AutenticacionProvider>().actual!;
    final pedidos = context.watch<PedidosProvider>().pedidosDe(usuario.id);

    return Scaffold(
      appBar: AppBar(title: const Text('Mis pedidos')),
      body: pedidos.isEmpty
          ? EstadoVacio(
              icono: Icons.inventory_2_outlined,
              titulo: 'No hay elementos',
              mensaje: 'Aún no has hecho ningún pedido.',
              accion: FilledButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => const PedidoPersonalizadoPantalla())),
                child: const Text('🎨  Pedir una pieza personalizada'),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: pedidos.length,
              itemBuilder: (_, i) => Aparicion(
                retraso: Aparicion.escalon(i),
                child: TarjetaPedido(
                  pedido: pedidos[i],
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) =>
                          SeguimientoPedidoPantalla(pedidoId: pedidos[i].id))),
                ),
              ),
            ),
    );
  }
}
