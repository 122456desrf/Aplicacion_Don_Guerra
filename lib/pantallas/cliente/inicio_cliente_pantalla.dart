// Inicio del cliente: saludo, banner, pedido reciente, categorías y destacados.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../configuracion/tema_app.dart';
import '../../modelos/modelos.dart';
import '../../proveedores/autenticacion_provider.dart';
import '../../proveedores/catalogo_provider.dart';
import '../../proveedores/pedidos_provider.dart';
import '../../utilidades/formato.dart';
import '../../widgets_compartidos/animaciones.dart';
import '../../widgets_compartidos/boton_cerrar_sesion.dart';
import '../../widgets_compartidos/tarjeta_pedido.dart';
import 'catalogo_pantalla.dart';
import 'detalle_producto_pantalla.dart';
import 'pedido_personalizado_pantalla.dart';
import 'seguimiento_pedido_pantalla.dart';

class InicioClientePantalla extends StatelessWidget {
  final VoidCallback onVerPedidos;
  const InicioClientePantalla({super.key, required this.onVerPedidos});

  Widget _titulo(String texto) => Text(texto,
      style: const TextStyle(
          fontSize: 18, fontWeight: FontWeight.w900, color: colorMarronOscuro));

  @override
  Widget build(BuildContext context) {
    final usuario = context.watch<AutenticacionProvider>().actual!;
    final misPedidos = context.watch<PedidosProvider>().pedidosDe(usuario.id);
    final reciente = misPedidos.isEmpty ? null : misPedidos.first;
    final destacados = context
        .watch<CatalogoProvider>()
        .productos
        .where((p) => p.disponible)
        .take(6)
        .toList();
    final nombre = usuario.nombre.split(' ').first;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Don Guerra'),
        actions: const [BotonCerrarSesion()],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
        children: [
          Aparicion(
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: colorOcre,
                  child: Text(
                    nombre.isEmpty ? '?' : nombre[0].toUpperCase(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('¡Hola, $nombre! 👋',
                          style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              color: colorMarronOscuro)),
                      const Text('¿Qué pieza artesanal buscas hoy?',
                          style: TextStyle(color: colorMarronClaro)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Aparicion(
            retraso: const Duration(milliseconds: 100),
            child: Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: degradadoCalido,
                boxShadow: [
                  BoxShadow(
                    color: colorTerracota.withValues(alpha: 0.35),
                    blurRadius: 18,
                    offset: const Offset(0, 9),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  const Positioned(
                      right: -36,
                      top: -44,
                      child: BurbujaDecorativa(tamano: 140)),
                  const Positioned(
                      right: 50,
                      bottom: -50,
                      child:
                          BurbujaDecorativa(tamano: 90, opacidad: 0.07)),
                  const Positioned(
                      right: 6,
                      top: 4,
                      child: Text('🎨', style: TextStyle(fontSize: 54))),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Piezas a tu medida',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 21,
                              fontWeight: FontWeight.w900)),
                      const SizedBox(height: 4),
                      Text('Elige color, grabado y fecha de entrega.',
                          style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.88),
                              fontSize: 13)),
                      const SizedBox(height: 16),
                      FilledButton.icon(
                        onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (_) =>
                                    const PedidoPersonalizadoPantalla())),
                        icon: const Icon(Icons.brush),
                        label: const Text('Pedido personalizado'),
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: colorTerracota,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Aparicion(
              retraso: const Duration(milliseconds: 180),
              child: _titulo('Explorar categorías')),
          const SizedBox(height: 12),
          SizedBox(
            height: 96,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              clipBehavior: Clip.none,
              itemCount: CatalogoProvider.categorias.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (_, i) {
                final c = CatalogoProvider.categorias[i];
                final color = colorDeCategoria(c);
                return Aparicion(
                  retraso: Aparicion.escalon(i),
                  desplazamiento: const Offset(0.2, 0),
                  child: Presionable(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => CatalogoPantalla(categoriaInicial: c))),
                    child: SizedBox(
                      width: 78,
                      child: Column(
                        children: [
                          Container(
                            width: 62,
                            height: 62,
                            decoration: BoxDecoration(
                              color: color.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: color.withValues(alpha: 0.35)),
                            ),
                            alignment: Alignment.center,
                            child: Text(emojiDeCategoria(c),
                                style: const TextStyle(fontSize: 30)),
                          ),
                          const SizedBox(height: 6),
                          Text(c,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: color)),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Aparicion(
              retraso: const Duration(milliseconds: 260),
              child: _titulo('Piezas destacadas')),
          const SizedBox(height: 12),
          SizedBox(
            height: 176,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              clipBehavior: Clip.none,
              itemCount: destacados.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (_, i) => Aparicion(
                retraso: Aparicion.escalon(i),
                desplazamiento: const Offset(0.2, 0),
                child: _TarjetaDestacada(producto: destacados[i]),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Aparicion(
              retraso: const Duration(milliseconds: 320),
              child: _titulo('Tu pedido más reciente')),
          const SizedBox(height: 12),
          if (reciente == null)
            Aparicion(
              retraso: const Duration(milliseconds: 360),
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: colorOcre.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Row(
                  children: [
                    Text('🛍️', style: TextStyle(fontSize: 30)),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text('Aún no tienes pedidos. ¡Explora el catálogo!',
                          style: TextStyle(
                              color: colorMarron,
                              fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),
            )
          else ...[
            TarjetaPedido(
              pedido: reciente,
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) =>
                      SeguimientoPedidoPantalla(pedidoId: reciente.id))),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: onVerPedidos,
                icon: const Icon(Icons.arrow_forward, size: 18),
                label: const Text('Ver todos mis pedidos'),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _TarjetaDestacada extends StatelessWidget {
  final Producto producto;
  const _TarjetaDestacada({required this.producto});

  @override
  Widget build(BuildContext context) {
    final color = colorDeCategoria(producto.categoria);
    final tag = 'destacado-${producto.id}';
    return Presionable(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => DetalleProductoPantalla(
              productoId: producto.id, heroTag: tag))),
      child: Container(
        width: 138,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: colorMarronOscuro.withValues(alpha: 0.08),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 68,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    color.withValues(alpha: 0.28),
                    color.withValues(alpha: 0.1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              alignment: Alignment.center,
              child: Hero(
                tag: tag,
                child: Material(
                  type: MaterialType.transparency,
                  child: Text(producto.emoji,
                      style: const TextStyle(fontSize: 38)),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(producto.nombre,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 12.5,
                    height: 1.2,
                    fontWeight: FontWeight.w800,
                    color: colorMarronOscuro)),
            const Spacer(),
            Text(dinero(producto.precio),
                style: const TextStyle(
                    fontWeight: FontWeight.w900, color: colorTerracota)),
          ],
        ),
      ),
    );
  }
}
