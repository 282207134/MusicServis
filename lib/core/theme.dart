import 'package:flutter/material.dart';

abstract final class AppColors {
  static const muted = Color(0xFF8D969B);
  static const cyan = Color(0xFF20D9C2);
  static const blue = Color(0xFF349EF2);
  static const pink = Color(0xFFF43F78);
  static const purple = Color(0xFF51447D);
}

@immutable
class AppPalette extends ThemeExtension<AppPalette> {
  const AppPalette({
    required this.background,
    required this.surface,
    required this.ink,
    required this.faint,
    required this.control,
  });

  final Color background;
  final Color surface;
  final Color ink;
  final Color faint;
  final Color control;

  static const light = AppPalette(
    background: Colors.white,
    surface: Colors.white,
    ink: Color(0xFF20292E),
    faint: Color(0xFFF5F7F8),
    control: Color(0xFFF0F1F2),
  );

  static const dark = AppPalette(
    background: Color(0xFF191919),
    surface: Color(0xFF242424),
    ink: Color(0xFFF5F5F5),
    faint: Color(0xFF242424),
    control: Color(0xFF343434),
  );

  @override
  AppPalette copyWith({
    Color? background,
    Color? surface,
    Color? ink,
    Color? faint,
    Color? control,
  }) {
    return AppPalette(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      ink: ink ?? this.ink,
      faint: faint ?? this.faint,
      control: control ?? this.control,
    );
  }

  @override
  AppPalette lerp(AppPalette? other, double t) {
    if (other == null) return this;
    return AppPalette(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      ink: Color.lerp(ink, other.ink, t)!,
      faint: Color.lerp(faint, other.faint, t)!,
      control: Color.lerp(control, other.control, t)!,
    );
  }
}

extension AppThemeContext on BuildContext {
  AppPalette get palette => Theme.of(this).extension<AppPalette>()!;
}

class AppThemeController extends ChangeNotifier {
  bool _dark = false;

  bool get isDark => _dark;

  set isDark(bool value) {
    if (_dark == value) return;
    _dark = value;
    notifyListeners();
  }
}

class AppThemeScope extends InheritedNotifier<AppThemeController> {
  const AppThemeScope({
    super.key,
    required AppThemeController super.notifier,
    required super.child,
  });

  static AppThemeController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppThemeScope>();
    assert(scope != null, 'AppThemeScope is missing');
    return scope!.notifier!;
  }
}

abstract final class AppTheme {
  static ThemeData get light => _theme(AppPalette.light, Brightness.light);
  static ThemeData get dark => _theme(AppPalette.dark, Brightness.dark);

  static ThemeData _theme(AppPalette palette, Brightness brightness) {
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: palette.background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.cyan,
        brightness: brightness,
        surface: palette.background,
      ),
      extensions: [palette],
      appBarTheme: AppBarTheme(
        backgroundColor: palette.background,
        foregroundColor: palette.ink,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: palette.ink,
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
      ),
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          color: palette.ink,
          fontSize: 30,
          height: 1.2,
          fontWeight: FontWeight.w400,
        ),
        headlineMedium: TextStyle(
          color: palette.ink,
          fontSize: 24,
          height: 1.25,
          fontWeight: FontWeight.w400,
        ),
        titleLarge: TextStyle(
          color: palette.ink,
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
        titleMedium: TextStyle(
          color: palette.ink,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: TextStyle(color: palette.ink, fontSize: 16, height: 1.4),
        bodyMedium: TextStyle(color: palette.ink, fontSize: 14, height: 1.4),
        bodySmall: const TextStyle(
          color: AppColors.muted,
          fontSize: 12,
          height: 1.35,
        ),
      ),
      iconTheme: IconThemeData(color: palette.ink),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: palette.faint,
        hintStyle: const TextStyle(color: AppColors.muted),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 17,
        ),
      ),
    );
  }
}

const appGradient = LinearGradient(
  colors: [AppColors.cyan, AppColors.blue],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);
