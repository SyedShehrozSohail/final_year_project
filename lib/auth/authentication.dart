
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthImplementation {
  Future<String> signIn(String email, String password);
  Future<String> signUp(String username, String email, String mobile, String password);
  Future<String> getCurrentUser();
  Future<String> getCurrentUserEmail();
  Future<void> signOut();
}

class Auth implements AuthImplementation {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> signIn(String email, String password) async {
    AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    return user.uid;
  }

  Future<String> signUp(String username, String email, String mobile, String password) async {
    AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    return user.uid;
  }


  Future<String> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
//    return user.uid;
    return user != null ? user.uid : null;
  }

  Future<String> getCurrentUserEmail() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.email;
  }
  Future<void> signOut() async {
    _firebaseAuth.signOut();
  }
}