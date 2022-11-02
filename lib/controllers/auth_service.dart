import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<bool> signinAnounimously() async {
    try {
      await _auth.signInAnonymously();
      return true;
    } on FirebaseAuthException catch (e) {
      print("sign in with firebase exceprtion failed ${e.message}");
      return false;
    } catch (e) {
      print("sign in failed $e");
      return false;
    }
  }

  Stream<User?> get authStateChange => _auth.authStateChanges();
}
