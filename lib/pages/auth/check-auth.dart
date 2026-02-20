import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitialAppPage extends StatefulWidget {
  const InitialAppPage({super.key});

  @override
  State<InitialAppPage> createState() => _InitialAppPageState();
}

class _InitialAppPageState extends State<InitialAppPage> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAuth();
    });
  }

  Future _checkAuth() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final String? getAuthToken = pref.getString('authToken');

    if (!mounted) return;

    if (getAuthToken == null) {
      return context.go('/auth');
    } else if (getAuthToken != "") {
      return context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
