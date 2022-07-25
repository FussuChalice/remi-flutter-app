import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'SignUpPage.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {

  @override
  Widget build(BuildContext context) {

    // Get screen size
    double _ScreenWidth_ = MediaQuery.of(context).size.width;

    // LogIn variables
    // String _email, _password;

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
                width: _ScreenWidth_,
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
                      width: _ScreenWidth_,
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
                      left: (_ScreenWidth_ / 2) - 80,
                      child: InkWell(
                        onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SignUpPage())
                          ),
                        },
                        child: Text(
                          "If you don't have accaunt - click this.",
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
                      left: (_ScreenWidth_ / 2) - 150,
                      child: TextField(
                        obscureText: false, // if is password TextField I must set true
                        cursorHeight: 15,
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
                      left: (_ScreenWidth_ / 2) - 150,
                      child: TextField(
                        obscureText: true, // if is password TextField I must set true
                        cursorHeight: 15,
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
                    Positioned(
                      top: 295,
                      width: 300,
                      left: (_ScreenWidth_ / 2) - 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        
                        children: <Widget>[
                          ElevatedButton.icon(
                            onPressed: () => {}, 
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
                            onPressed: () => {}, 
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
                      left: (_ScreenWidth_ / 2) - 150,
                      child: TextButton(
                        onPressed: () => {
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

