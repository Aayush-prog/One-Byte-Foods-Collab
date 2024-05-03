import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:one_byte_foods/models/restuarants.dart';

const String RESTAURANTS_COLLECTION_REF = "restaurants";

class DatabaseService {
  final _firestore = FirebaseFirestore.instance;
  late final CollectionReference _restaurantsRef;
  DatabaseService() {
    _restaurantsRef = _firestore
        .collection(RESTAURANTS_COLLECTION_REF)
        .withConverter<Restaurants>(
            fromFirestore: (Snapshots, _) =>
                Restaurants.fromJSON(Snapshots.data()!),
            toFirestore: (restaurants, _) => restaurants.toJSON());
  }

  Stream<QuerySnapshot> getRestaurants() {
    return _restaurantsRef.snapshots();
  }

  void addRestaurants(Restaurants restaurant) async {
    _restaurantsRef.add(restaurant);
  }
}
