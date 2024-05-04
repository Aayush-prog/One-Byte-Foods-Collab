import 'dart:ffi';

class Restaurants {
  String averagePrice;
  String cuisine;
  List imagesURL;
  String location;
  String name;
  double ratings;

  Restaurants(
      {required this.averagePrice,
      required this.cuisine,
      required this.imagesURL,
      required this.location,
      required this.name,
      required this.ratings});

  Restaurants.fromJSON(Map<String, Object?> json)
      : this(
            averagePrice: json['averagePrice']! as String,
            cuisine: json['cuisine']! as String,
            imagesURL: json['imagesURL']! as List,
            location: json['location']! as String,
            name: json['name']! as String,
            ratings: json['ratings']! as double);

  Restaurants copyWith(
      {String? averagePrice,
      String? cuisine,
      List? imagesURL,
      String? location,
      String? name,
      double? ratings}) {
    return Restaurants(
        averagePrice: averagePrice ?? this.averagePrice,
        cuisine: cuisine ?? this.cuisine,
        imagesURL: imagesURL ?? this.imagesURL,
        location: location ?? this.location,
        name: name ?? this.name,
        ratings: ratings ?? this.ratings);
  }

  Map<String, Object?> toJSON() {
    return {
      'averagePrice': averagePrice,
      'cuisine': cuisine,
      'imagesURL': imagesURL,
      'location': location,
      'name': name,
      'ratings': ratings
    };
  }
}
