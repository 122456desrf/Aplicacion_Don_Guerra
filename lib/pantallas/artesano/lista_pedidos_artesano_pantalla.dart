// LISTA de pedidos entrantes con filtro por estado.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../modelos/modelos.dart';
import '../../proveedores/pedidos_provider.dart';
import '../../configuracion/tema_app.dart';
import '../../widgets_compartidos/animaciones.dart';
import '../../widgets_compartidos/boton_cerrar_sesion.dart';
import '../../widgets_compartidos/etiqueta_estado_pedido.dart';
import '../../widgets_compartidos/estado_vacio.dart';
import '../../widgets_compartidos/tarjeta_pedido.dart';
import 'actualizar_pedido_pantalla.dart';

/// LISTA de pedidos entrantes (con filtro por estado y estado vacío).
class ListaPedidosArtesanoPantalla extends StatefulWidget {
  const ListaPedidosArtesanoPantalla({super.key});

  @override
  State<ListaPedidosArtesanoPantalla> createState() => _ListaPedidosArtesanoPantallaState();
}

class _ListaPedidosArtesanoPantallaState extends State<ListaPedidosArtesanoPantalla> {
  EstadoPedido? _filtro;

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<PedidosProvider>().todos;
    final lista =
        _filtro == null ? todos : todos.where((p) => p.estado == _filtro).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos'),
        actions: const [BotonCerrarSesion()],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 52,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                  child: ChoiceChip(
                    label: const Text('Todos'),
                    selected: _filtro == null,
                    showCheckmark: false,
                    selectedColor: colorTerracota.withValues(alpha: 0.2),
                    onSelected: (_) => setState(() => _filtro = null),
                  ),
                ),
                for (final e in EstadoPedido.values)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                    child: ChoiceChip(
                      avatar: Icon(iconoDeEstado(e),
                          size: 16, color: colorDeEstado(e)),
                      label: Text(e.etiqueta),
                      selected: _filtro == e,
                      showCheckmark: false,
                      selectedColor: colorDeEstado(e).withValues(alpha: 0.2),
                      onSelected: (_) => setState(() => _filtro = e),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: lista.isEmpty
                ? const EstadoVacio(
                    icono: Icons.inbox_outlined,
                    titulo: 'No hay elementos',
                    mensaje: 'No hay pedidos con este estado.',
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: lista.length,
                    itemBuilder: (_, i) => Aparicion(
                      retraso: Aparicion.escalon(i),
                      child: TarjetaPedido(
                        pedido: lista[i],
                        mostrarCliente: true,
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (_) => ActualizarPedidoPantalla(
                                    pedidoId: lista[i].id))),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
