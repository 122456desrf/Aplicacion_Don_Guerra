// Tarjeta de pedido para las listas de cliente y artesano.
import 'package:flutter/material.dart';
import '../configuracion/tema_app.dart';
import '../modelos/modelos.dart';
import '../utilidades/formato.dart';
import 'animaciones.dart';
import 'etiqueta_estado_pedido.dart';

/// Tarjeta de pedido usada en las listas de cliente y artesano.
class TarjetaPedido extends StatelessWidget {
  final Pedido pedido;
  final bool mostrarCliente;
  final VoidCallback onTap;
  const TarjetaPedido({
    super.key,
    required this.pedido,
    required this.onTap,
    this.mostrarCliente = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = colorDeEstado(pedido.estado);
    return Presionable(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
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
        clipBehavior: Clip.antiAlias,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(width: 6, color: color),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(14, 14, 8, 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${pedido.codigo} · ${pedido.producto}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 15,
                              color: colorMarronOscuro)),
                      const SizedBox(height: 4),
                      Text(
                        '${mostrarCliente ? '${pedido.clienteNombre} · ' : ''}'
                        '${pedido.cantidad} pza · ${totalTexto(pedido)}',
                        style: const TextStyle(color: colorMarron),
                      ),
                      const SizedBox(height: 2),
                      Text(fechaCorta(pedido.fechaPedido),
                          style: const TextStyle(
                              fontSize: 12, color: colorMarronClaro)),
                      const SizedBox(height: 10),
                      EtiquetaEstadoPedido(estado: pedido.estado),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(Icons.chevron_right, color: colorMarronClaro),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
