// Punto de entrada: registra los 3 providers y abre el splash.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'configuracion/tema_app.dart';
import 'pantallas/inicio/splash_pantalla.dart';
import 'proveedores/autenticacion_provider.dart';
import 'proveedores/catalogo_provider.dart';
import 'proveedores/pedidos_provider.dart';

void main() {
  runApp(const DonGuerraApp());
}

class DonGuerraApp extends StatelessWidget {
  const DonGuerraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AutenticacionProvider()),
        ChangeNotifierProvider(create: (_) => CatalogoProvider()),
        ChangeNotifierProvider(create: (_) => PedidosProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Don Guerra',
        theme: construirTema(),
        home: const SplashPantalla(),
      ),
    );
  }
}
