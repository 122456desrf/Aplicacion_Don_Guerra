// Modelo de datos: Pedido (simple o personalizado).
import 'estado_pedido.dart';

class Pedido {
  final int id;
  final int idUsuario;
  final String clienteNombre;
  final String producto;
  final int cantidad;
  double total;
  final DateTime fechaPedido;
  final String? colorDiseno;
  final String? personalizacion;
  EstadoPedido estado;
  DateTime? fechaEntrega;
  String? nota;

  Pedido({
    required this.id,
    required this.idUsuario,
    required this.clienteNombre,
    required this.producto,
    required this.cantidad,
    required this.total,
    required this.fechaPedido,
    this.colorDiseno,
    this.personalizacion,
    this.estado = EstadoPedido.solicitado,
    this.fechaEntrega,
    this.nota,
  });

  String get codigo => '#DG-$id';
  bool get esPersonalizado => personalizacion != null;
}
