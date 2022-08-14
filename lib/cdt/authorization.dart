import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:google_sign_in/google_sign_in.dart';


/// # Authorization
/// Part of cdt library.
/// Created for quick auth with Firebase, check password and email on correct writing.
class Authorization {
  final int normalPasswordLength = 8;
  // bool _GoogleSignInCatcher = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();


  /// Check [password] resemblance with [confirm password].
  ///
  /// Returned:
  ///   - false = error
  ///   - true  = ok
  bool checkPasswordResemblance(
      {required String password, required String confirmPassword}) {
    bool fResp = false;
    password == confirmPassword && password.length == confirmPassword.length ? fResp = true : fResp = false;

    return fResp;
  }

  /// Check length of [password].
  ///
  /// Returned:
  ///   - false = error
  ///   - true  = ok
  bool isNormalPasswordLength(String password) {
    bool fResp = true;

    int passwordLength = password.length;

    passwordLength >= this.normalPasswordLength ? fResp = true : fResp = false;

    return fResp;
  }

  /// Email validation
  bool emailValidation(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  // Work with [FirebaseAuth]
  // Creating account

  /// Create account with user password and email.
  List<String> createAccountByPassword(
      {required String email, required String password}) {
    List<String> errList = [];

    try {
      _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      // Segment of code saved from https://firebase.google.com/docs/auth/flutter/password-auth
      // But commented print() functions.

      if (e.code == 'weak-password') {
        // print('The password provided is too weak.');
        errList.add('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        // print('The account already exists for that email.');
        errList.add('The account already exists for that email.');
      }
    } catch (e) {
      errList.add(e.toString());
    }

    return errList;
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the auth flow
    final GoogleSignInAccount? _googleAccount = await _googleSignIn.signIn();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? _googleAuth = await _googleAccount?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: _googleAuth?.accessToken,
      idToken: _googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await _auth.signInWithCredential(credential);
  }

  // for signOut
  Future<void> googleSignOut() => _googleSignIn.disconnect();
}
