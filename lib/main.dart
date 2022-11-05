// @dart=2.17
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:remi/pages/HomePage.dart';
import 'package:remi/pages/LogInPage.dart';
import 'package:remi/pages/NoInternet.dart';
import './cdt/cdt.dart';
import 'firebase_options.dart';

import './pages/LogInPage.dart';

Widget result = NoInternet();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (await checkEthernetConnectivity()) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    result = checkSignedUser(HomePage(), LogInPage());
  } else {
    result = NoInternet();
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light
    ));
    return MaterialApp(
      home: result
    );
  }
}