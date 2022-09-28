import 'dart:core';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';
import './cdt.dart';


/// # Authorization
/// Part of cdt library.
/// Created for quick auth with Firebase, check password and email on correct writing.
class Authorization {
  final int normalPasswordLength = 8;
  bool AppleIDAccess = false;

  BuildContext _context;

  Widget _SAP;


  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Get BuildContext for correct logging to user screen
  /// SAP (Secret Authorize Page)
  Authorization(BuildContext this._context, Widget this._SAP);


  /// # Check [password] resemblance with [confirm password].
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

  /// # Check length of [password].
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

  /// # Email validation
  bool emailValidation(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  // Work with [FirebaseAuth]
  // Creating account

  /// # Create account with user password and email.
  void createUserByPassword(
      {required String email, required String password}) {

    try {

      _auth.createUserWithEmailAndPassword(email: email, password: password).then((value) => {
        Navigator.push(this._context, MaterialPageRoute(builder: (context) => this._SAP))
      });
    } on FirebaseAuthException catch (e) {
      // Segment of code saved from https://firebase.google.com/docs/auth/flutter/password-auth
      // But commented print() functions.

      if (e.code == 'weak-password') {
        // print('The password provided is too weak.');
        displayOnScreen(Text('The password provided is too weak.'), this._context);
      } else if (e.code == 'email-already-in-use') {
        // print('The account already exists for that email.');
        displayOnScreen(Text(
            'The account already exists for that email.'), this._context);
      }
    } catch (e) {
    }

  }

  /// # CREATE USER WITH GOOGLE
  Future<UserCredential> createUserWithGoogle() async {
    try {
      // Trigger the auth flow
      final GoogleSignInAccount? _googleAccount = await _googleSignIn.signIn();
      // Obtain the auth details from the request
      final GoogleSignInAuthentication? _googleAuth = await _googleAccount?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: _googleAuth?.accessToken,
        idToken: _googleAuth?.idToken,
      );

      // Once SEND TO FIREBASE
      final createdUser = await _auth.signInWithCredential(credential);

      // Go to secret page
      Navigator.push(this._context,
          MaterialPageRoute(builder: (context) => this._SAP)
      );

      return createdUser;
    } catch (e) {
      displayOnScreen(Text(e.toString()), this._context);
      throw PlatformException(code: e.toString());
    }
  }


  /// # CREATE USER WITH APPLE
  /// Work's on Apple devices <br />
  /// More information <br />
  /// [https://pub.dev/packages/the_apple_sign_in/](https://pub.dev/packages/the_apple_sign_in/) <br />
  /// [https://github.com/tomgilder/flutter_apple_sign_in/issues/10](https://github.com/tomgilder/flutter_apple_sign_in/issues/10) <br />
  ///
  ///   Add ```the_apple_sign_in, firebase_auth_oauth``` to pubspec.yaml
  Future<UserCredential> createUserWithApple() async {
    // check available of apple sign-in
    if (!await TheAppleSignIn.isAvailable()) {
      displayOnScreen(Text('Not available apple sign-in. Use Apple devices'), this._context);
      throw PlatformException(code: 'NOT_AVAILABLE_APPLE_SIGN_IN');
    } else {
      try {

        final AuthorizationResult result = await TheAppleSignIn.performRequests([
            AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
        ]);

        switch (result.status) {
          case AuthorizationStatus.authorized:
            final appleIdCredential = result.credential!;
            final oAuthProvider = OAuthProvider('apple.com');
            final credential = oAuthProvider.credential(
              idToken: String.fromCharCodes(appleIdCredential.identityToken!),
              accessToken: String.fromCharCodes(appleIdCredential.authorizationCode!),
            );



            final createdUser = await _auth.signInWithCredential(credential);

            Navigator.push(this._context, MaterialPageRoute(builder: (context) => this._SAP));
            return createdUser;

          case AuthorizationStatus.error:
            throw PlatformException(
              code: 'ERROR_AUTHORIZATION_DENIED',
              message: result.error.toString(),
            );

          case AuthorizationStatus.cancelled:
            throw PlatformException(
              code: 'ERROR_ABORTED_BY_USER',
              message: 'Sign in aborted by user',
            );

          default:
            throw UnimplementedError();
        }

      } catch (e) {
        debugLog(CDTColors.Red, e.toString());
        throw PlatformException(code: e.toString());
      }

    }
  }

  // Post how add Facebook auth: https://daniasblog.com/flutter-facebook-authentication-with-firebase/

  /// SIGN IN WITH PASSWORD AND EMAIL
  Future<void> signInWithPassword({
    required String email,
    required String password
  }) async {

    try {

      final credentials = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      // Go to secret page
      Navigator.push(this._context, MaterialPageRoute(builder: (content) => this._SAP));

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // print('No user found for that email.');
        displayOnScreen(Text('No user found for that email.'), this._context);
      } else if (e.code == 'wrong-password') {
        // print('Wrong password provided for that user.');
        displayOnScreen(Text('Wrong password provided for that user.'), this._context);
      }
    }

  }

  Future<UserCredential> signInWithGoogle() async {
    try {
      // Trigger the auth flow
      final GoogleSignInAccount? _googleAccount = await _googleSignIn.signIn();
      // Obtain the auth details from the request
      final GoogleSignInAuthentication? _googleAuth = await _googleAccount?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: _googleAuth?.accessToken,
        idToken: _googleAuth?.idToken,
      );

      // Once SEND TO FIREBASE
      final signedUser = await _auth.signInWithCredential(credential);

      debugLog(CDTColors.Yellow, 'Next push');

      // Go to secret page
      Navigator.push(this._context, MaterialPageRoute(builder: (context) => this._SAP));

      return signedUser;

    } catch (e) {
      throw PlatformException(code: e.toString());
    }
  }

  // for signOut
  Future<void> googleSignOut() => _googleSignIn.disconnect();

  Future<UserCredential> signInWithApple() async {
    // check available of apple sign-in
    if (!await TheAppleSignIn.isAvailable()) {
      displayOnScreen(Text('Not available apple sign-in. Use Apple devices'), this._context);
      throw PlatformException(code: 'NOT_AVAILABLE_APPLE_SIGN_IN');
    } else {
      try {

        final AuthorizationResult result = await TheAppleSignIn.performRequests([
          AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
        ]);

        switch (result.status) {
          case AuthorizationStatus.authorized:
            final appleIdCredential = result.credential!;
            final oAuthProvider = OAuthProvider('apple.com');
            final credential = oAuthProvider.credential(
              idToken: String.fromCharCodes(appleIdCredential.identityToken!),
              accessToken: String.fromCharCodes(appleIdCredential.authorizationCode!),
            );

            final signedUser = await _auth.signInWithCredential(credential);

            Navigator.push(this._context, MaterialPageRoute(builder: (context) => this._SAP));
            return signedUser;

          case AuthorizationStatus.error:
            throw PlatformException(
              code: 'ERROR_AUTHORIZATION_DENIED',
              message: result.error.toString(),
            );

          case AuthorizationStatus.cancelled:
            throw PlatformException(
              code: 'ERROR_ABORTED_BY_USER',
              message: 'Sign in aborted by user',
            );

          default:
            throw UnimplementedError();
        }

      } catch (e) {
        debugLog(CDTColors.Red, e.toString());
        throw PlatformException(code: e.toString());
      }

    }
  }


}

Widget checkSignedUser(Widget Home, Widget LogIn) {
  User? currentUser = FirebaseAuth.instance.currentUser;

  if (currentUser != null) {

    debugLog(CDTColors.Black, currentUser.uid);
    return Home;

  } else {
    return LogIn;
  }
}
