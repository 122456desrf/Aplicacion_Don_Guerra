// FORMULARIO del artesano: actualizar estado, precio, entrega y nota.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../configuracion/tema_app.dart';
import '../../modelos/modelos.dart';
import '../../proveedores/pedidos_provider.dart';
import '../../utilidades/formato.dart';
import '../../widgets_compartidos/estado_vacio.dart';

/// FORMULARIO DEL DOMINIO (artesano): actualiza estado, cotización y entrega.
class ActualizarPedidoPantalla extends StatefulWidget {
  final int pedidoId;
  const ActualizarPedidoPantalla({super.key, required this.pedidoId});

  @override
  State<ActualizarPedidoPantalla> createState() => _ActualizarPedidoPantallaState();
}

class _ActualizarPedidoPantallaState extends State<ActualizarPedidoPantalla> {
  final _form = GlobalKey<FormState>();
  late final TextEditingController _nota;
  late final TextEditingController _precio;
  late EstadoPedido _estado;
  DateTime? _entrega;

  @override
  void initState() {
    super.initState();
    final p = context.read<PedidosProvider>().porId(widget.pedidoId)!;
    _estado = p.estado;
    _entrega = p.fechaEntrega;
    _nota = TextEditingController(text: p.nota ?? '');
    _precio = TextEditingController(
        text: p.total == 0 ? '' : p.total.toStringAsFixed(0));
  }

  @override
  void dispose() {
    _nota.dispose();
    _precio.dispose();
    super.dispose();
  }

  Future<void> _elegirFecha() async {
    final hoy = DateTime.now();
    final f = await showDatePicker(
      context: context,
      initialDate: _entrega ?? hoy.add(const Duration(days: 7)),
      firstDate: hoy.subtract(const Duration(days: 30)),
      lastDate: hoy.add(const Duration(days: 365)),
    );
    if (f != null) setState(() => _entrega = f);
  }

  void _guardar() {
    if (!_form.currentState!.validate()) return;
    context.read<PedidosProvider>().actualizar(
          widget.pedidoId,
          estado: _estado,
          fechaEntrega: _entrega,
          nota: _nota.text,
          total: double.tryParse(_precio.text.trim()),
        );
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Pedido actualizado')));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final p = context.watch<PedidosProvider>().porId(widget.pedidoId);
    if (p == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Pedido')),
        body: const EstadoVacio(
            icono: Icons.search_off,
            titulo: 'Pedido no encontrado',
            mensaje: 'Este pedido ya no existe.'),
      );
    }
    return Scaffold(
      appBar: AppBar(title: Text('Pedido ${p.codigo}')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(p.producto,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: colorMarronOscuro)),
                  const SizedBox(height: 4),
                  Text('Cliente: ${p.clienteNombre}'),
                  Text('Cantidad: ${p.cantidad} pza · ${totalTexto(p)}'),
                  Text('Pedido el ${fechaCorta(p.fechaPedido)}'),
                  if (p.colorDiseno != null) Text('Color: ${p.colorDiseno}'),
                  if (p.personalizacion != null)
                    Text('Personalización: ${p.personalizacion}'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text('Actualizar pedido',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: colorMarronOscuro)),
          const SizedBox(height: 10),
          Form(
            key: _form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DropdownButtonFormField<EstadoPedido>(
                  initialValue: _estado,
                  decoration: const InputDecoration(
                      labelText: 'Estado'),
                  items: [
                    for (final e in EstadoPedido.values)
                      DropdownMenuItem(value: e, child: Text(e.etiqueta)),
                  ],
                  onChanged: (v) => setState(() => _estado = v ?? _estado),
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _precio,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: 'Precio total (MXN)',
                      helperText: 'Déjalo vacío si aún no lo cotizas'),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return null;
                    final n = double.tryParse(v.trim());
                    if (n == null || n < 0) return 'Ingresa un número válido';
                    return null;
                  },
                ),
                const SizedBox(height: 14),
                OutlinedButton.icon(
                  onPressed: _elegirFecha,
                  icon: const Icon(Icons.calendar_today),
                  label: Text(_entrega == null
                      ? 'Fecha estimada de entrega'
                      : 'Entrega estimada: ${fechaCorta(_entrega!)}'),
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _nota,
                  maxLines: 3,
                  maxLength: 200,
                  decoration: const InputDecoration(
                      labelText: 'Nota para el cliente (opcional)',
                      alignLabelWithHint: true),
                ),
                const SizedBox(height: 10),
                FilledButton(
                  onPressed: _guardar,
                  style: FilledButton.styleFrom(
                      backgroundColor: colorTerracota,
                      padding: const EdgeInsets.symmetric(vertical: 14)),
                  child: const Text('Guardar cambios'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
