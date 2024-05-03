import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:one_byte_foods/home/search.dart';
import 'package:one_byte_foods/nav/landingpage.dart';
import 'package:one_byte_foods/restaurant/restaurantPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //caching enabled
  FirebaseFirestore.instance.settings =
      const Settings(persistenceEnabled: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: ListView(
          padding: const EdgeInsets.only(top: 30),
          // height: double.infinity,
          // width: double.infinity,
          // decoration: const BoxDecoration(
          //   color: Colors.white,
          // ),
          children: [
            // UserLogin(),
            LandingPage(),
            // Home(),
            // RestaurantPage(),
          ]),
      // bottomNavigationBar: Nav(),
    ));
  }
}
