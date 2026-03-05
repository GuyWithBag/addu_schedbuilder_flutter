import 'package:flutter/material.dart';

/// Centralized theme configuration for the app.
///
/// Reference palette is built around a muted indigo seed [Color(0xFF5B5EA6)].
/// All screens should pull colors from [Theme.of(context)] or from the
/// semantic helpers exposed here rather than hard-coding hex values.
class AppTheme {
  AppTheme._();

  // ── Seed / brand ──────────────────────────────────────────────────────
  static const Color seed = Color(0xFF5B5EA6);
  static const Color seedDark = Color(0xFF4A4A8A);

  // ── Surfaces (light mode) ─────────────────────────────────────────────
  static const Color scaffoldLight = Color(0xFFF2F2F7);
  static const Color cardLight = Colors.white;
  static const Color inputFillLight = Color(0xFFE8E8F4);

  // ── Surfaces (dark mode) ──────────────────────────────────────────────
  static const Color scaffoldDark = Color(0xFF1C1C1E);
  static const Color cardDark = Color(0xFF2C2C2E);
  static const Color inputFillDark = Color(0xFF3A3A3C);

  // ── Text ──────────────────────────────────────────────────────────────
  static const Color textPrimaryLight = Color(0xFF1C1C1E);
  static const Color textSecondaryLight = Color(0xFF3C3C3C);
  static const Color textPrimaryDark = Color(0xFFF2F2F7);
  static const Color textSecondaryDark = Color(0xFFAEAEB2);

  // ── Semantic / feedback ───────────────────────────────────────────────
  static const Color successBg = Color(0xFFD4EDDA);
  static const Color successFg = Color(0xFF1C5A2A);
  static const Color successIcon = Color(0xFF28A745);

  static const Color errorBg = Color(0xFFFFCDD2);
  static const Color errorFg = Color(0xFFB71C1C);

  static const Color warningBg = Color(0xFFFFF3CD);
  static const Color warningFg = Color(0xFF856404);

  static const Color infoBg = Color(0xFFDCEEFD);
  static const Color infoFg = Color(0xFF0C5460);

  // ── Stat card palette ─────────────────────────────────────────────────
  static const Color statBlue = Color(0xFFDCEEFD);
  static const Color statGreen = Color(0xFFDCF5E8);
  static const Color statYellow = Color(0xFFFFF3CD);
  static const Color statPurple = Color(0xFFEDE7F6);

  // ── Danger action (delete buttons, destructive) ───────────────────────
  static const Color danger = Color(0xFFDC3545);

  // ── Note type colors ──────────────────────────────────────────────────
  static const Color noteHomework = Color(0xFF2196F3);
  static const Color noteExam = Color(0xFFFFA726);
  static const Color noteGeneral = Color(0xFFF44336);

  // ── Comparison / schedule overlay ─────────────────────────────────────
  static const Color freeTime = Color(0xFF4CAF50);
  static const Color busyTime = Color(0xFFFFA726);

  // ── Chart / distribution colors ───────────────────────────────────────
  static const Color chartMorning = Color(0xFFFFCA28);
  static const Color chartAfternoon = Color(0xFFFFA726);
  static const Color chartEvening = Color(0xFFFF5722);

  // ── ThemeData builders ────────────────────────────────────────────────

  static ThemeData light() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: seed,
      brightness: Brightness.light,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: scaffoldLight,
      cardColor: cardLight,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: seedDark,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          textStyle: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: inputFillLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: seed, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: seed, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: seed, width: 2),
        ),
        labelStyle: TextStyle(color: seed),
      ),
      cardTheme: CardThemeData(
        color: cardLight,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: seed,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        elevation: 8,
      ),
      dividerColor: Colors.grey.shade300,
    );
  }

  static ThemeData dark() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: seed,
      brightness: Brightness.dark,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: scaffoldDark,
      cardColor: cardDark,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: seed,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          textStyle: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: inputFillDark,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: seed, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: seed.withAlpha(180), width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: seed, width: 2),
        ),
        labelStyle: const TextStyle(color: seed),
      ),
      cardTheme: CardThemeData(
        color: cardDark,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: seed,
        unselectedItemColor: Colors.grey,
        backgroundColor: Color(0xFF2C2C2E),
        elevation: 8,
      ),
      dividerColor: Colors.grey.shade700,
    );
  }
}
