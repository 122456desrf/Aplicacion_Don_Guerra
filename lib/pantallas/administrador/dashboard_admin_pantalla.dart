// Dashboard del administrador (Resumen, Productos, Usuarios).
import 'package:flutter/material.dart';
import 'lista_productos_admin_pantalla.dart';
import 'lista_usuarios_admin_pantalla.dart';
import 'resumen_admin_pantalla.dart';

/// Dashboard del ADMINISTRADOR.
class DashboardAdminPantalla extends StatefulWidget {
  const DashboardAdminPantalla({super.key});

  @override
  State<DashboardAdminPantalla> createState() => _DashboardAdminPantallaState();
}

class _DashboardAdminPantallaState extends State<DashboardAdminPantalla> {
  int _i = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _i,
        children: const [
          ResumenAdminPantalla(),
          ListaProductosAdminPantalla(),
          ListaUsuariosAdminPantalla(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _i,
        onDestinationSelected: (v) => setState(() => _i = v),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.dashboard_outlined), selectedIcon: Icon(Icons.dashboard), label: 'Resumen'),
          NavigationDestination(icon: Icon(Icons.storefront_outlined), selectedIcon: Icon(Icons.storefront), label: 'Productos'),
          NavigationDestination(icon: Icon(Icons.people_outline), selectedIcon: Icon(Icons.people), label: 'Usuarios'),
        ],
      ),
    );
  }
}
