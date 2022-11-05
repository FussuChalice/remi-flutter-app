import 'dart:io';

import 'package:flutter/material.dart';

import '../main.dart';
import '../platform_sizes.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    PlatformSizes PSize = PlatformSizes(Platform.operatingSystem, context);
    PSize.initScreenSize();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[

          // bg
          Positioned(
            left: PSize.ScreenWidth() / 2 - ((PSize.ScreenWidth() / 1.5) / 2),
            top: 100,
              child: Container(
                width: PSize.ScreenWidth() / 1.5,
                height: PSize.ScreenHeight() / 1.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(PSize.ScreenWidth() / 2),
                  color: Color(0xFFFCA311),
                ),
              ),
          ),
          Positioned(
            top: 180,
            left: PSize.ScreenWidth() / 2 - ((PSize.ScreenWidth() / 2.5) / 2),
            child: Container(
              width: PSize.ScreenWidth() / 2.5,
              height: PSize.ScreenHeight() / 1.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(PSize.ScreenWidth() / 2),
                color: Color(0xFFFFB63E),
              ),
            ),
          ),

          // box with "sorry" text
          Positioned(
              top: PSize.ScreenHeight() / 2.2,
              left: PSize.ScreenWidth() / 2 - ((PSize.ScreenWidth() / 1.3) / 2),
              child: Container(
                width: PSize.ScreenWidth() / 1.3,
                height: 240,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(25, 0, 0, 0),
                        spreadRadius: 0,
                        blurRadius: 24,
                        offset: Offset(0, 4)
                    ),
                  ],
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      width: PSize.ScreenWidth() / 1.3,
                        top: 65,
                        child: Text(
                            "Whoops! No internet connection!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 26,
                          ),
                        ),
                    ),
                    Positioned(
                        height: 70,
                        left: PSize.ScreenWidth() / 2 - ((PSize.ScreenWidth() / 1.23) / 2),
                        bottom: 25,
                        width: PSize.ScreenWidth() / 1.7,
                        child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 20, 33, 61),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular((PSize.ScreenWidth() / 1.7) / 2),
                              ),
                            ),
                            onPressed: () => {main()},
                            child: Text(
                                "Try again",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                              ),
                            ),
                          ),
                        ),
                  ],
                ),
              )
          ),

          // image
          Positioned(
              top: PSize.ScreenWidth() / 1.5,
              left: PSize.ScreenWidth() / 2 - ((PSize.ScreenWidth() / 2.4) / 2),
              child: Image.asset(
                'assets/images/nicse.png',
                width: PSize.ScreenWidth() / 2.4,
              ),
          ),
        ],
      ),
    );
  }
}
