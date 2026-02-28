import 'package:flutter/material.dart';
import 'package:noteplus_app/theme/theme_scope.dart';

class ThemeToggle extends StatelessWidget {
  const ThemeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final scope = ThemeScope.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return PopupMenuButton<ThemeMode>(
      icon: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
      tooltip: 'Theme',
      onSelected: scope.setThemeMode,
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: ThemeMode.light,
          child: Row(
            children: [
              Icon(Icons.light_mode),
              SizedBox(width: 12),
              Text('Light'),
            ],
          ),
        ),
        const PopupMenuItem(
          value: ThemeMode.dark,
          child: Row(
            children: [
              Icon(Icons.dark_mode),
              SizedBox(width: 12),
              Text('Dark'),
            ],
          ),
        ),
        const PopupMenuItem(
          value: ThemeMode.system,
          child: Row(
            children: [
              Icon(Icons.brightness_auto),
              SizedBox(width: 12),
              Text('System'),
            ],
          ),
        ),
      ],
    );
  }
}
