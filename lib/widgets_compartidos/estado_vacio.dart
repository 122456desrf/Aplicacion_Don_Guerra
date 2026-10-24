// Widget "No hay elementos" para listas vacías (con animación suave).
import 'package:flutter/material.dart';
import '../configuracion/tema_app.dart';

/// Estado vacío reutilizable ("No hay elementos").
class EstadoVacio extends StatelessWidget {
  final IconData icono;
  final String titulo;
  final String mensaje;
  final Widget? accion;

  const EstadoVacio({
    super.key,
    required this.icono,
    required this.titulo,
    required this.mensaje,
    this.accion,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.4, end: 1),
              duration: const Duration(milliseconds: 700),
              curve: Curves.elasticOut,
              builder: (_, v, hijo) => Transform.scale(scale: v, child: hijo),
              child: Container(
                padding: const EdgeInsets.all(26),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      colorOcre.withValues(alpha: 0.28),
                      colorTerracota.withValues(alpha: 0.18),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Icon(icono, size: 52, color: colorTerracota),
              ),
            ),
            const SizedBox(height: 20),
            Text(titulo,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                    color: colorMarronOscuro)),
            const SizedBox(height: 8),
            Text(mensaje,
                textAlign: TextAlign.center,
                style: const TextStyle(color: colorMarronClaro, height: 1.4)),
            if (accion != null) ...[
              const SizedBox(height: 20),
              accion!,
            ],
          ],
        ),
      ),
    );
  }
}
