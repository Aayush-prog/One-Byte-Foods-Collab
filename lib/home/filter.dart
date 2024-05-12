import 'package:flutter/material.dart';
import 'package:one_byte_foods/nav/searchPage.dart';

class FilterRestaurants extends StatelessWidget {
  const FilterRestaurants({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.03,
              right: MediaQuery.of(context).size.width * 0.02),
          child: InkWell(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductSearchScreen(
                          category: "Nepali",
                        ))),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/Nepali.jpeg',
                  width: MediaQuery.of(context).size.width * 0.3,
                ),
                Text(
                  "Nepali",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.05),
                )
              ],
            ),
          ),
        ),
        Container(
          margin:
              EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.02),
          child: InkWell(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductSearchScreen(
                          category: "Indian",
                        ))),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/Nepali.jpeg',
                  width: MediaQuery.of(context).size.width * 0.3,
                ),
                Text(
                  "Indian",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.05),
                )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductSearchScreen(
                        category: "Chinese",
                      ))),
          child: Column(
            children: [
              Image.asset(
                'assets/images/Nepali.jpeg',
                width: MediaQuery.of(context).size.width * 0.3,
              ),
              Text(
                "Chinese",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05),
              )
            ],
          ),
        ),
      ],
    );
    // return Container(
    //   margin: EdgeInsets.all(15),
    //   child: InkWell(
    //     onTap: () => Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //             builder: (context) => ProductSearchScreen(
    //                   category: "Nepali",
    //                 ))),
    //     child: Column(
    //       children: [
    //         Image.asset(
    //           'assets/images/Nepali.jpeg',
    //           width: MediaQuery.of(context).size.width * 0.3,
    //         ),
    //         Text(
    //           "Nepali",
    //           style:
    //               TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05),
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }
}
