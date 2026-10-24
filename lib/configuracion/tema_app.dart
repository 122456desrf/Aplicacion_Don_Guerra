// Colores y tema visual de la app (terracota, talavera y tonos cálidos).
import 'package:flutter/cupertino.dart' show CupertinoPageTransitionsBuilder;
import 'package:flutter/material.dart';

// ── Base cálida (se conservan los nombres originales) ──
const colorTerracota = Color(0xFFB5533C);
const colorMarron = Color(0xFF5D4037);
const colorMarronOscuro = Color(0xFF3E2723);
const colorMarronClaro = Color(0xFF8D6E63);
const colorCrema = Color(0xFFFBF8F5);
const colorBeige = Color(0xFFEFEBE9);
const colorVerde = Color(0xFF2F4A3A);

// ── Acentos nuevos (inspirados en la talavera) ──
const colorOcre = Color(0xFFE09F3E);
const colorTalavera = Color(0xFF2E5E9E);
const colorTurquesa = Color(0xFF2A9D8F);
const colorRosaMexicano = Color(0xFFC2476B);
const colorHoja = Color(0xFF4C8C5A);

/// Color propio de cada categoría del catálogo.
Color colorDeCategoria(String categoria) => switch (categoria) {
      'Macetas' => colorHoja,
      'Jarrones' => colorTalavera,
      'Tazas' => colorOcre,
      'Decoración' => colorRosaMexicano,
      'Figuras' => colorTurquesa,
      'Personalizados' => colorTerracota,
      _ => colorMarronClaro,
    };

/// Emoji de cada categoría.
String emojiDeCategoria(String categoria) => switch (categoria) {
      'Macetas' => '🪴',
      'Jarrones' => '🏺',
      'Tazas' => '☕',
      'Decoración' => '✨',
      'Figuras' => '🗿',
      'Personalizados' => '🎨',
      _ => '🧱',
    };

/// Degradado cálido que se repite en cabeceras y banners.
const degradadoCalido = LinearGradient(
  colors: [colorTerracota, Color(0xFF8E3B2A)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const degradadoTierra = LinearGradient(
  colors: [colorMarron, colorMarronOscuro],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

ThemeData construirTema() {
  final esquema = ColorScheme.fromSeed(
    seedColor: colorTerracota,
    primary: colorTerracota,
    secondary: colorTalavera,
    tertiary: colorOcre,
    surface: colorCrema,
  );
  final bordeCampo = OutlineInputBorder(
    borderRadius: BorderRadius.circular(14),
    borderSide: BorderSide.none,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: esquema,
    scaffoldBackgroundColor: colorCrema,
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.android: ZoomPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.windows: ZoomPageTransitionsBuilder(),
      TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.linux: ZoomPageTransitionsBuilder(),
    }),
    appBarTheme: const AppBarTheme(
      backgroundColor: colorCrema,
      foregroundColor: colorMarronOscuro,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
          color: colorMarronOscuro, fontSize: 20, fontWeight: FontWeight.w800),
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: colorMarron.withValues(alpha: 0.08)),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: colorTerracota,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: colorTerracota,
        side: const BorderSide(color: colorTerracota, width: 1.4),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: bordeCampo,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: colorMarron.withValues(alpha: 0.12)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: colorTerracota, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.redAccent, width: 2),
      ),
      prefixIconColor: colorMarronClaro,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: Colors.white,
      selectedColor: colorTerracota.withValues(alpha: 0.16),
      side: BorderSide(color: colorMarron.withValues(alpha: 0.15)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      labelStyle: const TextStyle(
          color: colorMarronOscuro, fontWeight: FontWeight.w600),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.white,
      elevation: 8,
      shadowColor: colorMarronOscuro.withValues(alpha: 0.25),
      indicatorColor: colorTerracota.withValues(alpha: 0.18),
      labelTextStyle: WidgetStateProperty.resolveWith((estados) => TextStyle(
            fontSize: 12,
            fontWeight: estados.contains(WidgetState.selected)
                ? FontWeight.w800
                : FontWeight.w500,
            color: estados.contains(WidgetState.selected)
                ? colorTerracota
                : colorMarronClaro,
          )),
      iconTheme: WidgetStateProperty.resolveWith((estados) => IconThemeData(
            color: estados.contains(WidgetState.selected)
                ? colorTerracota
                : colorMarronClaro,
          )),
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: colorMarronOscuro,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
  );
}
