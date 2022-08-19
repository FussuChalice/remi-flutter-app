import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:remi/cdt/font_settings.dart';
import 'package:remi/cdt/user_print.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';



/// # Authorization
/// Part of cdt library.
/// Created for quick auth with Firebase, check password and email on correct writing.
class Authorization {
  final int normalPasswordLength = 8;
  bool AppleIDAccess = false;

  BuildContext _context;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Get BuildContext for correct logging to user screen
  Authorization(BuildContext this._context);


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

  // Future<User> signInWithApple({List<Scope> scopes = const []}) async {
  //   // perform the sign-in request
  //   final result = await TheAppleSignIn.performRequests([AppleIdRequest(requestedScopes: scopes)]);
  //
  //   // check the result
  //   switch (result.status) {
  //     case AuthorizationStatus.authorized:
  //       final appleIDCredential = result.credential!;
  //       final oAuthProvider = OAuthProvider('apple.com');
  //       final credential = oAuthProvider.credential(
  //         idToken: String.fromCharCodes(appleIDCredential.identityToken!),
  //         accessToken:
  //           String.fromCharCodes(appleIDCredential.authorizationCode!),
  //       );
  //
  //       final userCredential = await _auth.signInWithCredential(credential);
  //       final firebaseUser = userCredential.user!;
  //       if (scopes.contains(Scope.fullName)) {
  //         final userFullName = appleIDCredential.fullName;
  //         if (userFullName != null && userFullName.givenName != null && userFullName.familyName != null) {
  //           final displayName = '${userFullName.givenName} ${userFullName.familyName}';
  //
  //           await firebaseUser.updateDisplayName(displayName);
  //         }
  //       }
  //       return firebaseUser;
  //
  //     case AuthorizationStatus.error:
  //       displayOnScreen(Text(result.error.toString()), this._context);
  //       throw PlatformException(
  //         code: 'ERROR_AUTHORIZATION_DENIED',
  //         message: result.error.toString(),
  //       );
  //
  //     case AuthorizationStatus.cancelled:
  //       displayOnScreen(Text('Sign in aborted by user'), this._context);
  //       throw PlatformException(
  //         code: 'ERROR_ABORTED_BY_USER',
  //         message: 'Sign in aborted by user',
  //       );
  //
  //     default:
  //       throw UnimplementedError();
  //   }
  // }

  // More information: https://pub.dev/packages/the_apple_sign_in
  // https://github.com/tomgilder/flutter_apple_sign_in/issues/10
  Future<UserCredential> signInWithApple() async {
    // check available of apple sign-in
    if (!await TheAppleSignIn.isAvailable()) {
      displayOnScreen(Text('Not available apple sign-in. Use IPhone'), this._context);
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

            return await _auth.signInWithCredential(credential);

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
