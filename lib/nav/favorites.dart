import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:one_byte_foods/home/restaurant.dart';
import 'package:one_byte_foods/services/database_service.dart';
import 'package:one_byte_foods/user/login.dart';
import 'package:provider/provider.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    Future<List<Map<String, dynamic>>> fetchRestaurantData(
        List favoritedDocumentIds) async {
      List<Map<String, dynamic>> restaurantDataList = [];

      // Iterate through each reserved document ID
      for (String docId in favoritedDocumentIds) {
        print(docId);

        DocumentSnapshot restaurantSnapshot = await FirebaseFirestore.instance
            .collection('restaurants')
            .doc(docId)
            .get();

        if (restaurantSnapshot.exists) {
          // Extract restaurant data and add it to the list
          Map<String, dynamic> restaurantData =
              restaurantSnapshot.data() as Map<String, dynamic>;
          restaurantData['documentId'] = restaurantSnapshot.id;
          restaurantDataList.add(restaurantData);
        }
      }
      print(restaurantDataList);
      return restaurantDataList;
    }

    final _dbService = DatabaseService();
    final user = Provider.of<User?>(context);
    if (user == null) {
      return UserLogin();
    }
    final String uid = user.uid;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Favorites"),
        actions: [
          InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const UserLogin()));
              },
              child: const Icon(Icons.person))
        ],
      ),
      body: ListView(children: [
        SizedBox(
            width: double.infinity,
            height: 600,
            child: FutureBuilder(
                future: _dbService.userDB(uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  }
                  Map<String, dynamic>? data =
                      snapshot.data!.data() as Map<String, dynamic>;

                  if (data.containsKey('favorites')) {
                    List favoritedDocumentIds = snapshot.data!['favorites'];
                    print("printing favorites");
                    print(favoritedDocumentIds);
                    return FutureBuilder(
                        future: fetchRestaurantData(favoritedDocumentIds),
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
                                print(restaurantSnapshot.data![index]);
                                return Dismissible(
                                  background: Container(
                                    color: Colors.red,
                                    child: Icon(Icons.delete),
                                  ),
                                  key:
                                      ValueKey(restaurantSnapshot.data![index]),
                                  onDismissed: (DismissDirection direction) {
                                    DatabaseService().removeFromFavorites(
                                        user.uid, restaurantData['documentId']);
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
                    child: Text("Favorite your first restaurant to show!"),
                  );
                }))
        // RestaurantCard(),
        // RestaurantCard(),
        // RestaurantCard(),
        // RestaurantCard(),
        // RestaurantCard(),
      ]),
    );
  }
}
