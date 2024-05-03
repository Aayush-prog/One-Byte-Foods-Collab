import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:one_byte_foods/models/restaurants.dart';

const String RESTAURANTS_COLLECTION_REF = "restaurants";

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final CollectionReference<Restaurants> _restaurantsRef;

  DatabaseService() {
    _restaurantsRef = _firestore
        .collection(RESTAURANTS_COLLECTION_REF)
        .withConverter<Restaurants>(
          fromFirestore: (snapshot, _) =>
              Restaurants.fromJSON(snapshot.data()!),
          toFirestore: (restaurants, _) => restaurants.toJSON(),
        );
  }

  Stream<List<Restaurants>> getRestaurants() {
    return _restaurantsRef.snapshots().map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => doc.data(),
              )
              .toList(),
        );
  }

  Future<void> addRestaurants(Restaurants restaurant) async {
    try {
      await _restaurantsRef.add(restaurant);
    } catch (e) {
      print("Error adding restaurant: $e");
      throw e; // Rethrow the error to handle it in the UI or other layers
    }
  }
}
