import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideBar extends StatefulWidget {
  const SideBar({
    super.key,
    required this.currentPath,
  });

  final String currentPath;

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  bool isOpenSilde = false;

  @override
  void initState() {
    super.initState();

   _loadSettings();
  }


  Future<void> _loadSettings() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final bool? intSlide = pref.getBool('slideOpen');

    if (mounted) {
      setState(() {
        isOpenSilde = intSlide ?? false;
      });
    }
  }

  void _handlerOpenSlide() {
    setState(() {
      isOpenSilde = !isOpenSilde;
    });

    SharedPreferences.getInstance().then((SharedPreferences pref) {
      pref.setBool('slideOpen', isOpenSilde);
    });
  }

  bool _isActive(String routePath) {
    return widget.currentPath == routePath;
  }

  void _goTo(String routePath) {
    if (widget.currentPath == routePath) {
      return;
    }

    context.go(routePath);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: isOpenSilde ? 200 : 72,
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
              icon: Icons.menu,
              tooltip: isOpenSilde ? 'Collapse' : 'Expand',
              isOpen: isOpenSilde,
              onTap: _handlerOpenSlide,
            ),
            const SizedBox(height: 10),
            _SidebarIcon(
              icon: Icons.bolt,
              isActive: _isActive('/home'),
              tooltip: 'Dashboard',
              isOpen: isOpenSilde,
              onTap: () => _goTo('/home'),
            ),
            const SizedBox(height: 5),
            _SidebarIcon(
              icon: Icons.folder_outlined,
              isActive: _isActive('/projects'),
              tooltip: 'Projects',
              isOpen: isOpenSilde,
              onTap: () => _goTo('/projects'),
            ),
            const SizedBox(height: 5),
            _SidebarIcon(
              icon: Icons.people_alt_outlined,
              isActive: _isActive('/team'),
              tooltip: 'Team',
              isOpen: isOpenSilde,
              onTap: () => _goTo('/team'),
            ),
            const SizedBox(height: 5),
            _SidebarIcon(
              icon: Icons.insert_chart_outlined,
              isActive: _isActive('/analytics'),
              tooltip: 'Analytics',
              isOpen: isOpenSilde,
              onTap: () => _goTo('/analytics'),
            ),
            const Spacer(),
            _SidebarIcon(
              icon: Icons.settings_outlined,
              isActive: _isActive('/settings'),
              tooltip: 'Settings',
              isOpen: isOpenSilde,
              onTap: () => _goTo('/settings'),
            ),
            const SizedBox(height: 5),
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
    required this.isOpen,
    required this.onTap,
  });

  final IconData icon;
  final bool isActive;
  final String tooltip;
  final bool isOpen;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final bgColor = isActive
        ? colorScheme.primary.withOpacity(0.12)
        : Colors.transparent;
    final iconColor = isActive
        ? colorScheme.primary
        : colorScheme.onSurface.withOpacity(0.7);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(isOpen ? 10 : 999),
        child: isOpen
            ? Container(
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(icon, size: 20, color: iconColor),
                    const SizedBox(width: 10),
                    Text(
                      tooltip,
                      style: TextStyle(color: iconColor),
                    ),
                  ],
                ),
              )
            : Tooltip(
                message: tooltip,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Icon(icon, size: 20, color: iconColor),
                ),
              ),
      ),
    );
  }
}
