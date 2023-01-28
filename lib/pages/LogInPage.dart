import 'dart:io';

import 'package:flutter/material.dart';
import 'package:remi/cdt/cdt.dart';
import 'package:remi/pages/HomePage.dart';

import '../platform_sizes.dart';
import 'SignUpPage.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

/// If your app get error with "PlatformException(sign_in_failed, com.google.android.gms.common.api.ApiException: 10: , null)"
/// See this links:
///   https://developers.google.com/android/guides/client-auth
///   https://stackoverflow.com/questions/54557479/flutter-and-google-sign-in-plugin-platformexceptionsign-in-failed-com-google


class _LogInPageState extends State<LogInPage> {

  @override
  Widget build(BuildContext context) {
    
    TextEditingController _UserEmailController = TextEditingController();
    TextEditingController _UserPasswordController = TextEditingController();

    // LogIn variables
    // String _email, _password;
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
                      offset: Offset(0, 4)
                    ),
                  ],
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      width: PSize.getContentInSize(false),
                      top: 20,
                      child: Text(
                        'Log-In',
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
                            MaterialPageRoute(builder: (context) => const SignUpPage())
                          ),
                        },
                        child: Text(
                          "If you don't have account - click this.",
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
                        obscureText: false, // if is password TextField I must set true
                        cursorHeight: 15,
                        cursorColor: Colors.black,
                        controller: _UserEmailController,
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
                      child: TextField(
                        obscureText: true, // if is password TextField I must set true
                        cursorHeight: 15,
                        cursorColor: Colors.black,
                        controller: _UserPasswordController,
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
                    Positioned(
                      top: 295,
                      width: 300,
                      left: (PSize.getContentInSize(false) / 2) - 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        
                        children: <Widget>[
                          ElevatedButton.icon(
                            onPressed: CDTAuth.signInWithGoogle,
                            icon: Image.asset(
                              'assets/icons/google.png',
                              height: 25,
                            ), 
                            label: Text(
                              'Google',
                              style: TextStyle(color: Colors.black),
                              ),                           
                              style: ButtonStyle(
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(36),
                                  side: BorderSide(color: Colors.black),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.white
                              ),
                              padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.fromLTRB(
                                32, 2, 32, 2
                              )),
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: CDTAuth.signInWithApple,
                            icon: Image.asset(
                              'assets/icons/appleid.png',
                              height: 25,
                            ), 
                            label: Text(
                              'Apple ID',
                              style: TextStyle(color: Colors.black),
                            ),
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(36),
                                  side: BorderSide(color: Colors.black),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.white
                              ),
                              padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.fromLTRB(
                              33, 2, 33, 2
                              )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: (PSize.getContentInSize(false) / 2) - 150,
                      child: TextButton(
                        onPressed: () {
                          CDTAuth.signInWithPassword(email: _UserEmailController.text, password: _UserPasswordController.text);
                        },
                        child: Text(
                          'Log-In',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 33,
                            color: Color.fromARGB(255, 20, 33, 61),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
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

