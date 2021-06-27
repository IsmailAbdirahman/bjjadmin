import 'dart:async';
import 'package:bjjapp/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const String PRODUCTS = "products";
const String USERS = "users";

class Service {
  CollectionReference products =
      FirebaseFirestore.instance.collection(PRODUCTS);
  CollectionReference users = FirebaseFirestore.instance.collection(USERS);

  String productID = DateTime.now().toString();

  addData(
      {String? productName,
      String? pricePerItemPurchased,
      String? pricePerItemToSell,
      String? quantity}) {
    products
        .doc(productID)
        .set({
          'productID': productID,
          'productName': productName,
          'pricePerItemPurchased': pricePerItemPurchased,
          'pricePerItemToSell': pricePerItemToSell,
          'quantity': quantity
        })
        .then((value) => print("ADDED"))
        .catchError((error) => print("Something Went Wrong"));
  }

  List<ProductModel> getProductSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return ProductModel(
          productName: doc['productName'],
          pricePerItemPurchased: doc['pricePerItemPurchased'],
          pricePerItemToSell: doc['pricePerItemToSell'],
          quantity: doc['quantity']);
    }).toList();
  }

//---------------- adding new user ----------------------
  addNewUser(String phoneNumber) async {
    await users.doc(phoneNumber).set({"phoneNumber": phoneNumber}).then(
        (value) => print("Added new user"));
    await addDocument(phoneNumber);
  }

  Future addDocument(String phoneNumber) async {
    return users.doc(phoneNumber);
  }

//------------------------------------Other User---------------------

}
