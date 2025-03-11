import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthService {
  Future<bool> signinWithEmailAndPassword(String email, String password);
  Future<bool> signupWithEmailAndPassword(String email, String password);
  User? currentUser();
}

class AuthServiceImpl implements AuthService {
  final _fireAuth = FirebaseAuth.instance;
  @override
  Future<bool> signinWithEmailAndPassword(String email, String password) async {
    final userCredential = await _fireAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = userCredential.user;
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> signupWithEmailAndPassword(String email, String password) async {
    final userCredential = await _fireAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = userCredential.user;
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  User? currentUser() {
    return _fireAuth.currentUser;
  }
}
