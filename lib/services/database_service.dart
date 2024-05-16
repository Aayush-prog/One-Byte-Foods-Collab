import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<void> updateUserData(String uid,
      {String? favorites, String? reserved}) async {
    Map<String, dynamic> userData = {};

    // Retrieve existing user data
    DocumentSnapshot userDoc = await _usersRef.doc(uid).get();
    if (userDoc.exists) {
      userData = userDoc.data() as Map<String, dynamic>;
    }
    print(userData['favorites']);
    // Merge new data with existing data
    if (favorites != null) {
      userData['favorites'].add(favorites);
    }
    if (reserved != null) {
      userData['reserved'].add(reserved);
    }
    print(userData['favorites']);
    // Update the document with merged data
    await _usersRef.doc(uid).set(userData);
  }

  Future<DocumentSnapshot> userDB(String docId) {
    return _usersRef.doc(docId).get();
  }

  void removeFromFavorites(String userId, String favoriteId) async {
    try {
      // Get a reference to the user's document
      DocumentReference userDocRef =
          FirebaseFirestore.instance.collection('users').doc(userId);

      // Get the current data from the document
      DocumentSnapshot userDocSnapshot = await userDocRef.get();
      Map<String, dynamic> userData =
          userDocSnapshot.data() as Map<String, dynamic>;

      // Extract the favorites list
      List<dynamic> favorites = List.from(userData['favorites']);

      // Remove the favoriteId from the list
      favorites.remove(favoriteId);

      // Update the document with the modified favorites list
      await userDocRef.update({'favorites': favorites});

      print('Favorite removed successfully.');
    } catch (e) {
      print('Error removing favorite: $e');
    }
  }
}
