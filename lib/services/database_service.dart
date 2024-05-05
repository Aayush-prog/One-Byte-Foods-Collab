import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:one_byte_foods/models/orders.dart';
import 'package:one_byte_foods/models/restaurants.dart';

const String RESTAURANTS_COLLECTION_REF = "restaurants";
const String ORDERS_COLLECTION_REF = "orders";
const String USERS_COLLECTION_REF = "users";

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final CollectionReference<Restaurants> _restaurantsRef;
  late final CollectionReference<Orders> _ordersRef;
  late final CollectionReference _usersRef;
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

    _usersRef = _firestore.collection(USERS_COLLECTION_REF);
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

  Future<void> addOrders(Orders order, String uid) async {
    try {
      await _ordersRef.add(order).then((documentSnapshot) =>
          updateUserData(uid, reserved: documentSnapshot.id));
    } catch (e) {
      print("Error adding order: $e");
      throw e; // Rethrow the error to handle it in the UI or other layers
    }
  }

  Future updateUserData(String uid,
      {String? favorites, String? reserved}) async {
    Map<String, dynamic> userData = {};
    if (favorites != null) {
      userData['favorites'] = FieldValue.arrayUnion([favorites]);
    }
    if (reserved != null) {
      userData['reserved'] = FieldValue.arrayUnion([reserved]);
    }
    return await _usersRef.doc(uid).set(userData);
  }

  Future<DocumentSnapshot> userDB(String docId) {
    return _usersRef.doc(docId).get();
  }
}
