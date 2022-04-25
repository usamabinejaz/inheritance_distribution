import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:inheritance_distribution/services/dialogs.dart';
import 'package:universal_platform/universal_platform.dart';

class Auth extends ChangeNotifier {
  final _firebaseAuth = FirebaseAuth.instance;

  Future signInWithEmailAndPassword(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    notifyListeners();
  }

  Future createUserWithEmailAndPassword(String email, String password) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    notifyListeners();
  }

  Future signInWithGoogle() async {
    if(UniversalPlatform.isAndroid) {
      final googleSignIn = GoogleSignIn();
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        throw PlatformException(code: "Google Sign in Cancelled");
      }

      final googleAuth = await googleUser.authentication;

      final credentials = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _firebaseAuth.signInWithCredential(credentials);
    }else if (UniversalPlatform.isWeb){

      GoogleAuthProvider authProvider = GoogleAuthProvider();
      await _firebaseAuth.signInWithPopup(authProvider);
    }
    notifyListeners();
  }

  Future<void> signOut(context) async {
    getWaitingDialog(context: context);
    try {
      final googleSignIn = GoogleSignIn();
      await googleSignIn.disconnect();
    } catch (e) {
      _firebaseAuth.currentUser;
    } finally {
      try {
        _firebaseAuth.signOut();
      } finally {
        Navigator.pop(context);
      }
    }
  }

  Future resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
    return true;
  }
}
