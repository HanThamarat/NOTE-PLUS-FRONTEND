import 'package:flutter/material.dart';
import 'package:noteplus_app/components/theme_toggle/theme_toggle.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: const [ThemeToggle()],
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "Text",
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            ),
          ],
        ),
      ),
    );
  }
}