import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:one_byte_foods/nav/navigatorpage.dart';
import 'package:one_byte_foods/services/auth_service.dart';
import 'package:one_byte_foods/upload/imageUpload.dart';
import 'package:one_byte_foods/user/login.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(user?.displayName ?? ""),
        actions: [
          InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const UserLogin()));
              },
              child: const Icon(Icons.person))
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            child: InkWell(
              onTap: () {},
              child: Row(
                children: [
                  Icon(Icons.person),
                  SizedBox(width: 10),
                  Text("Personal Information"),
                  SizedBox(width: 175),
                  Icon(Icons.arrow_forward_ios)
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: InkWell(
              onTap: () {},
              child: Row(
                children: [
                  Icon(Icons.note_add),
                  SizedBox(width: 10),
                  Text("Reviews"),
                  SizedBox(width: 257),
                  Icon(Icons.arrow_forward_ios)
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: InkWell(
              onTap: () {},
              child: Row(
                children: [
                  Icon(Icons.settings),
                  SizedBox(width: 10),
                  Text("Settings"),
                  SizedBox(width: 257),
                  Icon(Icons.arrow_forward_ios)
                ],
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.all(20),
              child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => AddImage()));
                  },
                  child: Text("Uplist your restaurant!"))),
          Container(
            margin: EdgeInsets.all(20),
            child: InkWell(
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyWidget()));
              },
              child: InkWell(
                onTap: () {
                  AuthService.signOutFromGoogle();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyWidget()));
                },
                child: Row(
                  children: [
                    Icon(Icons.logout),
                    SizedBox(width: 10),
                    Text(
                      "Log Out",
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
