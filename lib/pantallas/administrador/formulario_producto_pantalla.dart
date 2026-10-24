// FORMULARIO del administrador: alta y edición de producto.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../configuracion/tema_app.dart';
import '../../modelos/modelos.dart';
import '../../proveedores/catalogo_provider.dart';

/// FORMULARIO DEL DOMINIO (admin): alta y edición de productos.
class FormularioProductoPantalla extends StatefulWidget {
  final Producto? producto;
  const FormularioProductoPantalla({super.key, this.producto});

  @override
  State<FormularioProductoPantalla> createState() => _FormularioProductoPantallaState();
}

class _FormularioProductoPantallaState extends State<FormularioProductoPantalla> {
  static const _emojis = ['🏺', '🪴', '☕', '🖼️', '🗿', '🦉', '🫖'];
  static const _materiales = ['Barro', 'Cerámica artesanal', 'Gres', 'Porcelana'];

  final _form = GlobalKey<FormState>();
  late final TextEditingController _nombre;
  late final TextEditingController _descripcion;
  late final TextEditingController _precio;
  late final TextEditingController _stock;
  late String _categoria;
  late String _material;
  late String _emoji;

  bool get _editando => widget.producto != null;

  @override
  void initState() {
    super.initState();
    final p = widget.producto;
    _nombre = TextEditingController(text: p?.nombre ?? '');
    _descripcion = TextEditingController(text: p?.descripcion ?? '');
    _precio = TextEditingController(text: p == null ? '' : p.precio.toStringAsFixed(0));
    _stock = TextEditingController(text: p == null ? '' : '${p.stock}');
    _categoria = p?.categoria ?? CatalogoProvider.categorias.first;
    _material = p?.material ?? _materiales.first;
    _emoji = p?.emoji ?? _emojis.first;
  }

  @override
  void dispose() {
    _nombre.dispose();
    _descripcion.dispose();
    _precio.dispose();
    _stock.dispose();
    super.dispose();
  }

  void _guardar() {
    if (!_form.currentState!.validate()) return;
    final catalogo = context.read<CatalogoProvider>();
    final precio = double.parse(_precio.text.trim());
    final stock = int.parse(_stock.text.trim());

    if (_editando) {
      catalogo.actualizar(widget.producto!.copyWith(
        nombre: _nombre.text.trim(),
        categoria: _categoria,
        descripcion: _descripcion.text.trim(),
        precio: precio,
        material: _material,
        stock: stock,
        emoji: _emoji,
      ));
    } else {
      catalogo.agregar(
        nombre: _nombre.text.trim(),
        categoria: _categoria,
        descripcion: _descripcion.text.trim(),
        precio: precio,
        material: _material,
        stock: stock,
        emoji: _emoji,
      );
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(_editando ? 'Producto actualizado' : 'Producto agregado')));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_editando ? 'Editar producto' : 'Nuevo producto')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nombre,
                decoration: const InputDecoration(
                    labelText: 'Nombre del producto'),
                validator: (v) => (v == null || v.trim().length < 3)
                    ? 'Ingresa un nombre (mínimo 3 letras)'
                    : null,
              ),
              const SizedBox(height: 14),
              DropdownButtonFormField<String>(
                initialValue: _categoria,
                decoration: const InputDecoration(
                    labelText: 'Categoría'),
                items: [
                  for (final c in CatalogoProvider.categorias)
                    DropdownMenuItem(value: c, child: Text(c)),
                ],
                onChanged: (v) => setState(() => _categoria = v ?? _categoria),
              ),
              const SizedBox(height: 14),
              DropdownButtonFormField<String>(
                initialValue: _material,
                decoration: const InputDecoration(
                    labelText: 'Material'),
                items: [
                  for (final m in _materiales)
                    DropdownMenuItem(value: m, child: Text(m)),
                ],
                onChanged: (v) => setState(() => _material = v ?? _material),
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _descripcion,
                maxLines: 3,
                decoration: const InputDecoration(
                    labelText: 'Descripción',
                    alignLabelWithHint: true),
                validator: (v) => (v == null || v.trim().length < 10)
                    ? 'Describe la pieza (mínimo 10 caracteres)'
                    : null,
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _precio,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          labelText: 'Precio (MXN)'),
                      validator: (v) {
                        final n = double.tryParse((v ?? '').trim());
                        if (n == null || n <= 0) return 'Precio mayor a 0';
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _stock,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          labelText: 'Stock'),
                      validator: (v) {
                        final n = int.tryParse((v ?? '').trim());
                        if (n == null || n < 0) return 'Número entero ≥ 0';
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text('Ícono',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: colorMarronOscuro)),
              const SizedBox(height: 6),
              Wrap(
                spacing: 8,
                children: [
                  for (final e in _emojis)
                    ChoiceChip(
                      label: Text(e, style: const TextStyle(fontSize: 22)),
                      selected: _emoji == e,
                      onSelected: (_) => setState(() => _emoji = e),
                    ),
                ],
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: _guardar,
                style: FilledButton.styleFrom(
                    backgroundColor: colorTerracota,
                    padding: const EdgeInsets.symmetric(vertical: 14)),
                child: Text(_editando ? 'Guardar cambios' : 'Agregar producto'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
