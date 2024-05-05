import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:one_byte_foods/home/search.dart';
import 'package:one_byte_foods/nav/landingpage.dart';
import 'package:one_byte_foods/nav/navigatorpage.dart';
import 'package:one_byte_foods/restaurant/restaurantPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:one_byte_foods/services/auth_service.dart';
import 'package:provider/provider.dart';
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
    return StreamProvider<User?>.value(
      initialData: null,
      value: AuthService().getUser(),
      child: MaterialApp(
        home: Scaffold(body: Center(child: LandingPage())),
        // bottomNavigationBar: Nav(),
      ),
    );
  }
}
