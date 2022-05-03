import 'package:firebase_auth/firebase_auth.dart';
import 'package:si_app/src/models/user.dart' as user_model;

class UserRepository {
  user_model.User? currentUser;
  late final FirebaseAuth _firebaseAuth;

  UserRepository({FirebaseAuth? firebaseAuth}) {
    _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;
    _firebaseAuth.setPersistence(Persistence.LOCAL);
  }

  Future<UserCredential> signInWithCredentials(String email, String password) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> signUp({required String email, required String password}) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }

  Future<bool> isSignedIn() async {
    User? currentUser = _firebaseAuth.currentUser;
    currentUser ??= await FirebaseAuth.instance.authStateChanges().first;
    return currentUser != null;
  }

  String? getUser() {
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser != null) {
      return currentUser.email;
    } else {
      return null;
    }
  }
}
