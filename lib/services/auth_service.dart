import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:one_byte_foods/services/database_service.dart';

class AuthService {
  AuthService._();
  AuthService();

  Stream<User?> getUser() {
    return FirebaseAuth.instance.authStateChanges();
  }

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

      await DatabaseService().updateUserData(credential.user!.uid);
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

  static Future<bool> signOutFromGoogle() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  static Future<void> resetPass({required email}) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  static Future<UserCredential?> signInWithGoogle() async {
    // Initialize GoogleSignIn with the necessary scopes
    final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);

    // Clear the authentication cache
    await googleSignIn.signOut();

    // Trigger the authentication flow and force account selection
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    // Check if user canceled the sign-in process
    if (googleUser == null) {
      return null;
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    final finalCred =
        await FirebaseAuth.instance.signInWithCredential(credential);

    await DatabaseService().updateUserData(finalCred.user!.uid);
  }

  // static Future<UserCredential> signInWithGoogle() async {
  //   // Trigger the authentication flow
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  //   await FirebaseAuth.instance.signOut();

  //   // Obtain the auth details from the request
  //   final GoogleSignInAuthentication? googleAuth =
  //       await googleUser?.authentication;

  //   // Create a new credential
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth?.accessToken,
  //     idToken: googleAuth?.idToken,
  //   );

  //   // Once signed in, return the UserCredential
  //   return await FirebaseAuth.instance.signInWithCredential(credential);
  // }
}
