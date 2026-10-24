// Dashboard del cliente con barra inferior (Inicio, Catálogo, Pedidos, Perfil).
import 'package:flutter/material.dart';
import 'catalogo_pantalla.dart';
import 'inicio_cliente_pantalla.dart';
import 'mis_pedidos_pantalla.dart';
import 'perfil_cliente_pantalla.dart';

/// Dashboard del CLIENTE.
class DashboardClientePantalla extends StatefulWidget {
  const DashboardClientePantalla({super.key});

  @override
  State<DashboardClientePantalla> createState() => _DashboardClientePantallaState();
}

class _DashboardClientePantallaState extends State<DashboardClientePantalla> {
  int _i = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _i,
        children: [
          InicioClientePantalla(onVerPedidos: () => setState(() => _i = 2)),
          const CatalogoPantalla(),
          const MisPedidosPantalla(),
          const PerfilClientePantalla(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _i,
        onDestinationSelected: (v) => setState(() => _i = v),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Inicio'),
          NavigationDestination(icon: Icon(Icons.menu_book_outlined), selectedIcon: Icon(Icons.menu_book), label: 'Catálogo'),
          NavigationDestination(icon: Icon(Icons.local_shipping_outlined), selectedIcon: Icon(Icons.local_shipping), label: 'Pedidos'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}
