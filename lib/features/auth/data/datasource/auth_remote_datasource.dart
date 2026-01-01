import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:janu/features/auth/data/model/user_model.dart';

abstract class AuthRemoteDatasource {
  Future<UserModel> signInWithEmail(String email, String password);
  Future<UserModel> registerInWithEmail(
    String name,
    String email,
    String password,
  );
  Future<UserModel> signInWithGoogle();
  Future<UserModel?> getCurrentUser();
  Future<void> logOut();
}

class AuthRemoteDatasourceImp implements AuthRemoteDatasource {
  final FirebaseAuth _firebase = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  @override
  Future<UserModel?> getCurrentUser() async {
    final User? currentUser = _firebase.currentUser;

    if (currentUser == null) {
      return null;
    }

    return UserModel(
      id: currentUser.uid,
      email: currentUser.email ?? "",
      name: currentUser.displayName ?? "",
      photoUrl: currentUser.photoURL ?? "",
    );
  }

  @override
  Future<void> logOut() async {
    await _firebase.signOut();
  }

  @override
  Future<UserModel> registerInWithEmail(
    String name,
    String email,
    String password,
  ) async {
    
    try {
      final UserCredential userCredetial = await _firebase
        .createUserWithEmailAndPassword(email: email, password: password );

    final User? user = userCredetial.user;

      if (user == null) {
         throw FirebaseAuthException(
          code: "USER_NOT_REGISTER",
          message: "User is not registered",
        );
      }

      return UserModel(
        id: user.uid,
        email: user.email ?? "",
        name: name ,
        photoUrl: user.photoURL ?? "",
      );
    } on FirebaseAuthException {
      rethrow;
    }
  }

  @override
  Future<UserModel> signInWithEmail(String email, String password) async {
    try {
      final userCredential = await _firebase.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user == null) {
         throw FirebaseAuthException(
          code: "USER_NULL",
          message: "User is null after sign in",
        );
      }

      return UserModel(
        id: user.uid,
        email: user.email ?? "",
        name: user.displayName ?? "",
        photoUrl: user.photoURL ?? "",
      );
    } on FirebaseAuthException {
      rethrow;
    }
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    try {
      final googleAuth = await _googleSignIn.authenticate();

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.email,
        idToken: googleAuth.displayName,
      );

      final userCredential = await _firebase.signInWithCredential(credential);

      final user = userCredential.user;

      if (user == null) {
        throw FirebaseAuthException(
          code: 'USER_NULL',
          message: 'User is null after Google sign in',
        );
      }

      return UserModel(
        id: user.uid,
        email: user.email ?? '',
        name: user.displayName ?? '',
        photoUrl: user.photoURL ?? '',
      );
    } on FirebaseAuthException {
      rethrow;
    }
  }
}
