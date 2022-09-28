// @dart=2.17
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:remi/pages/HomePage.dart';
import 'package:remi/pages/LogInPage.dart';
import './cdt/cdt.dart';
import 'firebase_options.dart';

import './pages/LogInPage.dart';

Widget result = LogInPage();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  result = checkSignedUser(HomePage(), LogInPage());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: result
    );
  }
}