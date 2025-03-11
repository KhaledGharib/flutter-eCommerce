import 'package:ecommerce/services/auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  final AuthService authServices = AuthServiceImpl();
  Future<void> login(String email, String password) async {
    emit(AuthLoading());

    try {
      final res = await authServices.signinWithEmailAndPassword(
        email,
        password,
      );
      if (res) {
        emit(AuthAuthenticated());
      } else {
        emit(AuthError(errorMessage: "Unauthenticated"));
      }
    } catch (e) {
      emit(AuthError(errorMessage: e.toString()));
    }
  }

  Future<void> signUp(String email, String password) async {
    emit(AuthLoading());

    try {
      final res = await authServices.signupWithEmailAndPassword(
        email,
        password,
      );
      if (res) {
        emit(AuthAuthenticated());
      } else {
        emit(AuthError(errorMessage: "something went wrong!"));
      }
    } catch (e) {
      emit(AuthError(errorMessage: e.toString()));
    }
  }

  void checkAuth() {
    final user = authServices.currentUser();
    if (user != null) {
      emit(const AuthAuthenticated());
    }
  }
}
