import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:one_byte_foods/home/offers.dart';
import 'package:one_byte_foods/models/restaurants.dart';
import 'package:one_byte_foods/restaurant/booking.dart';
import 'package:one_byte_foods/restaurant/caraousel.dart';
import 'package:one_byte_foods/restaurant/imageGallery.dart';
import 'package:one_byte_foods/restaurant/menu.dart';
import 'package:one_byte_foods/restaurant/restaurantInfo.dart';
import 'package:one_byte_foods/restaurant/reviews.dart';
import 'package:one_byte_foods/services/database_service.dart';
import 'package:one_byte_foods/user/login.dart';

class RestaurantPage extends StatelessWidget {
  final String dataId;
  const RestaurantPage({required this.dataId});

  @override
  Widget build(BuildContext context) {
    final _dbService = DatabaseService();

    Future<DocumentSnapshot> _getDocument(String documentId) async {
      final firestore = FirebaseFirestore.instance;
      final docRef = firestore.collection('restaurants').doc(documentId);
      final snapshot = await docRef.get();

      return snapshot;
    }

    Future<DocumentSnapshot>? _documentSnapshot = _getDocument(dataId);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Restaurant Name"),
          actions: [
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UserLogin()));
                },
                child: const Icon(Icons.person))
          ],
        ),
        body: FutureBuilder(
            future: _documentSnapshot,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              }
              Map<String, dynamic> res =
                  snapshot.data!.data() as Map<String, dynamic>;
              return ListView(
                children: [
                  ImgCarousel(),
                  RestaurantInfo(
                      name: res['name'],
                      location: res['location'],
                      cuisine: res['cuisine'],
                      averagePrices: res['averagePrice'],
                      ratings: res['ratings']),
                  Booking(),
                  Offers(),
                  Menu(),
                  ImageGallery(),
                  Reviews(),
                ],
              );
            }));
  }
}
