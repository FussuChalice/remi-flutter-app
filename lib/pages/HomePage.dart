import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // Get Screen Width
    double _ScreenWidth_ = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.deepPurple,
    );
  }
}
