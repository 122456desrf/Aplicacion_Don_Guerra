// Estado del catálogo: alta, edición, baja y stock de productos.
import 'package:flutter/foundation.dart';
import '../modelos/modelos.dart';

/// Maneja el catálogo de productos (en memoria).
class CatalogoProvider extends ChangeNotifier {
  static const categorias = [
    'Macetas',
    'Jarrones',
    'Tazas',
    'Decoración',
    'Figuras',
    'Personalizados',
  ];

  final List<Producto> _productos = [
    const Producto(
        id: 1,
        nombre: 'Jarrón de Barro Tradicional',
        categoria: 'Jarrones',
        descripcion:
            'Jarrón elaborado totalmente a mano con técnicas tradicionales de modelado y quemado.',
        precio: 1250,
        material: 'Barro',
        stock: 8,
        emoji: '🏺'),
    const Producto(
        id: 2,
        nombre: 'Mug Rústico de Arcilla',
        categoria: 'Tazas',
        descripcion: 'Taza de cerámica artesanal con acabado esmaltado.',
        precio: 280,
        material: 'Cerámica artesanal',
        stock: 20,
        emoji: '☕'),
    const Producto(
        id: 3,
        nombre: 'Jarrón de Terracota del Desierto',
        categoria: 'Jarrones',
        descripcion: 'Jarrón de terracota con textura natural.',
        precio: 650,
        material: 'Barro',
        stock: 6,
        emoji: '🏺'),
    const Producto(
        id: 4,
        nombre: 'Plato Decorativo Flor de Maíz',
        categoria: 'Decoración',
        descripcion: 'Plato pintado a mano con motivos de flor de maíz.',
        precio: 1200,
        material: 'Cerámica artesanal',
        stock: 3,
        emoji: '🖼️'),
    const Producto(
        id: 5,
        nombre: 'Maceta Colgante Naturaleza',
        categoria: 'Macetas',
        descripcion: 'Maceta de cerámica con cuerda de yute.',
        precio: 410,
        material: 'Gres',
        stock: 0,
        emoji: '🪴'),
    const Producto(
        id: 6,
        nombre: 'Set Mini Figuras de Animales',
        categoria: 'Figuras',
        descripcion: 'Set de 3 figuras de animales modeladas a mano.',
        precio: 790,
        material: 'Barro',
        stock: 5,
        emoji: '🦉'),
    const Producto(
        id: 7,
        nombre: 'Taza Esencia Café',
        categoria: 'Tazas',
        descripcion: 'Taza blanca de gres, ideal para café.',
        precio: 320,
        material: 'Gres',
        stock: 12,
        emoji: '☕'),
    const Producto(
        id: 8,
        nombre: 'Maceta de Barro con Plato',
        categoria: 'Macetas',
        descripcion: 'Maceta clásica de barro con plato incluido.',
        precio: 220,
        material: 'Barro',
        stock: 15,
        emoji: '🪴'),
  ];

  List<Producto> get productos => List.unmodifiable(_productos);

  int get _siguienteId =>
      _productos.isEmpty ? 1 : _productos.map((p) => p.id).reduce((a, b) => a > b ? a : b) + 1;

  void agregar({
    required String nombre,
    required String categoria,
    required String descripcion,
    required double precio,
    required String material,
    required int stock,
    required String emoji,
  }) {
    _productos.add(Producto(
      id: _siguienteId,
      nombre: nombre,
      categoria: categoria,
      descripcion: descripcion,
      precio: precio,
      material: material,
      stock: stock,
      emoji: emoji,
    ));
    notifyListeners();
  }

  void actualizar(Producto nuevo) {
    final i = _productos.indexWhere((p) => p.id == nuevo.id);
    if (i == -1) return;
    _productos[i] = nuevo;
    notifyListeners();
  }

  void eliminar(int id) {
    _productos.removeWhere((p) => p.id == id);
    notifyListeners();
  }

  void descontarStock(int id, int cantidad) {
    final i = _productos.indexWhere((p) => p.id == id);
    if (i == -1) return;
    final p = _productos[i];
    final nuevo = p.stock - cantidad;
    _productos[i] = p.copyWith(stock: nuevo < 0 ? 0 : nuevo);
    notifyListeners();
  }
}
