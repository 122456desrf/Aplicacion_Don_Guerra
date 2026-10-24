// Resumen del negocio: productos, usuarios, pedidos y ventas.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../configuracion/tema_app.dart';
import '../../proveedores/autenticacion_provider.dart';
import '../../proveedores/catalogo_provider.dart';
import '../../proveedores/pedidos_provider.dart';
import '../../utilidades/formato.dart';
import '../../widgets_compartidos/animaciones.dart';
import '../../widgets_compartidos/boton_cerrar_sesion.dart';
import '../../widgets_compartidos/cabecera_degradada.dart';
import '../../widgets_compartidos/tarjeta_estadistica.dart';

class ResumenAdminPantalla extends StatelessWidget {
  const ResumenAdminPantalla({super.key});

  @override
  Widget build(BuildContext context) {
    final usuario = context.watch<AutenticacionProvider>().actual!;
    final usuarios = context.watch<AutenticacionProvider>().usuarios;
    final productos = context.watch<CatalogoProvider>().productos;
    final orders = context.watch<PedidosProvider>();
    final agotados = productos.where((p) => !p.disponible).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Panel de administración'),
        actions: const [BotonCerrarSesion()],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Aparicion(
            child: CabeceraDegradada(
              saludo: 'Hola, ${usuario.nombre.split(' ').first}',
              subtitulo: 'Resumen del negocio',
              emoji: '📊',
              gradiente: degradadoTierra,
            ),
          ),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.3,
            children: [
              Aparicion(
                retraso: Aparicion.escalon(1),
                child: TarjetaEstadistica(
                    icono: Icons.storefront,
                    valor: '${productos.length}',
                    etiqueta: 'Productos',
                    color: colorTalavera),
              ),
              Aparicion(
                retraso: Aparicion.escalon(2),
                child: TarjetaEstadistica(
                    icono: Icons.warning_amber_outlined,
                    valor: '$agotados',
                    etiqueta: 'Agotados',
                    color: colorRosaMexicano),
              ),
              Aparicion(
                retraso: Aparicion.escalon(3),
                child: TarjetaEstadistica(
                    icono: Icons.people_outline,
                    valor: '${usuarios.length}',
                    etiqueta: 'Usuarios',
                    color: colorTurquesa),
              ),
              Aparicion(
                retraso: Aparicion.escalon(4),
                child: TarjetaEstadistica(
                    icono: Icons.inventory_2_outlined,
                    valor: '${orders.todos.length}',
                    etiqueta: 'Pedidos',
                    color: colorOcre),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 104,
            child: Aparicion(
              retraso: Aparicion.escalon(5),
              child: TarjetaEstadistica(
                  icono: Icons.attach_money,
                  valor: dinero(orders.ventasTotales),
                  etiqueta: 'Ventas registradas',
                  color: colorHoja),
            ),
          ),
        ],
      ),
    );
  }
}
