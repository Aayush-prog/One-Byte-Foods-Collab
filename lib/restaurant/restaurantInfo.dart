import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:one_byte_foods/services/database_service.dart';
import 'package:provider/provider.dart';

class RestaurantInfo extends StatefulWidget {
  final String id;
  final String name;
  final String location;
  final String cuisine;
  final String averagePrices;
  final double ratings;
  const RestaurantInfo(
      {required this.id,
      required this.name,
      required this.location,
      required this.cuisine,
      required this.averagePrices,
      required this.ratings});

  @override
  State<RestaurantInfo> createState() => _RestaurantInfoState();
}

class _RestaurantInfoState extends State<RestaurantInfo> {
  bool favorited = false; // Move favorited to the state class

  @override
  void initState() {
    super.initState();
    fetchData(); // Call fetchData when the widget is initialized
  }

  void fetchData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var doc = await DatabaseService().userDB(user.uid);
      if (doc != null && doc.exists) {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
        if (data != null && data.containsKey('favorites')) {
          setState(() {
            favorited = data['favorites'].contains(widget.id);
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return Container(
      padding: EdgeInsets.only(left: 10, top: 10),
      child: Column(
        children: [
          ElevatedButton(
            child:
                favorited ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
            onPressed: () {
              if (user != null) {
                if (favorited) {
                  DatabaseService().removeFromFavorites(user.uid, widget.id);
                } else {
                  DatabaseService()
                      .updateUserData(user.uid, favorites: widget.id);
                }
                setState(() {
                  favorited = !favorited;
                });
              }
            },
          ),
          SizedBox(height: 10),
          Row(children: [Icon(Icons.pin_drop), Text(widget.location)]),
          SizedBox(height: 10),
          Row(children: [Icon(Icons.restaurant), Text(widget.cuisine)]),
          SizedBox(height: 10),
          Row(children: [Icon(Icons.attach_money), Text(widget.averagePrices)]),
          SizedBox(height: 10),
          Row(children: [Icon(Icons.star), Text('${widget.ratings}')]),
        ],
      ),
    );
  }
}
