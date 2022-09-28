import 'package:flutter/material.dart';
import 'package:remi/cdt/cdt.dart';
import 'dart:io';

import 'LogInPage.dart';
import '../platform_sizes.dart';
import 'HomePage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {

    // For create account
    TextEditingController _UserEmailController = TextEditingController();
    TextEditingController _UserPasswordController = TextEditingController();
    TextEditingController _UserConfirmPasswordController =
        TextEditingController();

    // Create CDTAuth OBJ
    Authorization CDTAuth = Authorization(context, HomePage());
    
    // Init Sizes by platform
    PlatformSizes PSize = PlatformSizes(Platform.operatingSystem, context);
    PSize.initScreenSize();

    return Scaffold(
      backgroundColor: Color.fromARGB(251, 251, 251, 251),
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            top: 65,
            child: Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                'assets/images/logo.png',
                width: 130,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: PSize.getContentInSize(false),
              height: 450,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(38),
                  topRight: Radius.circular(38),
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Color.fromARGB(28, 0, 0, 0),
                      spreadRadius: 0,
                      blurRadius: 82,
                      offset: Offset(0, 4)),
                ],
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    width: PSize.getContentInSize(false),
                    top: 20,
                    child: Text(
                      'Sign-Up',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 20, 33, 61),
                        fontSize: 50,
                      ),
                    ),
                  ),
                  Positioned(
                    width: 160,
                    top: 90,
                    left: (PSize.getContentInSize(false) / 2) - 80,
                    child: InkWell(
                      onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LogInPage())),
                      },
                      child: Text(
                        "If you have account - click this.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    width: 300,
                    top: 130,
                    left: (PSize.getContentInSize(false) / 2) - 150,
                    child: TextField(
                      obscureText:
                          false, // if is password TextField I must set true
                      cursorHeight: 15,
                      controller: _UserEmailController,
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 20,
                        ),
                        focusColor: Colors.black,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    width: 300,
                    top: 219,
                    left: (PSize.getContentInSize(false) / 2) - 150,
                    child: Row(children: <Widget>[
                      Flexible(
                        child: TextField(
                          obscureText:
                              true, // if is password TextField I must set true
                          cursorHeight: 15,
                          controller: _UserPasswordController,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 20,
                            ),
                            focusColor: Colors.black,
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: TextField(
                          obscureText:
                              true, // if is password TextField I must set true
                          cursorHeight: 15,
                          controller: _UserConfirmPasswordController,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            labelText: 'Confirm',
                            labelStyle: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 20,
                            ),
                            focusColor: Colors.black,
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                  Positioned(
                    top: 295,
                    width: 300,
                    left: (PSize.getContentInSize(false) / 2) - 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        ElevatedButton.icon(
                          onPressed: CDTAuth.createUserWithGoogle,
                          icon: Image.asset(
                            'assets/icons/google.png',
                            height: 25,
                          ),
                          label: Text(
                            'Google',
                            style: TextStyle(color: Colors.black),
                          ),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(36),
                                side: BorderSide(color: Colors.black),
                              ),
                            ),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.fromLTRB(32, 2, 32, 2)),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: CDTAuth.createUserWithApple,
                          icon: Image.asset(
                            'assets/icons/appleid.png',
                            height: 25,
                          ),
                          label: Text(
                            'Apple ID',
                            style: TextStyle(color: Colors.black),
                          ),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(36),
                                side: BorderSide(color: Colors.black),
                              ),
                            ),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.fromLTRB(33, 2, 33, 2)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: (PSize.getContentInSize(false)/ 2) - 150,
                    child: TextButton(
                      onPressed: () {
                        debugLog(CDTColors.Cyan,
                            "${CDTStyle.Italic}${CDTColors.White}Email: ${_UserEmailController.text},\n${CDTStyle.Italic}${CDTColors.White}Password: ${_UserPasswordController.text},\n${CDTStyle.Italic}${CDTColors.White}ConfigPassword: ${_UserConfirmPasswordController.text}${CDTStyle.Close}${CDTColors.Reset}");

                        int MistakeCount = 0;

                        // Email validating
                        if (!CDTAuth.emailValidation(
                            _UserEmailController.text)) {
                          debugLog(CDTColors.Red,
                              "${CDTColors.Red}Email validation is fail!${CDTColors.Reset}");
                          displayOnScreen(Text('Email entered incorrectly'), context);
                          MistakeCount++;
                        }

                        // Check password length
                        if (!CDTAuth.isNormalPasswordLength(
                            _UserPasswordController.text)) {
                          debugLog(CDTColors.Red,
                              "${CDTColors.Red}Password < NormalLength int(8) ${CDTColors.Reset}");
                          displayOnScreen(Text('Password is too short! The minimum length is 8 characters.'), context);
                          MistakeCount++;
                        }

                        // Check password resemblance with confirm_password
                        if (!CDTAuth.checkPasswordResemblance(
                            password: _UserPasswordController.text,
                            confirmPassword:
                                _UserConfirmPasswordController.text)) {
                          print('password not resemblance');
                          displayOnScreen(Text('Passwords are different! Retype'), context);
                          MistakeCount++;
                        }

                        if (MistakeCount == 0) {
                          // create user
                          CDTAuth.createUserByPassword(
                              email: _UserEmailController.text,
                              password: _UserPasswordController.text
                          );

                        } else {
                          debugLog(CDTColors.Red,
                              '${CDTColors.Red}MistakeCount > 0 ${CDTColors.Reset}');
                        }
                      },
                      child: Text(
                        'Sign-Up',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 33,
                          color: Color.fromARGB(255, 20, 33, 61),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        primary: Color(0xFFFCA311),
                        minimumSize: Size(300, 72),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
