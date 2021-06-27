import 'package:bjjapp/models/product_model.dart';
import 'package:bjjapp/service/service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productListProvider = ChangeNotifierProvider((ref) => ProductListState());

//--
class ProductListState extends ChangeNotifier {
  addData(
      {String? productName,
      String? pricePerItemPurchased,
      String? pricePerItemToSell,
      String? quantity}) {
    Service().addData(
        productName: productName,
        pricePerItemPurchased: pricePerItemPurchased,
        pricePerItemToSell: pricePerItemToSell,
        quantity: quantity);
  }

  Stream<List<ProductModel>> get getProductStream {
    return Service().products.snapshots().map(Service().getProductSnapshot);
  }
}
