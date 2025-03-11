part of 'auth_cubit.dart';

sealed class AuthState {
  const AuthState();
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthAuthenticated extends AuthState {
  const AuthAuthenticated();
}

final class AuthError extends AuthState {
  final String errorMessage;

  AuthError({required this.errorMessage});
}
