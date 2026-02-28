import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:noteplus_app/components/theme_toggle/theme_toggle.dart';
import 'package:noteplus_app/bloc/auth/auth_bloc.dart';
import 'package:noteplus_app/components/button/button.dart';
import 'package:noteplus_app/components/input/input.dart';
import 'package:noteplus_app/repositories/auth_repository.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late final TextEditingController _identityController;
  late final TextEditingController _passwordController;
  late final AuthBloc _authBloc;
  StreamSubscription<AuthState>? _authSubscription;

  @override
  void initState() {
    super.initState();
    _identityController = TextEditingController();
    _passwordController = TextEditingController();
    _authBloc = AuthBloc(AuthRepository());

    _authSubscription = _authBloc.stream.listen((state) {
      if (!mounted) return;

      if (state is AuthFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.message)),
        );
      }

      if (state is AuthSuccess) {
        context.go('/home');
      }
    });
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    _authBloc.close();
    _identityController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSignInPressed() {
    final username = _identityController.text.trim();
    final password = _passwordController.text;

    _authBloc.add(
      AuthLoginRequested(
        username: username,
        password: password,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Center(
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<AuthState>(
                stream: _authBloc.stream,
                initialData: _authBloc.state,
                builder: (context, snapshot) {
                  final state = snapshot.data;
                  final bool isLoading = state is AuthLoading;

                  return Form(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InputComponent(
                              label: "Username or Email",
                              controller: _identityController,
                              isPassword: false,
                              hintText:
                                  "Please enter your username or email",
                              validate: false,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            InputComponent(
                              label: "Password",
                              controller: _passwordController,
                              isPassword: true,
                              hintText: "Please enter your password",
                              validate: false,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ButtonComponent(
                              label: "Sign In",
                              isLoading: isLoading,
                              OnTap: isLoading ? null : _onSignInPressed,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
