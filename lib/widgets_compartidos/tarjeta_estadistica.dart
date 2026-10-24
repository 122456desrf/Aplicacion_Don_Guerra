// Tarjeta con un número y su etiqueta (dashboards), con color y conteo animado.
import 'package:flutter/material.dart';
import '../configuracion/tema_app.dart';
import 'animaciones.dart';

class TarjetaEstadistica extends StatelessWidget {
  final IconData icono;
  final String valor;
  final String etiqueta;
  final Color color;
  const TarjetaEstadistica({
    super.key,
    required this.icono,
    required this.valor,
    required this.etiqueta,
    this.color = colorTerracota,
  });

  @override
  Widget build(BuildContext context) {
    const estiloValor = TextStyle(
        fontSize: 24, fontWeight: FontWeight.w900, color: Colors.white);
    final numero = int.tryParse(valor);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          colors: [color, Color.lerp(color, colorMarronOscuro, 0.35)!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.22),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icono, color: Colors.white, size: 18),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: numero != null
                    ? NumeroAnimado(valor: numero, estilo: estiloValor)
                    : Text(valor, style: estiloValor),
              ),
              Text(etiqueta,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withValues(alpha: 0.9))),
            ],
          ),
        ],
      ),
    );
  }
}
