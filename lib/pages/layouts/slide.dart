import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 72,
      height: double.infinity,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          right: BorderSide(
            color: colorScheme.outline.withOpacity(0.4),
            width: 0.5,
          ),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),
            _SidebarIcon(
              icon: Icons.bolt,
              isActive: true,
              tooltip: 'Dashboard',
            ),
            const SizedBox(height: 24),
            _SidebarIcon(
              icon: Icons.folder_outlined,
              tooltip: 'Projects',
            ),
            const SizedBox(height: 16),
            _SidebarIcon(
              icon: Icons.people_alt_outlined,
              tooltip: 'Team',
            ),
            const SizedBox(height: 16),
            _SidebarIcon(
              icon: Icons.insert_chart_outlined,
              tooltip: 'Analytics',
            ),
            const Spacer(),
            _SidebarIcon(
              icon: Icons.settings_outlined,
              tooltip: 'Settings',
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _SidebarIcon extends StatelessWidget {
  const _SidebarIcon({
    required this.icon,
    this.isActive = false,
    required this.tooltip,
  });

  final IconData icon;
  final bool isActive;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final bgColor = isActive ? colorScheme.primary.withOpacity(0.12) : Colors.transparent;
    final iconColor = isActive ? colorScheme.primary : colorScheme.onSurface.withOpacity(0.7);

    return Tooltip(
      message: tooltip,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(999),
        ),
        padding: const EdgeInsets.all(10),
        child: Icon(
          icon,
          size: 20,
          color: iconColor,
        ),
      ),
    );
  }
}