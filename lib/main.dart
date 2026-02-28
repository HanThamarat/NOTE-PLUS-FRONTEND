import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:noteplus_app/firebase_options.dart';
import 'package:noteplus_app/router/routes.dart';
import 'package:noteplus_app/theme/app_theme.dart';
import 'package:noteplus_app/theme/theme_scope.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _themeKey = 'theme_mode';

Future<ThemeMode> _loadThemeMode() async {
  final prefs = await SharedPreferences.getInstance();
  final value = prefs.getString(_themeKey);
  switch (value) {
    case 'light':
      return ThemeMode.light;
    case 'dark':
      return ThemeMode.dark;
    default:
      return ThemeMode.system;
  }
}

Future<void> _saveThemeMode(ThemeMode mode) async {
  final prefs = await SharedPreferences.getInstance();
  switch (mode) {
    case ThemeMode.light:
      await prefs.setString(_themeKey, 'light');
      break;
    case ThemeMode.dark:
      await prefs.setString(_themeKey, 'dark');
      break;
    case ThemeMode.system:
      await prefs.setString(_themeKey, 'system');
      break;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final themeMode = await _loadThemeMode();
  runApp(MyApp(initialThemeMode: themeMode));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.initialThemeMode});

  final ThemeMode initialThemeMode;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ThemeMode _themeMode;

  @override
  void initState() {
    super.initState();
    _themeMode = widget.initialThemeMode;
  }

  void _setThemeMode(ThemeMode mode) {
    setState(() => _themeMode = mode);
    _saveThemeMode(mode);
  }

  @override
  Widget build(BuildContext context) {
    return ThemeScope(
      themeMode: _themeMode,
      setThemeMode: _setThemeMode,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: _themeMode,
        routerConfig: Routes.router,
      ),
    );
  }
}
