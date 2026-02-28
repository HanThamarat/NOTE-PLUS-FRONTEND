import 'package:flutter/material.dart';

class ThemeScope extends InheritedWidget {
  const ThemeScope({
    super.key,
    required this.themeMode,
    required this.setThemeMode,
    required super.child,
  });

  final ThemeMode themeMode;
  final void Function(ThemeMode) setThemeMode;

  static ThemeScope of(BuildContext context) {
    final ThemeScope? result =
        context.dependOnInheritedWidgetOfExactType<ThemeScope>();
    assert(result != null, 'No ThemeScope found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ThemeScope oldWidget) {
    return themeMode != oldWidget.themeMode;
  }
}
