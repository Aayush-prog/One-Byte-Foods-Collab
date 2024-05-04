import 'dart:async';

import 'package:flutter/material.dart';
import 'package:one_byte_foods/main.dart';
import 'package:one_byte_foods/nav/navigatorpage.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  void initState() {
    super.initState();
    _navigate();
  }

  void _navigate() {
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MyWidget()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Column(
        children: [
          Image.asset("assets/images/logo.png"),
          const Text("One Byte Foods",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              )),
          const Text("Where Every Flavor Tells A Story",
              style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    ]);
  }
}
