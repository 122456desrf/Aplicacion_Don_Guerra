// Pantalla de carga inicial (3 s, animada) y paso al login.
import 'package:flutter/material.dart';
import '../../configuracion/tema_app.dart';
import '../../widgets_compartidos/animaciones.dart';
import '../autenticacion/inicio_sesion_pantalla.dart';

class SplashPantalla extends StatefulWidget {
  const SplashPantalla({super.key});

  @override
  State<SplashPantalla> createState() => _SplashPantallaState();
}

class _SplashPantallaState extends State<SplashPantalla>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 1400))
    ..forward();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 600),
          pageBuilder: (_, __, ___) => const InicioSesionPantalla(),
          transitionsBuilder: (_, animacion, __, hijo) =>
              FadeTransition(opacity: animacion, child: hijo),
        ),
      );
    });
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final escala = CurvedAnimation(parent: _c, curve: Curves.elasticOut);
    final texto = CurvedAnimation(
        parent: _c, curve: const Interval(0.45, 1, curve: Curves.easeOut));

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [colorTerracota, colorMarron, colorMarronOscuro],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            const Positioned(
                top: -60, right: -50, child: BurbujaDecorativa(tamano: 220)),
            const Positioned(
                bottom: -80,
                left: -60,
                child: BurbujaDecorativa(tamano: 260, opacidad: 0.07)),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ScaleTransition(
                    scale: escala,
                    child: Container(
                      padding: const EdgeInsets.all(26),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.16),
                        border: Border.all(
                            color: Colors.white.withValues(alpha: 0.4),
                            width: 2),
                      ),
                      child:
                          const Text('🏺', style: TextStyle(fontSize: 72)),
                    ),
                  ),
                  const SizedBox(height: 24),
                  FadeTransition(
                    opacity: texto,
                    child: const Column(
                      children: [
                        Text('Don Guerra',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 38,
                                letterSpacing: 1,
                                fontWeight: FontWeight.w900)),
                        SizedBox(height: 6),
                        Text('Cerámica artesanal hecha a mano',
                            style: TextStyle(color: Colors.white70)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 44),
                  SizedBox(
                    width: 140,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0, end: 1),
                        duration: const Duration(milliseconds: 2800),
                        builder: (_, v, __) => LinearProgressIndicator(
                          value: v,
                          minHeight: 6,
                          color: colorOcre,
                          backgroundColor:
                              Colors.white.withValues(alpha: 0.2),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
