import 'dart:ffi';

class Restaurants {
  String averagePrice;
  String cuisine;
  Array imageURL;
  String location;
  String name;
  int ratings;

  Restaurants(
      {required this.averagePrice,
      required this.cuisine,
      required this.imageURL,
      required this.location,
      required this.name,
      required this.ratings});

  Restaurants.fromJSON(Map<String, Object?> json)
      : this(
            averagePrice: json['averagePrice']! as String,
            cuisine: json['cuisine']! as String,
            imageURL: json['imageURL']! as Array,
            location: json['location']! as String,
            name: json['name']! as String,
            ratings: json['ratings']! as int);

  Restaurants copyWith(
      {String? averagePrice,
      String? cuisine,
      Array? imageURL,
      String? location,
      String? name,
      int? ratings}) {
    return Restaurants(
        averagePrice: averagePrice ?? this.averagePrice,
        cuisine: cuisine ?? this.cuisine,
        imageURL: imageURL ?? this.imageURL,
        location: location ?? this.location,
        name: name ?? this.name,
        ratings: ratings ?? this.ratings);
  }

  Map<String, Object?> toJSON() {
    return {
      'averagePrice': averagePrice,
      'cuisine': cuisine,
      'imageURL': imageURL,
      'location': location,
      'name': name,
      'ratings': ratings
    };
  }
}
