import 'package:flutter/foundation.dart';

class ProductModel {
  String? productName;
  double? pricePerItemPurchased;
  double? pricePerItemToSell;
  int? quantity;
  String? productID;
  double? priceGroupItems;

  ProductModel(
      {this.productName,
      this.pricePerItemPurchased,
      this.pricePerItemToSell,
      this.quantity,
      this.productID,
      this.priceGroupItems});
}
