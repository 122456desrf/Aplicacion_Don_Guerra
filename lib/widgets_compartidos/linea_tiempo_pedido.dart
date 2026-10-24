// Línea de tiempo del trabajo artesanal (animada y con colores por etapa).
import 'package:flutter/material.dart';
import '../configuracion/tema_app.dart';
import '../modelos/modelos.dart';
import 'animaciones.dart';
import 'etiqueta_estado_pedido.dart';

/// Línea de tiempo del trabajo artesanal.
class LineaTiempoPedido extends StatelessWidget {
  final EstadoPedido estado;
  const LineaTiempoPedido({super.key, required this.estado});

  @override
  Widget build(BuildContext context) {
    final etapas = EstadoPedido.values;
    return Column(
      children: [
        for (final e in etapas)
          Aparicion(
            retraso: Aparicion.escalon(e.index),
            desplazamiento: const Offset(-0.1, 0),
            child: _Etapa(
              etapa: e,
              actual: e == estado,
              completada: e.index < estado.index,
              esUltima: e == etapas.last,
            ),
          ),
      ],
    );
  }
}

class _Etapa extends StatelessWidget {
  final EstadoPedido etapa;
  final bool actual;
  final bool completada;
  final bool esUltima;
  const _Etapa({
    required this.etapa,
    required this.actual,
    required this.completada,
    required this.esUltima,
  });

  @override
  Widget build(BuildContext context) {
    final alcanzada = actual || completada;
    final color = alcanzada ? colorDeEstado(etapa) : Colors.grey.shade400;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 44,
            child: Column(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: alcanzada ? color : Colors.white,
                    border: Border.all(color: color, width: 2),
                    boxShadow: actual
                        ? [
                            BoxShadow(
                              color: color.withValues(alpha: 0.45),
                              blurRadius: 14,
                              spreadRadius: 2,
                            ),
                          ]
                        : null,
                  ),
                  child: Icon(
                    completada ? Icons.check : iconoDeEstado(etapa),
                    size: 18,
                    color: alcanzada ? Colors.white : Colors.grey.shade400,
                  ),
                ),
                if (!esUltima)
                  Expanded(
                    child: Container(
                      width: 3,
                      margin: const EdgeInsets.symmetric(vertical: 2),
                      decoration: BoxDecoration(
                        color: completada ? color : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 7, bottom: esUltima ? 0 : 22),
              child: Text(
                etapa.etiqueta,
                style: TextStyle(
                  fontSize: actual ? 16 : 14,
                  fontWeight: actual ? FontWeight.w900 : FontWeight.w600,
                  color: alcanzada ? colorMarronOscuro : Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
