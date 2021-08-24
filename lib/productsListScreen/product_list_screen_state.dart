import 'package:bjjapp/models/product_model.dart';
import 'package:bjjapp/models/total_products_price_model.dart';
import 'package:bjjapp/service/service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productListProvider = ChangeNotifierProvider((ref) => ProductListState());

//--
class ProductListState extends ChangeNotifier {
  List<ProductModel> _productList = [];

  List<ProductModel> get productList => _productList;

  addData(
      {required double? groupPrice,
      required String? productName,
      required double? pricePerItemPurchased,
      required double? pricePerItemToSell,
      required int? quantity}) {
    Service().addData(
      groupPrice:groupPrice ,
        productName: productName,
        pricePerItemPurchased: pricePerItemPurchased,
        pricePerItemToSell: pricePerItemToSell,
        quantity: quantity);
  }

  getListOfProducts(List<ProductModel> products) {
    _productList = products;
  }

  deleteProduct(
      {required String prodID,
      required double pricePurchase,
      required double priceSold,
      required int quantityLeft}) {
    Service().deleteProduct(
        prodID: prodID,
        pricePurchase: pricePurchase,
        priceSold: priceSold,
        quantityLeft: quantityLeft);
  }

  Stream<List<ProductModel>> get getProductStream {
    return Service().products.snapshots().map(Service().getProductSnapshot);
  }

  Stream<TotalProductsPriceModel> get totalSoldStream {
    return Service()
        .products
        .doc('totalData')
        .collection('totalOfProducts')
        .doc('totalData')
        .snapshots()
        .map(Service().getTotalSold);
  }
}
