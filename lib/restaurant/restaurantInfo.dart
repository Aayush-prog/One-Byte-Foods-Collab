import 'package:flutter/material.dart';
import 'package:one_byte_foods/services/database_service.dart';

class RestaurantInfo extends StatefulWidget {
  final String name;
  final String location;
  final String cuisine;
  final String averagePrices;
  final double ratings;
  const RestaurantInfo(
      {required this.name,
      required this.location,
      required this.cuisine,
      required this.averagePrices,
      required this.ratings});

  @override
  State<RestaurantInfo> createState() => _RestaurantInfoState();
}

class _RestaurantInfoState extends State<RestaurantInfo> {
  bool favorited = false;
  // Future<void> checkIfFavorite() async {
  //   final user = FirebaseAuth.instance.currentUser;

  //   if (user != null) {
  //     final userId = user.uid;
  //     final docSnapshot = await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(userId)
  //         .collection('favorites')
  //         .doc(widget.itemId)
  //         .get();

  //     if (docSnapshot.exists) {
  //       setState(() {
  //         isFavorite = true;
  //       });
  //     }
  //   }
  // }
  // @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, top: 10),
      child: Column(
        children: [
          ElevatedButton(
            child:
                favorited ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
            onPressed: () {
              setState(() {
                favorited = !favorited;
              });
            },
          ),
          SizedBox(height: 10),
          Row(children: [Icon(Icons.pin_drop), Text(this.widget.location)]),
          SizedBox(height: 10),
          Row(
            children: [Icon(Icons.restaurant), Text(this.widget.cuisine)],
          ),
          SizedBox(height: 10),
          Row(children: [
            Icon(Icons.attach_money),
            Text(this.widget.averagePrices)
          ]),
          SizedBox(height: 10),
          Row(
            children: [Icon(Icons.star), Text('${widget.ratings}')],
          )
        ],
      ),
    );
  }
}
