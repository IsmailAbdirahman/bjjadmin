import 'package:bjjapp/signin/signin_state.dart';
import 'package:bjjapp/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'product_list_screen_state.dart';

class AddNewProducts extends StatefulWidget {
  @override
  _AddNewProductsState createState() => _AddNewProductsState();
}

class _AddNewProductsState extends State<AddNewProducts> {
  TextEditingController _productNameController = TextEditingController();
  TextEditingController _pricePerItemPurchasedController =
      TextEditingController();
  TextEditingController _pricePerItemToSellController = TextEditingController();
  TextEditingController _quantityController = TextEditingController();

  @override
  void dispose() {
    _productNameController.dispose();
    _pricePerItemPurchasedController.dispose();
    _pricePerItemToSellController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(
                controller: _productNameController,
                hintName: 'Product Name',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(
                controller: _pricePerItemPurchasedController,
                hintName: 'price Per Item Purchased',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(
                controller: _pricePerItemToSellController,
                hintName: 'Price Per Item to Sell',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(
                controller: _quantityController,
                hintName: 'Quantity',
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  context.read(productListProvider).addData(
                      productName: _productNameController.text,
                      pricePerItemPurchased:
                          _pricePerItemPurchasedController.text,
                      pricePerItemToSell: _pricePerItemToSellController.text,
                      quantity: _quantityController.text);
                  Navigator.pop(context);
                },
                child: Text("ADD"))
          ],
        ),
      ),
    );
  }
}

