import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:noteplus_app/model/auth-model.dart';
import 'package:noteplus_app/repositories/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Events
abstract class AuthEvent {}

class AuthLoginRequested extends AuthEvent {
  final String username;
  final String password;

  AuthLoginRequested({
    required this.username,
    required this.password,
  });
}

// States
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final AuthenticateModel user;

  AuthSuccess(this.user);
}

class AuthFailure extends AuthState {
  final String message;

  AuthFailure(this.message);
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(AuthInitial()) {
    on<AuthLoginRequested>(_onLoginRequested);
  }

  Future<void> _onLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      final AuthenticateModel user = await _authRepository.login(
        username: event.username,
        password: event.password,
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('authToken', user.authToken ?? '');

      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}

