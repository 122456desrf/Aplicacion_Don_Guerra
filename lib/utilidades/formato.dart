// Funciones para dar formato a dinero, fechas y totales.
import '../modelos/modelos.dart';

String dinero(double v) => '\$${v.toStringAsFixed(0)} MXN';

String totalTexto(Pedido p) => p.total == 0 ? 'Por cotizar' : dinero(p.total);

String fechaCorta(DateTime d) {
  const meses = [
    'ene', 'feb', 'mar', 'abr', 'may', 'jun',
    'jul', 'ago', 'sep', 'oct', 'nov', 'dic'
  ];
  return '${d.day} ${meses[d.month - 1]} ${d.year}';
}
