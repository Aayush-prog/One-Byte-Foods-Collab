import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:one_byte_foods/models/orders.dart';
import 'package:one_byte_foods/models/restaurants.dart';

const String RESTAURANTS_COLLECTION_REF = "restaurants";
const String ORDERS_COLLECTION_REF = "orders";

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final CollectionReference<Restaurants> _restaurantsRef;
  late final CollectionReference<Orders> _ordersRef;
  DatabaseService() {
    _restaurantsRef = _firestore
        .collection(RESTAURANTS_COLLECTION_REF)
        .withConverter<Restaurants>(
          fromFirestore: (snapshot, _) =>
              Restaurants.fromJSON(snapshot.data()!),
          toFirestore: (restaurants, _) => restaurants.toJSON(),
        );

    _ordersRef = _firestore
        .collection(ORDERS_COLLECTION_REF)
        .withConverter<Orders>(
            fromFirestore: (snapshot, _) => Orders.fromJSON(snapshot.data()!),
            toFirestore: (orders, _) => orders.toJSON());
  }

  //one time data
  // Future<QuerySnapshot> getRestaurants() async {
  //   return await _restaurantsRef.get();
  // }
  // real time data synchronization
  Stream<QuerySnapshot> getRestaurants() {
    return _restaurantsRef.snapshots();
  }

  Future<void> addRestaurants(Restaurants restaurant) async {
    try {
      await _restaurantsRef.add(restaurant);
    } catch (e) {
      print("Error adding restaurant: $e");
      throw e; // Rethrow the error to handle it in the UI or other layers
    }
  }

  Future<void> addOrders(Orders order) async {
    try {
      await _ordersRef.add(order);
    } catch (e) {
      print("Error adding order: $e");
      throw e; // Rethrow the error to handle it in the UI or other layers
    }
  }
}
