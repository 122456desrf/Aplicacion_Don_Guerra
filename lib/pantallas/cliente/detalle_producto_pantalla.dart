// Detalle de un producto y botón para solicitar pedido.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../configuracion/tema_app.dart';
import '../../proveedores/autenticacion_provider.dart';
import '../../proveedores/catalogo_provider.dart';
import '../../proveedores/pedidos_provider.dart';
import '../../utilidades/formato.dart';
import '../../widgets_compartidos/animaciones.dart';
import '../../widgets_compartidos/estado_vacio.dart';

class DetalleProductoPantalla extends StatefulWidget {
  final int productoId;
  final String? heroTag;
  const DetalleProductoPantalla(
      {super.key, required this.productoId, this.heroTag});

  @override
  State<DetalleProductoPantalla> createState() => _DetalleProductoPantallaState();
}

class _DetalleProductoPantallaState extends State<DetalleProductoPantalla> {
  int _cantidad = 1;

  Widget _etiqueta(String texto, Color color, {IconData? icono}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.13),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icono != null) ...[
            Icon(icono, size: 14, color: color),
            const SizedBox(width: 5),
          ],
          Text(texto,
              style: TextStyle(
                  fontSize: 12.5, fontWeight: FontWeight.w800, color: color)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final catalogo = context.watch<CatalogoProvider>();
    final matches = catalogo.productos.where((x) => x.id == widget.productoId);
    if (matches.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Detalle del producto')),
        body: const EstadoVacio(
            icono: Icons.search_off,
            titulo: 'Producto no disponible',
            mensaje: 'Esta pieza ya no está en el catálogo.'),
      );
    }
    final p = matches.first;
    if (_cantidad > p.stock && p.stock > 0) _cantidad = p.stock;
    final color = colorDeCategoria(p.categoria);

    final emoji = Text(p.emoji, style: const TextStyle(fontSize: 100));

    return Scaffold(
      appBar: AppBar(title: const Text('Detalle del producto')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color.withValues(alpha: 0.38), color.withValues(alpha: 0.1)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(26),
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                    right: -30,
                    top: -40,
                    child: Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.35)),
                    )),
                widget.heroTag == null
                    ? emoji
                    : Hero(
                        tag: widget.heroTag!,
                        child: Material(
                            type: MaterialType.transparency, child: emoji)),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Aparicion(
            retraso: const Duration(milliseconds: 80),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(p.nombre,
                      style: const TextStyle(
                          fontSize: 23,
                          height: 1.15,
                          fontWeight: FontWeight.w900,
                          color: colorMarronOscuro)),
                ),
                const SizedBox(width: 10),
                Text(dinero(p.precio),
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: colorTerracota)),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Aparicion(
            retraso: const Duration(milliseconds: 140),
            child: Wrap(spacing: 8, runSpacing: 8, children: [
              _etiqueta(p.categoria, color),
              _etiqueta(p.material, colorMarronClaro, icono: Icons.layers),
              _etiqueta(p.disponible ? 'Disponible (${p.stock})' : 'Agotado',
                  p.disponible ? colorHoja : Colors.red,
                  icono: p.disponible
                      ? Icons.check_circle_outline
                      : Icons.block),
            ]),
          ),
          const SizedBox(height: 14),
          Aparicion(
            retraso: const Duration(milliseconds: 200),
            child: Text(p.descripcion,
                style: const TextStyle(
                    height: 1.5, fontSize: 15, color: colorMarron)),
          ),
          const SizedBox(height: 24),
          if (p.disponible)
            Aparicion(
              retraso: const Duration(milliseconds: 260),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: colorMarronOscuro.withValues(alpha: 0.08),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text('Cantidad',
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: colorMarronOscuro)),
                        const Spacer(),
                        IconButton.filledTonal(
                          onPressed: _cantidad > 1
                              ? () => setState(() => _cantidad--)
                              : null,
                          icon: const Icon(Icons.remove),
                        ),
                        SizedBox(
                          width: 44,
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            transitionBuilder: (hijo, anim) => ScaleTransition(
                                scale: anim,
                                child: FadeTransition(
                                    opacity: anim, child: hijo)),
                            child: Text('$_cantidad',
                                key: ValueKey(_cantidad),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w900,
                                    color: colorTerracota)),
                          ),
                        ),
                        IconButton.filledTonal(
                          onPressed: _cantidad < p.stock
                              ? () => setState(() => _cantidad++)
                              : null,
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                    const Divider(height: 28),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total',
                            style: TextStyle(color: colorMarronClaro)),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          child: Text(dinero(p.precio * _cantidad),
                              key: ValueKey(_cantidad),
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  color: colorMarronOscuro)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: () {
                          final usuario =
                              context.read<AutenticacionProvider>().actual!;
                          final pedido = context.read<PedidosProvider>().crear(
                                cliente: usuario,
                                producto: p.nombre,
                                cantidad: _cantidad,
                                total: p.precio * _cantidad,
                              );
                          context
                              .read<CatalogoProvider>()
                              .descontarStock(p.id, _cantidad);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  '✅ Pedido ${pedido.codigo} enviado al artesano')));
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.shopping_bag_outlined),
                        label: const Text('Solicitar pedido'),
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colorOcre.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Row(
                children: [
                  Text('🎨', style: TextStyle(fontSize: 28)),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                        'Esta pieza está agotada. Puedes pedirla a tu medida desde Inicio.',
                        style: TextStyle(
                            color: colorMarron, fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
