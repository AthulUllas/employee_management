import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  Future<User?> signUp(String email, String password) async {
    final userData = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userData.user;
  }

  Future<User?> signIn(String email, String password) async {
    final userData = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userData.user;
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
