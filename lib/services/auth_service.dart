import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  AuthService._();

  static Future<void> register(
      {required String email,
      required String pass,
      required String fullname}) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<String> logInWithEmailAndPass(
      {required String email, required String pass}) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);
      return ("log");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return ("user-not-found");
      } else if (e.code == 'wrong-password') {
        return ("wrong-password");
      }
      return ("");
    }
  }
}
