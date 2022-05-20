import 'package:firebase_auth/firebase_auth.dart';
import 'package:si_app/src/models/user.dart' as user_model;
import 'package:si_app/src/services/api_service.dart';

class UserRepository {
  user_model.User? currentUser;
  late final FirebaseAuth _firebaseAuth;

  UserRepository({FirebaseAuth? firebaseAuth}) {
    _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;
    _firebaseAuth.setPersistence(Persistence.LOCAL);
  }

  Future<UserCredential> signInWithCredentials(String email, String password) async {
    UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    getUser();

    return userCredential;
  }

  Future<UserCredential> signUp({required String email, required String password, required String firstName, required String lastName, String image = ''}) async {
    final UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user_model.User user = user_model.User(
      firebaseId: userCredential.user!.uid,
      firstName: firstName,
      lastName: lastName,
      email: email,
      image: image,
    );

    currentUser = await ApiService().addUser(user);

    return userCredential;
  }

  bool checkIfVerified() {
    _firebaseAuth.currentUser!.reload().then((value) => _firebaseAuth.currentUser!.emailVerified);
    return _firebaseAuth.currentUser!.emailVerified;
  }

  Future<void> sendVerificationMail() async {
    if (_firebaseAuth.currentUser != null) await _firebaseAuth.currentUser!.sendEmailVerification();
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }

  Future<bool> isSignedIn() async {
    User? _currentUser = _firebaseAuth.currentUser;
    _currentUser ??= await FirebaseAuth.instance.authStateChanges().first;
    return _currentUser != null;
  }

  String? getUser() {
    final _currentUser = _firebaseAuth.currentUser;
    if (_currentUser != null) {
      ApiService().getUserByFirebaseId(_currentUser.uid).then((value) => currentUser = value);
      return _currentUser.email;
    } else {
      return null;
    }
  }

  String getFirebaseId() {
    return _firebaseAuth.currentUser!.uid;
  }
}
