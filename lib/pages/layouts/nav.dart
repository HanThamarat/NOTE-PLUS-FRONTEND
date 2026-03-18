
import 'package:flutter/material.dart';
import 'package:noteplus_app/components/theme_toggle/theme_toggle.dart';

class NavBarComponent extends StatelessWidget {
  const NavBarComponent({
    super.key,
    required this.currentPath,
  });

  final String currentPath;

  String get _title {
    switch (currentPath) {
      case '/projects':
        return 'Projects';
      case '/team':
        return 'Team';
      case '/analytics':
        return 'Analytics';
      case '/settings':
        return 'Settings';
      case '/home':
      default:
        return 'Dashboard';
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outline.withOpacity(0.4),
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const ThemeToggle(),
        ],
      ),
    );
  }
}
