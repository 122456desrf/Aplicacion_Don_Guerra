// Estados de un pedido: solicitud → elaboración → terminado → entregado.

enum EstadoPedido { solicitado, enElaboracion, terminado, entregado }

extension EstadoPedidoX on EstadoPedido {
  String get etiqueta => switch (this) {
        EstadoPedido.solicitado => 'Solicitud recibida',
        EstadoPedido.enElaboracion => 'En elaboración',
        EstadoPedido.terminado => 'Terminado',
        EstadoPedido.entregado => 'Entregado',
      };
}
