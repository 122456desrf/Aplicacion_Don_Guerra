// Resumen del taller: conteo de pedidos por estado.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../modelos/modelos.dart';
import '../../proveedores/autenticacion_provider.dart';
import '../../proveedores/pedidos_provider.dart';
import '../../widgets_compartidos/animaciones.dart';
import '../../widgets_compartidos/boton_cerrar_sesion.dart';
import '../../widgets_compartidos/cabecera_degradada.dart';
import '../../widgets_compartidos/etiqueta_estado_pedido.dart';
import '../../widgets_compartidos/tarjeta_estadistica.dart';

class ResumenArtesanoPantalla extends StatelessWidget {
  final VoidCallback onVerPedidos;
  const ResumenArtesanoPantalla({super.key, required this.onVerPedidos});

  @override
  Widget build(BuildContext context) {
    final usuario = context.watch<AutenticacionProvider>().actual!;
    final orders = context.watch<PedidosProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Panel del artesano'),
        actions: const [BotonCerrarSesion()],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Aparicion(
            child: CabeceraDegradada(
              saludo: 'Hola, ${usuario.nombre.split(' ').first}',
              subtitulo: 'Estado del taller',
              emoji: '🏺',
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
              for (final e in EstadoPedido.values)
                Aparicion(
                  retraso: Aparicion.escalon(e.index + 1),
                  child: TarjetaEstadistica(
                    icono: iconoDeEstado(e),
                    valor: '${orders.contar(e)}',
                    etiqueta: e == EstadoPedido.solicitado
                        ? 'Solicitudes nuevas'
                        : e.etiqueta,
                    color: colorDeEstado(e),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 18),
          Aparicion(
            retraso: Aparicion.escalon(5),
            child: FilledButton.icon(
              onPressed: onVerPedidos,
              icon: const Icon(Icons.inventory_2_outlined),
              label: const Text('Gestionar pedidos'),
            ),
          ),
        ],
      ),
    );
  }
}
