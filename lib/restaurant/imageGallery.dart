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
                Text("Photos based on community"),
                Row(children: [
                  Image.network(
                    imagesURL[0],
                    width: 180,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Image.network(
                    imagesURL[0],
                    width: 180,
                  ),
                ]),
                SizedBox(height: 15),
                Row(children: [
                  Image.network(
                    imagesURL[0],
                    width: 180,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Image.network(
                    imagesURL[0],
                    width: 180,
                  ),
                ]),
              ],
            ),
          ),
          ElevatedButton(onPressed: () {}, child: Text("See more photos")),
        ],
      ),
    );
  }
}
