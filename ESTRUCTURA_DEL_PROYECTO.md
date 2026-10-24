# Estructura del proyecto Don Guerra

Todo el código está en `lib/`. Cada archivo tiene **una sola responsabilidad** y su nombre dice qué es:

- `*_pantalla.dart` → una pantalla completa
- `*_provider.dart` → estado compartido (Provider)
- `modelos/*.dart` → clases de datos
- `widgets_compartidos/*.dart` → piezas visuales reutilizables

## Carpetas

| Carpeta | Para qué sirve |
|---|---|
| `lib/configuracion/` | Tema visual y navegación según el rol. |
| `lib/modelos/` | Clases de datos (qué información maneja la app). |
| `lib/proveedores/` | Manejo de estado con Provider (la "memoria" de la app). |
| `lib/utilidades/` | Funciones auxiliares de formato. |
| `lib/widgets_compartidos/` | Piezas visuales reutilizadas en varias pantallas. |
| `lib/pantallas/inicio/` | Splash. |
| `lib/pantallas/autenticacion/` | Login y registro. |
| `lib/pantallas/cliente/` | Todo lo que ve el cliente. |
| `lib/pantallas/artesano/` | Todo lo que ve el artesano. |
| `lib/pantallas/administrador/` | Todo lo que ve el administrador. |

## Archivos

### `lib/`

| Archivo | Qué hace |
|---|---|
| `main.dart` | Punto de entrada: registra los 3 providers y abre el splash. |

### `lib/configuracion/`

| Archivo | Qué hace |
|---|---|
| `navegacion_por_rol.dart` | Lleva al dashboard según el rol y cierra sesión. |
| `tema_app.dart` | Paleta (terracota, talavera, ocre, turquesa…), colores por categoría y tema visual de la app. |

### `lib/modelos/`

| Archivo | Qué hace |
|---|---|
| `estado_pedido.dart` | Estados de un pedido: solicitud → elaboración → terminado → entregado. |
| `pedido.dart` | Modelo de datos: Pedido (simple o personalizado). |
| `producto.dart` | Modelo de datos: Producto del catálogo. |
| `rol.dart` | Roles de usuario: administrador, artesano y cliente. |
| `usuario.dart` | Modelo de datos: Usuario. |

### `lib/pantallas/administrador/`

| Archivo | Qué hace |
|---|---|
| `dashboard_admin_pantalla.dart` | Dashboard del administrador (Resumen, Productos, Usuarios). |
| `formulario_producto_pantalla.dart` | FORMULARIO del administrador: alta y edición de producto. |
| `lista_productos_admin_pantalla.dart` | LISTA de productos con alta, edición y baja. |
| `lista_usuarios_admin_pantalla.dart` | LISTA de usuarios registrados. |
| `resumen_admin_pantalla.dart` | Resumen del negocio: productos, usuarios, pedidos y ventas. |

### `lib/pantallas/artesano/`

| Archivo | Qué hace |
|---|---|
| `actualizar_pedido_pantalla.dart` | FORMULARIO del artesano: actualizar estado, precio, entrega y nota. |
| `dashboard_artesano_pantalla.dart` | Dashboard del artesano con barra inferior (Resumen, Pedidos). |
| `lista_pedidos_artesano_pantalla.dart` | LISTA de pedidos entrantes con filtro por estado. |
| `resumen_artesano_pantalla.dart` | Resumen del taller: conteo de pedidos por estado. |

### `lib/pantallas/autenticacion/`

| Archivo | Qué hace |
|---|---|
| `inicio_sesion_pantalla.dart` | Login con validación de correo y contraseña. |
| `registro_pantalla.dart` | Registro de cuenta con selección de rol. |

### `lib/pantallas/cliente/`

| Archivo | Qué hace |
|---|---|
| `catalogo_pantalla.dart` | LISTA PRINCIPAL: catálogo con búsqueda y filtro por categoría. |
| `dashboard_cliente_pantalla.dart` | Dashboard del cliente con barra inferior (Inicio, Catálogo, Pedidos, Perfil). |
| `detalle_producto_pantalla.dart` | Detalle de un producto y botón para solicitar pedido. |
| `inicio_cliente_pantalla.dart` | Inicio del cliente: saludo, pedido reciente y categorías. |
| `mis_pedidos_pantalla.dart` | LISTA SECUNDARIA: pedidos del cliente (con estado vacío). |
| `pedido_personalizado_pantalla.dart` | FORMULARIO del cliente: pedido personalizado. |
| `perfil_cliente_pantalla.dart` | Perfil del cliente y cierre de sesión. |
| `seguimiento_pedido_pantalla.dart` | Seguimiento de un pedido con su línea de tiempo. |

### `lib/pantallas/inicio/`

| Archivo | Qué hace |
|---|---|
| `splash_pantalla.dart` | Pantalla de carga inicial (3 s) y paso al login. |

### `lib/proveedores/`

| Archivo | Qué hace |
|---|---|
| `autenticacion_provider.dart` | Estado de sesión: login, registro, usuarios y usuario actual. |
| `catalogo_provider.dart` | Estado del catálogo: alta, edición, baja y stock de productos. |
| `pedidos_provider.dart` | Estado de pedidos: crear, consultar y actualizar su avance. |

### `lib/utilidades/`

| Archivo | Qué hace |
|---|---|
| `formato.dart` | Funciones para dar formato a dinero, fechas y totales. |

### `lib/widgets_compartidos/`

| Archivo | Qué hace |
|---|---|
| `boton_cerrar_sesion.dart` | Botón de cerrar sesión para las barras superiores. |
| `estado_vacio.dart` | Widget "No hay elementos" para listas vacías. |
| `etiqueta_estado_pedido.dart` | Etiqueta de color con el estado del pedido. |
| `linea_tiempo_pedido.dart` | Línea de tiempo del trabajo artesanal. |
| `tarjeta_estadistica.dart` | Tarjeta de color con número animado y su etiqueta (dashboards). |
| `animaciones.dart` | `Aparicion` (entrada escalonada), `Presionable` (efecto al tocar), `NumeroAnimado` y `BurbujaDecorativa`. |
| `cabecera_degradada.dart` | Banner de saludo con degradado para los paneles de admin y artesano. |
| `tarjeta_pedido.dart` | Tarjeta de pedido para las listas de cliente y artesano. |

## ¿Dónde está lo que pide la guía de la entrega?

| Requisito | Archivo(s) |
|---|---|
| Splashscreen | `pantallas/inicio/splash_pantalla.dart` |
| Login con validación | `pantallas/autenticacion/inicio_sesion_pantalla.dart` |
| Registro con selección de rol | `pantallas/autenticacion/registro_pantalla.dart` |
| Dashboard Administrador | `pantallas/administrador/dashboard_admin_pantalla.dart` |
| Dashboard Artesano | `pantallas/artesano/dashboard_artesano_pantalla.dart` |
| Dashboard Cliente | `pantallas/cliente/dashboard_cliente_pantalla.dart` |
| Lista principal (dinámica) | `pantallas/cliente/catalogo_pantalla.dart` |
| Lista secundaria | `pantallas/cliente/mis_pedidos_pantalla.dart` |
| Estado vacío | `widgets_compartidos/estado_vacio.dart` |
| Formulario del cliente | `pantallas/cliente/pedido_personalizado_pantalla.dart` |
| Formulario del artesano | `pantallas/artesano/actualizar_pedido_pantalla.dart` |
| Formulario del administrador | `pantallas/administrador/formulario_producto_pantalla.dart` |
| Manejo de estado (Provider) | `proveedores/` (3 archivos) y `main.dart` |
