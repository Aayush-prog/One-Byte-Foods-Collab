import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

class ImgCarousel extends StatelessWidget {
  final List imagesURL;
  const ImgCarousel({required this.imagesURL});

  @override
  Widget build(BuildContext context) {
    return FlutterCarousel(
      options: CarouselOptions(
        height: 250.0,
        showIndicator: true,
        enableInfiniteScroll: true,
        slideIndicator: CircularSlideIndicator(),
      ),
      items: imagesURL.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              child: Image.network(i),
            );
          },
        );
      }).toList(),
    );
  }
}
