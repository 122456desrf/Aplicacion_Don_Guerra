// Dashboard del artesano con barra inferior (Resumen, Pedidos).
import 'package:flutter/material.dart';
import 'lista_pedidos_artesano_pantalla.dart';
import 'resumen_artesano_pantalla.dart';

/// Dashboard del ARTESANO.
class DashboardArtesanoPantalla extends StatefulWidget {
  const DashboardArtesanoPantalla({super.key});

  @override
  State<DashboardArtesanoPantalla> createState() => _DashboardArtesanoPantallaState();
}

class _DashboardArtesanoPantallaState extends State<DashboardArtesanoPantalla> {
  int _i = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _i,
        children: [
          ResumenArtesanoPantalla(onVerPedidos: () => setState(() => _i = 1)),
          const ListaPedidosArtesanoPantalla(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _i,
        onDestinationSelected: (v) => setState(() => _i = v),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.dashboard_outlined), selectedIcon: Icon(Icons.dashboard), label: 'Resumen'),
          NavigationDestination(icon: Icon(Icons.inventory_2_outlined), selectedIcon: Icon(Icons.inventory_2), label: 'Pedidos'),
        ],
      ),
    );
  }
}
