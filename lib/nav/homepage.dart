import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:one_byte_foods/home/filter.dart';
import 'package:one_byte_foods/home/luxury.dart';
import 'package:one_byte_foods/home/offers.dart';
import 'package:one_byte_foods/home/restaurant.dart';
import 'package:one_byte_foods/home/search.dart';
import 'package:one_byte_foods/models/restaurants.dart';
import 'package:one_byte_foods/services/database_service.dart';
import 'package:one_byte_foods/user/login.dart';
import 'package:one_byte_foods/user/userProfile.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    print(user?.uid);
    final _dbService = DatabaseService();
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          // title: Location(),
          actions: [
            InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    if (user?.uid != null) {
                      return UserProfile();
                    } else {
                      return UserLogin();
                    }
                  }));
                },
                child: const Icon(Icons.person))
          ],
        ),
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            // Container(
            //   margin: const EdgeInsets.symmetric(horizontal: 60),
            //   child: Search(),
            // ),
            Container(
                margin: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.width * 0.05),
                child: FilterRestaurants()),
            const Padding(
              padding: EdgeInsets.only(left: 15),
              child: Row(children: [
                Text(
                  "Restaurant near you",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                ),
              ]),
            ),
            SizedBox(
              height: 300,
              child: StreamBuilder<QuerySnapshot>(
                stream: _dbService.getRestaurants(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  }

                  List data = snapshot.data?.docs ?? [];
                  print(data.length);
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final document = data[index];
                      Restaurants item = document.data();
                      final documentId = document.reference.id;
                      print(item.name);

                      return RestaurantCard(
                        documentId: documentId,
                        cuisine: item.cuisine,
                        name: item.name,
                        location: item.location,
                        ratings: item.ratings,
                        imagesURL: item.imagesURL,
                      );
                    },
                  );
                },
              ),
            ),
            const Offers(),
            Container(
              margin: const EdgeInsets.only(top: 15),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text("Need a table now??",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 23)),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        // RestaurantCard(),
                        // RestaurantCard(),
                        // RestaurantCard(),
                        // RestaurantCard(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const LuxuryExp(),
          ],
        ));
  }
}
