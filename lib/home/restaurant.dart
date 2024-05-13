import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:one_byte_foods/restaurant/restaurantPage.dart';

class RestaurantCard extends StatelessWidget {
  final String documentId;
  final String cuisine;
  final String name;
  final String location;
  final double ratings;
  final List imagesURL;
  const RestaurantCard(
      {required this.documentId,
      required this.cuisine,
      required this.name,
      required this.location,
      required this.ratings,
      required this.imagesURL});
  @override
  Widget build(BuildContext context) {
    print(imagesURL[0]);
    return Container(
      margin: EdgeInsets.all(20),
      child: Material(
        borderRadius: BorderRadius.circular(20),
        elevation: 4,
        child: Container(
          child: InkWell(
            enableFeedback: true,
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            onTap: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RestaurantPage(
                            dataId: documentId,
                            name: this.name,
                          )))
            },
            child:
                // child: Container(
                //     padding: EdgeInsets.all(20),
                //     decoration: BoxDecoration(
                //       color: Colors.grey[350],
                //       borderRadius: BorderRadius.circular(20),
                //     ),
                //     child:
                Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        minWidth: MediaQuery.of(context).size.width * 0.5,
                        maxHeight: MediaQuery.of(context).size.height * 0.15),
                    child: Image.network(
                      imagesURL[0],
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(this.cuisine),
                        Row(
                          children: [Icon(Icons.stars), Text("$ratings")],
                        )
                      ]),
                  Text(
                    this.name,
                  ),
                  Text(this.location),
                  // Container(
                  //   child: Column(
                  //     children: [Text("Discount Offers")],
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
