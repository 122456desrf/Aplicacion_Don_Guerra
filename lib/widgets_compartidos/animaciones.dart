// Widgets de animación reutilizables: aparición escalonada, pulsación y contador.
import 'package:flutter/material.dart';

/// Hace que su contenido aparezca con fundido y un pequeño deslizamiento.
/// Usa [retraso] para escalonar varios elementos de una lista.
class Aparicion extends StatefulWidget {
  final Widget child;
  final Duration retraso;
  final Offset desplazamiento;
  const Aparicion({
    super.key,
    required this.child,
    this.retraso = Duration.zero,
    this.desplazamiento = const Offset(0, 0.12),
  });

  /// Retraso escalonado según la posición en la lista (máx. 8 pasos).
  static Duration escalon(int indice) =>
      Duration(milliseconds: 70 * (indice > 8 ? 8 : indice));

  @override
  State<Aparicion> createState() => _AparicionState();
}

class _AparicionState extends State<Aparicion>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 450));
  late final Animation<double> _curva =
      CurvedAnimation(parent: _c, curve: Curves.easeOutCubic);

  @override
  void initState() {
    super.initState();
    if (widget.retraso == Duration.zero) {
      _c.forward();
    } else {
      Future.delayed(widget.retraso, () {
        if (mounted) _c.forward();
      });
    }
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _curva,
      child: SlideTransition(
        position: Tween<Offset>(begin: widget.desplazamiento, end: Offset.zero)
            .animate(_curva),
        child: widget.child,
      ),
    );
  }
}

/// Efecto de "botón que se hunde" al tocar cualquier tarjeta o elemento.
class Presionable extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  const Presionable({super.key, required this.child, this.onTap});

  @override
  State<Presionable> createState() => _PresionableState();
}

class _PresionableState extends State<Presionable> {
  bool _abajo = false;

  void _cambiar(bool v) {
    if (widget.onTap == null) return;
    setState(() => _abajo = v);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => _cambiar(true),
      onTapUp: (_) => _cambiar(false),
      onTapCancel: () => _cambiar(false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _abajo ? 0.96 : 1,
        duration: const Duration(milliseconds: 110),
        curve: Curves.easeOut,
        child: AnimatedOpacity(
          opacity: _abajo ? 0.9 : 1,
          duration: const Duration(milliseconds: 110),
          child: widget.child,
        ),
      ),
    );
  }
}

/// Número que "cuenta" desde 0 hasta [valor] al aparecer.
class NumeroAnimado extends StatelessWidget {
  final int valor;
  final TextStyle? estilo;
  const NumeroAnimado({super.key, required this.valor, this.estilo});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: valor.toDouble()),
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeOutCubic,
      builder: (_, v, __) => Text('${v.round()}', style: estilo),
    );
  }
}

/// Burbujas decorativas semitransparentes para fondos de banners.
class BurbujaDecorativa extends StatelessWidget {
  final double tamano;
  final double opacidad;
  const BurbujaDecorativa({super.key, required this.tamano, this.opacidad = 0.1});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: tamano,
      height: tamano,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withValues(alpha: opacidad),
      ),
    );
  }
}
