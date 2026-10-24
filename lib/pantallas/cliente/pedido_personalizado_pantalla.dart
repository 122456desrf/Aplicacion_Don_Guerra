// FORMULARIO del cliente: pedido personalizado.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../configuracion/tema_app.dart';
import '../../modelos/modelos.dart';
import '../../proveedores/autenticacion_provider.dart';
import '../../proveedores/catalogo_provider.dart';
import '../../proveedores/pedidos_provider.dart';
import '../../utilidades/formato.dart';

/// FORMULARIO DEL DOMINIO (cliente): guarda un pedido personalizado.
class PedidoPersonalizadoPantalla extends StatefulWidget {
  const PedidoPersonalizadoPantalla({super.key});

  @override
  State<PedidoPersonalizadoPantalla> createState() =>
      _PedidoPersonalizadoPantallaState();
}

class _PedidoPersonalizadoPantallaState extends State<PedidoPersonalizadoPantalla> {
  static const _colores = ['Terracota', 'Azul', 'Verde', 'Crema', 'Negro'];

  final _form = GlobalKey<FormState>();
  final _pieza = TextEditingController();
  final _descripcion = TextEditingController();
  String _categoria = 'Tazas';
  String _color = 'Terracota';
  int _cantidad = 1;
  DateTime? _fecha;
  bool _fechaError = false;

  @override
  void dispose() {
    _pieza.dispose();
    _descripcion.dispose();
    super.dispose();
  }

  Future<void> _elegirFecha() async {
    final hoy = DateTime.now();
    final f = await showDatePicker(
      context: context,
      initialDate: hoy.add(const Duration(days: 14)),
      firstDate: hoy.add(const Duration(days: 1)),
      lastDate: hoy.add(const Duration(days: 365)),
    );
    if (f != null) {
      setState(() {
        _fecha = f;
        _fechaError = false;
      });
    }
  }

  void _enviar() {
    final okForm = _form.currentState!.validate();
    if (_fecha == null) setState(() => _fechaError = true);
    if (!okForm || _fecha == null) return;

    final usuario = context.read<AutenticacionProvider>().actual!;
    final pedido = context.read<PedidosProvider>().crear(
          cliente: usuario,
          producto: '${_pieza.text.trim()} ($_categoria)',
          cantidad: _cantidad,
          total: 0, // el artesano cotiza después
          colorDiseno: _color,
          personalizacion: _descripcion.text.trim(),
          fechaDeseada: _fecha,
        );
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Pedido ${pedido.codigo} enviado. El artesano lo cotizará.')));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final categorias =
        CatalogoProvider.categorias.where((c) => c != 'Personalizados').toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Pedido personalizado')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _pieza,
                decoration: const InputDecoration(
                    labelText: 'Nombre de la pieza',
                    hintText: 'Ej. Taza de café'),
                validator: (v) => (v == null || v.trim().length < 3)
                    ? 'Escribe el nombre de la pieza'
                    : null,
              ),
              const SizedBox(height: 14),
              DropdownButtonFormField<String>(
                initialValue: _categoria,
                decoration: const InputDecoration(
                    labelText: 'Tipo de pieza'),
                items: [
                  for (final c in categorias)
                    DropdownMenuItem(value: c, child: Text(c)),
                ],
                onChanged: (v) => setState(() => _categoria = v ?? _categoria),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  const Text('Cantidad:',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  IconButton(
                    onPressed:
                        _cantidad > 1 ? () => setState(() => _cantidad--) : null,
                    icon: const Icon(Icons.remove_circle_outline),
                  ),
                  Text('$_cantidad', style: const TextStyle(fontSize: 18)),
                  IconButton(
                    onPressed: _cantidad < 50
                        ? () => setState(() => _cantidad++)
                        : null,
                    icon: const Icon(Icons.add_circle_outline),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text('Color del diseño',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              Wrap(
                spacing: 8,
                children: [
                  for (final c in _colores)
                    ChoiceChip(
                      label: Text(c),
                      selected: _color == c,
                      onSelected: (_) => setState(() => _color = c),
                    ),
                ],
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _descripcion,
                maxLines: 4,
                maxLength: 200,
                decoration: const InputDecoration(
                    labelText: 'Descripción de la personalización',
                    hintText: 'Grabados, iniciales, acabado...',
                    alignLabelWithHint: true),
                validator: (v) => (v == null || v.trim().length < 10)
                    ? 'Describe tu idea (mínimo 10 caracteres)'
                    : null,
              ),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: _elegirFecha,
                icon: const Icon(Icons.calendar_today),
                label: Text(_fecha == null
                    ? 'Fecha de entrega deseada'
                    : 'Entrega deseada: ${fechaCorta(_fecha!)}'),
              ),
              if (_fechaError)
                const Padding(
                  padding: EdgeInsets.only(top: 6, left: 12),
                  child: Text('Elige una fecha de entrega',
                      style: TextStyle(color: Colors.red, fontSize: 12)),
                ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: _enviar,
                style: FilledButton.styleFrom(
                    backgroundColor: colorTerracota,
                    padding: const EdgeInsets.symmetric(vertical: 14)),
                child: const Text('Enviar pedido'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
