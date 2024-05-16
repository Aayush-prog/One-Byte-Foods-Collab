import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:one_byte_foods/home/restaurant.dart';
import 'package:one_byte_foods/services/database_service.dart';
import 'package:one_byte_foods/user/login.dart';
import 'package:one_byte_foods/user/userProfile.dart';
import 'package:provider/provider.dart';

class ReservedPage extends StatefulWidget {
  const ReservedPage({super.key});

  @override
  State<ReservedPage> createState() => _ReservedPageState();
}

class _ReservedPageState extends State<ReservedPage> {
  Future<List<Map<String, dynamic>>> fetchRestaurantData(
      List reservedDocumentIds) async {
    List<Map<String, dynamic>> restaurantDataList = [];

    // Iterate through each reserved document ID
    for (String docId in reservedDocumentIds) {
      print(docId);
      // Query the orders collection using document ID
      DocumentSnapshot orderSnapshot = await FirebaseFirestore.instance
          .collection('orders')
          .doc(docId)
          .get();

      if (orderSnapshot.exists) {
        // Extract the restaurant ID from the order document
        String restaurantId = orderSnapshot[
            'resId']; // Assuming 'restaurant_id' is the field in the order document that contains the restaurant ID

        // Query the restaurants collection using the extracted restaurant ID
        DocumentSnapshot restaurantSnapshot = await FirebaseFirestore.instance
            .collection('restaurants')
            .doc(restaurantId)
            .get();

        if (restaurantSnapshot.exists) {
          // Extract restaurant data and add it to the list
          Map<String, dynamic> restaurantData =
              restaurantSnapshot.data() as Map<String, dynamic>;
          restaurantData['documentId'] = restaurantSnapshot.id;
          restaurantDataList.add(restaurantData);
        }
      }
    }

    print(restaurantDataList);
    return restaurantDataList;
  }

  @override
  Widget build(BuildContext context) {
    final _dbService = DatabaseService();
    final user = Provider.of<User?>(context);
    if (user == null) {
      return UserLogin();
    }
    final String uid = user.uid;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Reservations"),
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
          children: [
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.9,
              child: FutureBuilder<DocumentSnapshot>(
                future: _dbService.userDB(uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  }
                  Map<String, dynamic>? data =
                      snapshot.data!.data() as Map<String, dynamic>;

                  if (data.containsKey('reserved')) {
                    List reservedDocumentIds = snapshot.data!['reserved'];
                    print("printing reserves");
                    print(reservedDocumentIds);
                    return FutureBuilder(
                        future: fetchRestaurantData(reservedDocumentIds),
                        builder: (context,
                            AsyncSnapshot<List<Map<String, dynamic>>>
                                restaurantSnapshot) {
                          if (restaurantSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (restaurantSnapshot.hasError) {
                            return Center(
                              child: Text('Error: ${restaurantSnapshot.error}'),
                            );
                          }
                          return ListView.builder(
                              itemCount: restaurantSnapshot.data!.length,
                              itemBuilder: ((context, index) {
                                var restaurantData =
                                    restaurantSnapshot.data![index];
                                return Dismissible(
                                  background: Container(
                                    color: Colors.red,
                                    child: Icon(Icons.delete),
                                  ),
                                  key:
                                      ValueKey(restaurantSnapshot.data![index]),
                                  onDismissed: (DismissDirection direction) {
                                    setState(() {});
                                  },
                                  child: RestaurantCard(
                                      documentId: restaurantData['documentId'],
                                      cuisine: restaurantData['cuisine'],
                                      name: restaurantData['name'],
                                      location: restaurantData['location'],
                                      ratings: restaurantData['ratings'],
                                      imagesURL: restaurantData['imagesURL']),
                                );
                              }));
                        });
                  }
                  return Center(
                    child: Text(
                        "Reserve your first restaurant to show reservation history!"),
                  );
                },
              ),
            )
          ],
        ));
  }
}
