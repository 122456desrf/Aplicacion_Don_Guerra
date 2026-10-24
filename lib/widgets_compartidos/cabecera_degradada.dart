// Banner de saludo con degradado para los paneles de admin y artesano.
import 'package:flutter/material.dart';
import '../configuracion/tema_app.dart';
import 'animaciones.dart';

class CabeceraDegradada extends StatelessWidget {
  final String saludo;
  final String subtitulo;
  final String emoji;
  final Gradient gradiente;
  const CabeceraDegradada({
    super.key,
    required this.saludo,
    required this.subtitulo,
    required this.emoji,
    this.gradiente = degradadoCalido,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: gradiente,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: colorTerracota.withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          const Positioned(
              right: -30, top: -34, child: BurbujaDecorativa(tamano: 110)),
          const Positioned(
              right: 40,
              bottom: -40,
              child: BurbujaDecorativa(tamano: 80, opacidad: 0.07)),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(saludo,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w900)),
                    const SizedBox(height: 4),
                    Text(subtitulo,
                        style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.85))),
                  ],
                ),
              ),
              Text(emoji, style: const TextStyle(fontSize: 46)),
            ],
          ),
        ],
      ),
    );
  }
}
