import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:remi/cdt/font_settings.dart';
import 'package:remi/cdt/user_print.dart';

/// # Authorization
/// Part of cdt library.
/// Created for quick auth with Firebase, check password and email on correct writing.
class Authorization {
  final int normalPasswordLength = 8;

  /// Check [password] resemblance with [confirm password].
  ///
  /// Returned:
  ///   - false = error
  ///   - true  = ok
  bool checkPasswordResemblance(
      {required String password, required String confirmPassword}) {
    bool fResp = false;
    password == confirmPassword ? fResp = true : fResp = false;

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
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
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

  // Code get from https://pub.dev/packages/google_sign_in and
  // https://github.com/flutter/plugins/blob/main/packages/google_sign_in/google_sign_in/example/lib/main.dart
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly'
  ]);

  /// Sign In with Google
  Future handleSignIn() async {
    try {
      await this._googleSignIn.signIn();
    } catch (error) {
      debugLog(CDTColors.Red, error.toString());
    }
  }
}
