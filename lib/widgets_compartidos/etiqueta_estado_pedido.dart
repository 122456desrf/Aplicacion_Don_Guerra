// Etiqueta de color con el estado del pedido (y colores/iconos por estado).
import 'package:flutter/material.dart';
import '../configuracion/tema_app.dart';
import '../modelos/modelos.dart';

/// Color principal de cada estado del pedido.
Color colorDeEstado(EstadoPedido estado) => switch (estado) {
      EstadoPedido.solicitado => colorTalavera,
      EstadoPedido.enElaboracion => colorOcre,
      EstadoPedido.terminado => colorHoja,
      EstadoPedido.entregado => colorMarronClaro,
    };

IconData iconoDeEstado(EstadoPedido estado) => switch (estado) {
      EstadoPedido.solicitado => Icons.mark_email_unread_outlined,
      EstadoPedido.enElaboracion => Icons.construction,
      EstadoPedido.terminado => Icons.check_circle_outline,
      EstadoPedido.entregado => Icons.local_shipping_outlined,
    };

class EtiquetaEstadoPedido extends StatelessWidget {
  final EstadoPedido estado;
  const EtiquetaEstadoPedido({super.key, required this.estado});

  @override
  Widget build(BuildContext context) {
    final color = colorDeEstado(estado);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(iconoDeEstado(estado), size: 13, color: color),
          const SizedBox(width: 5),
          Text(estado.etiqueta,
              style: TextStyle(
                  color: color, fontSize: 11, fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }
}
