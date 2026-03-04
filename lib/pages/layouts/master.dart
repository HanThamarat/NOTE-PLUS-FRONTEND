
import 'package:flutter/material.dart';
import 'package:noteplus_app/pages/layouts/nav.dart';
import 'package:noteplus_app/pages/layouts/slide.dart';

class MasterLayout extends StatefulWidget {
  final Widget child;
  const MasterLayout({super.key, required this.child});

  @override
  State<MasterLayout> createState() => _MasterLayoutState();
}

class _MasterLayoutState extends State<MasterLayout> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Row(
        children: [
          const SideBar(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const NavBarComponent(),
                Expanded(
                  child: Container(
                    color: colorScheme.surface,
                    child: widget.child,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}