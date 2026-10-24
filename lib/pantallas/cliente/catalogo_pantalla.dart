// LISTA PRINCIPAL: catálogo con búsqueda y filtro por categoría.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../configuracion/tema_app.dart';
import '../../modelos/modelos.dart';
import '../../proveedores/catalogo_provider.dart';
import '../../utilidades/formato.dart';
import '../../widgets_compartidos/animaciones.dart';
import '../../widgets_compartidos/estado_vacio.dart';
import 'detalle_producto_pantalla.dart';

/// LISTA PRINCIPAL (datos dinámicos) con búsqueda, filtro y estado vacío.
class CatalogoPantalla extends StatefulWidget {
  final String categoriaInicial;
  const CatalogoPantalla({super.key, this.categoriaInicial = 'Todos'});

  @override
  State<CatalogoPantalla> createState() => _CatalogoPantallaState();
}

class _CatalogoPantallaState extends State<CatalogoPantalla> {
  late String _categoria = widget.categoriaInicial;
  String _busqueda = '';

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<CatalogoProvider>().productos;
    final lista = todos.where((p) {
      final okCat = _categoria == 'Todos' || p.categoria == _categoria;
      final okBus =
          p.nombre.toLowerCase().contains(_busqueda.trim().toLowerCase());
      return okCat && okBus;
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Catálogo')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: TextField(
              onChanged: (v) => setState(() => _busqueda = v),
              decoration: const InputDecoration(
                hintText: 'Buscar pieza...',
                prefixIcon: Icon(Icons.search),
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
          ),
          SizedBox(
            height: 54,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                for (final c in ['Todos', ...CatalogoProvider.categorias])
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                    child: _ChipCategoria(
                      categoria: c,
                      seleccionada: _categoria == c,
                      onTap: () => setState(() => _categoria = c),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: lista.isEmpty
                  ? const EstadoVacio(
                      key: ValueKey('vacio'),
                      icono: Icons.search_off,
                      titulo: 'No hay elementos',
                      mensaje: 'No encontramos piezas con ese filtro.',
                    )
                  : ListView.builder(
                      key: ValueKey(_categoria),
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                      itemCount: lista.length,
                      itemBuilder: (_, i) => Aparicion(
                        retraso: Aparicion.escalon(i),
                        child: _TarjetaProducto(producto: lista[i]),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChipCategoria extends StatelessWidget {
  final String categoria;
  final bool seleccionada;
  final VoidCallback onTap;
  const _ChipCategoria(
      {required this.categoria,
      required this.seleccionada,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    final color =
        categoria == 'Todos' ? colorTerracota : colorDeCategoria(categoria);
    final emoji = categoria == 'Todos' ? '🧺' : emojiDeCategoria(categoria);
    return Presionable(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: seleccionada ? color : Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: color.withValues(alpha: 0.5)),
          boxShadow: seleccionada
              ? [
                  BoxShadow(
                    color: color.withValues(alpha: 0.35),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 15)),
            const SizedBox(width: 6),
            Text(categoria,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: seleccionada ? Colors.white : color)),
          ],
        ),
      ),
    );
  }
}

class _TarjetaProducto extends StatelessWidget {
  final Producto producto;
  const _TarjetaProducto({required this.producto});

  @override
  Widget build(BuildContext context) {
    final color = colorDeCategoria(producto.categoria);
    final tag = 'catalogo-${producto.id}';
    return Presionable(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => DetalleProductoPantalla(
              productoId: producto.id, heroTag: tag))),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: colorMarronOscuro.withValues(alpha: 0.07),
              blurRadius: 14,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    color.withValues(alpha: 0.28),
                    color.withValues(alpha: 0.1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              alignment: Alignment.center,
              child: Hero(
                tag: tag,
                child: Material(
                  type: MaterialType.transparency,
                  child: Text(producto.emoji,
                      style: const TextStyle(fontSize: 36)),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(producto.nombre,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                          color: colorMarronOscuro)),
                  const SizedBox(height: 4),
                  Text('${producto.categoria} · ${producto.material}',
                      style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                          color: color)),
                  const SizedBox(height: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: (producto.disponible ? colorHoja : Colors.red)
                          .withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      producto.disponible
                          ? 'Disponible (${producto.stock})'
                          : 'Agotado',
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color:
                              producto.disponible ? colorHoja : Colors.red),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(dinero(producto.precio),
                    style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 14,
                        color: colorTerracota)),
                const SizedBox(height: 10),
                const Icon(Icons.chevron_right, color: colorMarronClaro),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
