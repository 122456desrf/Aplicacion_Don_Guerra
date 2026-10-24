// Registro de cuenta con selección de rol.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../configuracion/navegacion_por_rol.dart';
import '../../configuracion/tema_app.dart';
import '../../modelos/modelos.dart';
import '../../proveedores/autenticacion_provider.dart';

final _regexCorreo = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

class RegistroPantalla extends StatefulWidget {
  const RegistroPantalla({super.key});

  @override
  State<RegistroPantalla> createState() => _RegistroPantallaState();
}

class _RegistroPantallaState extends State<RegistroPantalla> {
  final _form = GlobalKey<FormState>();
  final _nombre = TextEditingController();
  final _correo = TextEditingController();
  final _pass = TextEditingController();
  final _pass2 = TextEditingController();
  Rol _rol = Rol.cliente;
  bool _oculta = true;

  @override
  void dispose() {
    _nombre.dispose();
    _correo.dispose();
    _pass.dispose();
    _pass2.dispose();
    super.dispose();
  }

  void _registrar() {
    if (!_form.currentState!.validate()) return;
    final auth = context.read<AutenticacionProvider>();
    final error = auth.registrar(
      nombre: _nombre.text,
      correo: _correo.text,
      contrasena: _pass.text,
      rol: _rol,
    );
    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
      return;
    }
    irAlDashboardSegunRol(context, _rol);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crear cuenta')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nombre,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Nombre completo',
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: (v) {
                  if (v == null || v.trim().length < 3) {
                    return 'Ingresa tu nombre (mínimo 3 letras)';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _correo,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Correo electrónico',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Ingresa tu correo';
                  if (!_regexCorreo.hasMatch(v.trim())) return 'Correo no válido';
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
                    icon: Icon(
                        _oculta ? Icons.visibility : Icons.visibility_off),
                    onPressed: () => setState(() => _oculta = !_oculta),
                  ),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Crea una contraseña';
                  if (v.length < 6) return 'Mínimo 6 caracteres';
                  return null;
                },
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _pass2,
                obscureText: _oculta,
                decoration: const InputDecoration(
                  labelText: 'Confirmar contraseña',
                  prefixIcon: Icon(Icons.lock_outline),
                ),
                validator: (v) =>
                    v != _pass.text ? 'Las contraseñas no coinciden' : null,
              ),
              const SizedBox(height: 20),
              const Text('Tipo de usuario',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: colorMarronOscuro)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  for (final r in Rol.values)
                    ChoiceChip(
                      label: Text(r.nombre),
                      selected: _rol == r,
                      onSelected: (_) => setState(() => _rol = r),
                    ),
                ],
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: _registrar,
                style: FilledButton.styleFrom(
                    backgroundColor: colorTerracota,
                    padding: const EdgeInsets.symmetric(vertical: 14)),
                child: const Text('Registrarme'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
