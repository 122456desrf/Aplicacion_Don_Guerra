// Login con validación de correo y contraseña.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../configuracion/navegacion_por_rol.dart';
import '../../configuracion/tema_app.dart';
import '../../proveedores/autenticacion_provider.dart';
import '../../widgets_compartidos/animaciones.dart';
import 'registro_pantalla.dart';

final _regexCorreo = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

class InicioSesionPantalla extends StatefulWidget {
  const InicioSesionPantalla({super.key});

  @override
  State<InicioSesionPantalla> createState() => _InicioSesionPantallaState();
}

class _InicioSesionPantallaState extends State<InicioSesionPantalla> {
  final _form = GlobalKey<FormState>();
  final _correo = TextEditingController();
  final _pass = TextEditingController();
  bool _oculta = true;

  @override
  void dispose() {
    _correo.dispose();
    _pass.dispose();
    super.dispose();
  }

  void _entrar() {
    if (!_form.currentState!.validate()) return;
    final auth = context.read<AutenticacionProvider>();
    final error = auth.iniciarSesion(_correo.text, _pass.text);
    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
      return;
    }
    irAlDashboardSegunRol(context, auth.actual!.rol);
  }

  void _rellenar(String correo, String pass) {
    setState(() {
      _correo.text = correo;
      _pass.text = pass;
    });
  }

  Widget _cuentaPrueba(String texto, IconData icono, Color color,
      String correo, String pass) {
    return ActionChip(
      avatar: Icon(icono, size: 18, color: color),
      label: Text(texto),
      backgroundColor: color.withValues(alpha: 0.1),
      side: BorderSide(color: color.withValues(alpha: 0.5)),
      labelStyle: TextStyle(color: color, fontWeight: FontWeight.w700),
      onPressed: () => _rellenar(correo, pass),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Cabecera con degradado
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(
                  24, MediaQuery.of(context).padding.top + 36, 24, 44),
              decoration: const BoxDecoration(
                gradient: degradadoCalido,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(40)),
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Positioned(
                      right: -60,
                      top: -70,
                      child: BurbujaDecorativa(tamano: 170)),
                  const Positioned(
                      left: -40,
                      bottom: -60,
                      child: BurbujaDecorativa(tamano: 130, opacidad: 0.07)),
                  Column(
                    children: [
                      const Aparicion(
                        child: Text('🏺', style: TextStyle(fontSize: 64)),
                      ),
                      const SizedBox(height: 8),
                      const Aparicion(
                        retraso: Duration(milliseconds: 120),
                        child: Text('Don Guerra',
                            style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w900,
                                color: Colors.white)),
                      ),
                      const SizedBox(height: 4),
                      Aparicion(
                        retraso: const Duration(milliseconds: 220),
                        child: Text('Cerámica artesanal de Guanajuato',
                            style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.85))),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Aparicion(
                    retraso: const Duration(milliseconds: 300),
                    child: Form(
                      key: _form,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text('¡Bienvenido!',
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w900,
                                  color: colorMarronOscuro)),
                          const SizedBox(height: 4),
                          const Text(
                              'Inicia sesión o crea una cuenta para comenzar.',
                              style: TextStyle(color: colorMarronClaro)),
                          const SizedBox(height: 22),
                          TextFormField(
                            controller: _correo,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              labelText: 'Correo electrónico',
                              prefixIcon: Icon(Icons.email_outlined),
                            ),
                            validator: (v) {
                              if (v == null || v.trim().isEmpty) {
                                return 'Ingresa tu correo';
                              }
                              if (!_regexCorreo.hasMatch(v.trim())) {
                                return 'Correo no válido';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 14),
                          TextFormField(
                            controller: _pass,
                            obscureText: _oculta,
                            decoration: InputDecoration(
                              labelText: 'Contraseña',
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                icon: Icon(_oculta
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () =>
                                    setState(() => _oculta = !_oculta),
                              ),
                            ),
                            validator: (v) {
                              if (v == null || v.isEmpty) {
                                return 'Ingresa tu contraseña';
                              }
                              if (v.length < 6) return 'Mínimo 6 caracteres';
                              return null;
                            },
                          ),
                          const SizedBox(height: 22),
                          FilledButton.icon(
                            onPressed: _entrar,
                            icon: const Icon(Icons.login),
                            label: const Text('Iniciar sesión'),
                          ),
                          const SizedBox(height: 10),
                          OutlinedButton.icon(
                            onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => const RegistroPantalla()),
                            ),
                            icon: const Icon(Icons.person_add_alt_1),
                            label: const Text('Crear cuenta'),
                          ),
                          const SizedBox(height: 26),
                          const Row(
                            children: [
                              Expanded(child: Divider()),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text('Cuentas de prueba',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: colorMarronClaro)),
                              ),
                              Expanded(child: Divider()),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              _cuentaPrueba(
                                  'Administrador',
                                  Icons.admin_panel_settings,
                                  colorTalavera,
                                  'admin@donguerra.com',
                                  'Admin123'),
                              _cuentaPrueba(
                                  'Artesano',
                                  Icons.handyman,
                                  colorOcre,
                                  'artesano@donguerra.com',
                                  'Artesano123'),
                              _cuentaPrueba(
                                  'Cliente',
                                  Icons.shopping_bag,
                                  colorTurquesa,
                                  'cliente@donguerra.com',
                                  'Cliente123'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
