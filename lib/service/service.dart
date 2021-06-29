import 'dart:async';
import 'package:bjjapp/models/history_moddel.dart';
import 'package:bjjapp/models/product_model.dart';
import 'package:bjjapp/models/users_model.dart';
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
  addNewUser(String phoneNumber, bool isBlocked) async {
    await users
        .doc(phoneNumber)
        .set({"phoneNumber": phoneNumber, "isBlocked": isBlocked}).then(
            (value) => print("Added new user"));
    await addDocument(phoneNumber);
  }

  Future addDocument(String phoneNumber) async {
    return users.doc(phoneNumber);
  }

  List<UserInfo> getPhoneNumberSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return UserInfo(
          phoneNumber: doc['phoneNumber'], isBlocked: doc['isBlocked']);
    }).toList();
  }

  blockUnblockUser(String phoneNumber, bool isBlocked) async {
    await users.doc(phoneNumber).update({"isBlocked": isBlocked}).then(
        (value) => print("user Status Updated"));
  }

  //Get specific User History
  List<HistoryModel> getHistorySnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return HistoryModel(
          historyID: doc['historyID'],
          productName: doc['productName'],
          pricePerItemToSell: doc['pricePerItemToSell'],
          totalPrice: doc['totalPrice'],
          quantity: doc['quantity']);
    }).toList();
  }

  Stream<List<HistoryModel>>  getHistoryStream(String userID) {
    return users
        .doc(userID)
        .collection("History")
        .snapshots()
        .map(getHistorySnapshot);
  }

//------------------------------------Other User---------------------

}
