// Estado de pedidos: crear, consultar y actualizar su avance.
import 'package:flutter/foundation.dart';
import '../modelos/modelos.dart';

/// Maneja los pedidos (simples y personalizados) en memoria.
class PedidosProvider extends ChangeNotifier {
  int _siguienteId = 7893;

  final List<Pedido> _pedidos = [
    Pedido(
      id: 7890,
      idUsuario: 3,
      clienteNombre: 'Sofía Rodríguez',
      producto: 'Juego de tazas',
      cantidad: 2,
      total: 1800,
      fechaPedido: DateTime(2026, 10, 12),
      colorDiseno: 'Azul',
      personalizacion: 'Tazas con las iniciales "C. & L." grabadas en la base.',
      estado: EstadoPedido.enElaboracion,
      fechaEntrega: DateTime(2026, 11, 12),
    ),
    Pedido(
      id: 7891,
      idUsuario: 3,
      clienteNombre: 'Sofía Rodríguez',
      producto: 'Jarrón azul y blanco',
      cantidad: 1,
      total: 2500,
      fechaPedido: DateTime(2026, 9, 28),
      estado: EstadoPedido.entregado,
      fechaEntrega: DateTime(2026, 10, 8),
    ),
    Pedido(
      id: 7892,
      idUsuario: 99,
      clienteNombre: 'Carlos Martínez',
      producto: 'Macetas personalizadas',
      cantidad: 4,
      total: 2500,
      fechaPedido: DateTime(2026, 10, 18),
      colorDiseno: 'Terracota',
      personalizacion: 'Grabado de iniciales y acabado brillante.',
    ),
  ];

  /// Más recientes primero.
  List<Pedido> get todos {
    final l = List<Pedido>.from(_pedidos);
    l.sort((a, b) => b.fechaPedido.compareTo(a.fechaPedido));
    return l;
  }

  List<Pedido> pedidosDe(int idUsuario) =>
      todos.where((p) => p.idUsuario == idUsuario).toList();

  Pedido? porId(int id) {
    for (final p in _pedidos) {
      if (p.id == id) return p;
    }
    return null;
  }

  int contar(EstadoPedido e) => _pedidos.where((p) => p.estado == e).length;

  double get ventasTotales => _pedidos.fold<double>(0, (s, p) => s + p.total);

  Pedido crear({
    required Usuario cliente,
    required String producto,
    required int cantidad,
    required double total,
    String? colorDiseno,
    String? personalizacion,
    DateTime? fechaDeseada,
  }) {
    final p = Pedido(
      id: _siguienteId++,
      idUsuario: cliente.id,
      clienteNombre: cliente.nombre,
      producto: producto,
      cantidad: cantidad,
      total: total,
      fechaPedido: DateTime.now(),
      colorDiseno: colorDiseno,
      personalizacion: personalizacion,
      fechaEntrega: fechaDeseada,
    );
    _pedidos.add(p);
    notifyListeners();
    return p;
  }

  void actualizar(int id,
      {required EstadoPedido estado,
      DateTime? fechaEntrega,
      String? nota,
      double? total}) {
    final p = porId(id);
    if (p == null) return;
    p.estado = estado;
    p.fechaEntrega = fechaEntrega;
    if (total != null) p.total = total;
    p.nota = (nota == null || nota.trim().isEmpty) ? null : nota.trim();
    notifyListeners();
  }
}
