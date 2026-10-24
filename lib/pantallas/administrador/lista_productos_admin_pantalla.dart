// LISTA de productos con alta, edición y baja.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../configuracion/tema_app.dart';
import '../../modelos/modelos.dart';
import '../../proveedores/catalogo_provider.dart';
import '../../utilidades/formato.dart';
import '../../widgets_compartidos/animaciones.dart';
import '../../widgets_compartidos/boton_cerrar_sesion.dart';
import '../../widgets_compartidos/estado_vacio.dart';
import 'formulario_producto_pantalla.dart';

/// LISTA de productos con alta, edición y baja (CRUD) y estado vacío.
class ListaProductosAdminPantalla extends StatelessWidget {
  const ListaProductosAdminPantalla({super.key});

  Future<void> _confirmarEliminar(BuildContext context, Producto p) async {
    final catalogo = context.read<CatalogoProvider>();
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Eliminar producto'),
        content: Text('¿Eliminar "${p.nombre}" del catálogo?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: const Text('Cancelar')),
          FilledButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: const Text('Eliminar')),
        ],
      ),
    );
    if (ok == true) catalogo.eliminar(p.id);
  }

  @override
  Widget build(BuildContext context) {
    final productos = context.watch<CatalogoProvider>().productos;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Administrar productos'),
        actions: const [BotonCerrarSesion()],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: colorTerracota,
        foregroundColor: Colors.white,
        onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const FormularioProductoPantalla())),
        icon: const Icon(Icons.add),
        label: const Text('Nuevo producto',
            style: TextStyle(fontWeight: FontWeight.w800)),
      ),
      body: productos.isEmpty
          ? const EstadoVacio(
              icono: Icons.storefront_outlined,
              titulo: 'No hay elementos',
              mensaje: 'Agrega tu primer producto con el botón +.')
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 88),
              itemCount: productos.length,
              itemBuilder: (_, i) {
                final p = productos[i];
                final color = colorDeCategoria(p.categoria);
                return Aparicion(
                  retraso: Aparicion.escalon(i),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.fromLTRB(12, 12, 4, 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
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
                          width: 58,
                          height: 58,
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.16),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          alignment: Alignment.center,
                          child: Text(p.emoji,
                              style: const TextStyle(fontSize: 30)),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(p.nombre,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: colorMarronOscuro)),
                              const SizedBox(height: 2),
                              Text('${p.categoria} · ${dinero(p.precio)}',
                                  style: TextStyle(
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.w600,
                                      color: color)),
                              const SizedBox(height: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: (p.disponible ? colorHoja : Colors.red)
                                      .withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                    p.disponible ? 'Stock: ${p.stock}' : 'Agotado',
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w800,
                                        color: p.disponible
                                            ? colorHoja
                                            : Colors.red)),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit_outlined,
                              color: colorTalavera),
                          onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) =>
                                      FormularioProductoPantalla(producto: p))),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline,
                              color: colorRosaMexicano),
                          onPressed: () => _confirmarEliminar(context, p),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
