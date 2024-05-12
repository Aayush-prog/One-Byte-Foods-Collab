import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:one_byte_foods/main.dart';
import 'package:one_byte_foods/models/restaurants.dart';
import 'package:one_byte_foods/services/database_service.dart';

class AddImage extends StatefulWidget {
  const AddImage({super.key});

  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  DatabaseService dbService = DatabaseService();
  TextEditingController name = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController ratings = TextEditingController();
  TextEditingController cuisine = TextEditingController();
  TextEditingController averagePrice = TextEditingController();
  List imagesURL = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Uplist"),
      ),
      body: ListView(
        children: [
          IconButton(
              onPressed: () async {
                ImagePicker imagePicker = ImagePicker();
                XFile? file =
                    await imagePicker.pickImage(source: ImageSource.gallery);
                String uniqueFileName =
                    DateTime.now().millisecondsSinceEpoch.toString();
                Reference referenceRoot = FirebaseStorage.instance.ref();
                Reference referenceImageToUpload =
                    referenceRoot.child(uniqueFileName);

                await referenceImageToUpload.putFile(File(file!.path));
                imagesURL.add(await referenceImageToUpload.getDownloadURL());
                Text("added!");
              },
              icon: Icon(Icons.camera_alt)),
          IconButton(
              onPressed: () async {
                ImagePicker imagePicker = ImagePicker();
                XFile? file =
                    await imagePicker.pickImage(source: ImageSource.gallery);
                String uniqueFileName =
                    DateTime.now().millisecondsSinceEpoch.toString();
                Reference referenceRoot = FirebaseStorage.instance.ref();
                Reference referenceImageToUpload =
                    referenceRoot.child(uniqueFileName);

                await referenceImageToUpload.putFile(File(file!.path));
                imagesURL.add(await referenceImageToUpload.getDownloadURL());
                Text("added!");
              },
              icon: Icon(Icons.camera_alt)),
          IconButton(
              onPressed: () async {
                ImagePicker imagePicker = ImagePicker();
                XFile? file =
                    await imagePicker.pickImage(source: ImageSource.gallery);
                String uniqueFileName =
                    DateTime.now().millisecondsSinceEpoch.toString();
                Reference referenceRoot = FirebaseStorage.instance.ref();
                Reference referenceImageToUpload =
                    referenceRoot.child(uniqueFileName);

                await referenceImageToUpload.putFile(File(file!.path));
                imagesURL.add(await referenceImageToUpload.getDownloadURL());
                Text("added!");
              },
              icon: Icon(Icons.camera_alt)),
          IconButton(
              onPressed: () async {
                ImagePicker imagePicker = ImagePicker();
                XFile? file =
                    await imagePicker.pickImage(source: ImageSource.gallery);
                String uniqueFileName =
                    DateTime.now().millisecondsSinceEpoch.toString();
                Reference referenceRoot = FirebaseStorage.instance.ref();
                Reference referenceImageToUpload =
                    referenceRoot.child(uniqueFileName);

                await referenceImageToUpload.putFile(File(file!.path));
                imagesURL.add(await referenceImageToUpload.getDownloadURL());
                Text("added!");
              },
              icon: Icon(Icons.camera_alt)),
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05,
                vertical: MediaQuery.of(context).size.width * 0.02),
            child: TextField(
              controller: name,
              decoration: InputDecoration(
                labelText: 'Enter name',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05,
                vertical: MediaQuery.of(context).size.width * 0.02),
            child: TextField(
              controller: location,
              decoration: InputDecoration(
                labelText: 'Enter location',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05,
                vertical: MediaQuery.of(context).size.width * 0.02),
            child: TextField(
              controller: averagePrice,
              decoration: InputDecoration(
                labelText: 'Enter average price',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05,
                vertical: MediaQuery.of(context).size.width * 0.02),
            child: TextField(
              controller: ratings,
              decoration: InputDecoration(
                labelText: 'Enter ratings',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.15,
                vertical: MediaQuery.of(context).size.width * 0.05),
            child: TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 202, 202, 202))),
                onPressed: () async {
                  Restaurants restaurant = Restaurants(
                      averagePrice: averagePrice.text,
                      cuisine: cuisine.text,
                      imagesURL: imagesURL,
                      location: location.text,
                      name: name.text,
                      ratings: double.tryParse(ratings.text) ?? 0.0);
                  await dbService.addRestaurants(restaurant);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      duration: Duration(milliseconds: 500),
                      content: Text("Restaurant added succesfully")));
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => MyApp()));
                },
                child: Text(
                  "Uplist your restaurant!",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                      fontWeight: FontWeight.bold),
                )),
          )
        ],
      ),
    );
  }
}
