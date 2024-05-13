import 'package:flutter/material.dart';

class ImageGallery extends StatelessWidget {
  final List imagesURL;
  const ImageGallery({required this.imagesURL});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.03,
                ),
                Text(
                  "Photos based on community",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.05),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.03,
                ),
                Row(children: [
                  Image.network(
                    imagesURL[0],
                    width: MediaQuery.of(context).size.width * 0.43,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.03,
                  ),
                  Image.network(
                    imagesURL[0],
                    width: MediaQuery.of(context).size.width * 0.43,
                  ),
                ]),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.03,
                ),
                Row(children: [
                  Image.network(
                    imagesURL[0],
                    width: MediaQuery.of(context).size.width * 0.43,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.03,
                  ),
                  Image.network(
                    imagesURL[0],
                    width: MediaQuery.of(context).size.width * 0.43,
                  ),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
