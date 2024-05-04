import 'package:flutter/material.dart';

class RestaurantInfo extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, top: 10),
      child: Column(
        children: [
          Text(this.name),
          SizedBox(height: 10),
          Row(children: [Icon(Icons.pin_drop), Text(this.location)]),
          SizedBox(height: 10),
          Row(
            children: [Icon(Icons.restaurant), Text(this.cuisine)],
          ),
          SizedBox(height: 10),
          Row(children: [Icon(Icons.attach_money), Text(this.averagePrices)]),
          SizedBox(height: 10),
          Row(
            children: [Icon(Icons.star), Text('$ratings')],
          )
        ],
      ),
    );
  }
}
