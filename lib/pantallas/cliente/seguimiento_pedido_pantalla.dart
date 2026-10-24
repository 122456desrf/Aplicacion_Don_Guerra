// Seguimiento de un pedido con su línea de tiempo.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../configuracion/tema_app.dart';
import '../../modelos/modelos.dart';
import '../../proveedores/pedidos_provider.dart';
import '../../utilidades/formato.dart';
import '../../widgets_compartidos/estado_vacio.dart';
import '../../widgets_compartidos/etiqueta_estado_pedido.dart';
import '../../widgets_compartidos/linea_tiempo_pedido.dart';

/// Seguimiento del pedido (vista del cliente).
class SeguimientoPedidoPantalla extends StatelessWidget {
  final int pedidoId;
  const SeguimientoPedidoPantalla({super.key, required this.pedidoId});

  @override
  Widget build(BuildContext context) {
    final p = context.watch<PedidosProvider>().porId(pedidoId);
    if (p == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Seguimiento de pedido')),
        body: const EstadoVacio(
            icono: Icons.search_off,
            titulo: 'Pedido no encontrado',
            mensaje: 'Este pedido ya no existe.'),
      );
    }
    return Scaffold(
      appBar: AppBar(title: Text('Pedido ${p.codigo}')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(p.producto,
              style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: colorMarronOscuro)),
          const SizedBox(height: 6),
          Align(
              alignment: Alignment.centerLeft,
              child: EtiquetaEstadoPedido(estado: p.estado)),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Cantidad: ${p.cantidad} pza'),
                  Text('Total: ${totalTexto(p)}'),
                  Text('Pedido el ${fechaCorta(p.fechaPedido)}'),
                  if (p.fechaEntrega != null)
                    Text('Entrega estimada: ${fechaCorta(p.fechaEntrega!)}'),
                  if (p.colorDiseno != null) Text('Color: ${p.colorDiseno}'),
                  if (p.personalizacion != null)
                    Text('Personalización: ${p.personalizacion}'),
                  if (p.nota != null) ...[
                    const Divider(),
                    Text('Nota del artesano: ${p.nota}'),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 22),
          const Text('Estado del trabajo artesanal',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                  color: colorMarronOscuro)),
          const SizedBox(height: 14),
          LineaTiempoPedido(estado: p.estado),
        ],
      ),
    );
  }
}
