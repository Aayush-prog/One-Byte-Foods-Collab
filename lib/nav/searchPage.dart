import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:one_byte_foods/home/restaurant.dart';

class ProductSearchScreen extends StatefulWidget {
  final String? category; // Making category an optional parameter

  ProductSearchScreen({this.category});

  @override
  _ProductSearchScreenState createState() => _ProductSearchScreenState();
}

class _ProductSearchScreenState extends State<ProductSearchScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Restaurants"),
      ),
      body: Column(
        children: [
          // Your search input field
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search for restaurants...',
              ),
            ),
          ),
          // Your filter chips, if any
          // StreamBuilder for fetching data
          Expanded(
            child: StreamBuilder(
              stream: _buildQuerySnapshot(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: Text("No such restaurants"),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot product = snapshot.data!.docs[index];
                    return RestaurantCard(
                      documentId: product.reference.id,
                      cuisine: product['cuisine'],
                      name: product['name'],
                      location: product['location'],
                      ratings: product['ratings'],
                      imagesURL: product['imagesURL'],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Stream<QuerySnapshot> _buildQuerySnapshot() {
    Query query = FirebaseFirestore.instance.collection('restaurants');

    if (widget.category != null) {
      query = query.where('cuisine', isEqualTo: widget.category);
    }

    query = query.where('name', isGreaterThanOrEqualTo: _searchQuery);

    return query.snapshots();
  }
}
