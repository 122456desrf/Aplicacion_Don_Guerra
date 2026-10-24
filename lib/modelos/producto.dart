// Modelo de datos: Producto del catálogo.

class Producto {
  final int id;
  final String nombre;
  final String categoria;
  final String descripcion;
  final double precio;
  final String material;
  final int stock;
  final String emoji;

  const Producto({
    required this.id,
    required this.nombre,
    required this.categoria,
    required this.descripcion,
    required this.precio,
    required this.material,
    required this.stock,
    required this.emoji,
  });

  bool get disponible => stock > 0;

  Producto copyWith({
    String? nombre,
    String? categoria,
    String? descripcion,
    double? precio,
    String? material,
    int? stock,
    String? emoji,
  }) {
    return Producto(
      id: id,
      nombre: nombre ?? this.nombre,
      categoria: categoria ?? this.categoria,
      descripcion: descripcion ?? this.descripcion,
      precio: precio ?? this.precio,
      material: material ?? this.material,
      stock: stock ?? this.stock,
      emoji: emoji ?? this.emoji,
    );
  }
}
