import 'package:bjjapp/productsListScreen/product_list_screen.dart';
import 'package:bjjapp/signin/signin_state.dart';
import 'package:bjjapp/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
                child: TextField(
                  controller: _productNameController,
                  decoration: InputDecoration(
                      hintText: 'Magaca sheyga aad iibin rabtid ?',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black))),
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(
                controller: _pricePerItemPurchasedController,
                hintName: 'Imisa ayaad kusoo iibisay Adiga ?',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(
                controller: _pricePerItemToSellController,
                hintName: 'Imisa ayaad doneysaa in aad ku iibiso ?',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(
                controller: _quantityController,
                hintName: 'Meeqo xabo waaye',
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  if (_pricePerItemPurchasedController.text.isNotEmpty &&
                      _pricePerItemToSellController.text.isNotEmpty &&
                      _quantityController.text.isNotEmpty &&
                      _productNameController.text.isNotEmpty) {
                    double pricePurchased =
                        double.parse(_pricePerItemPurchasedController.text);
                    double priceToSell =
                        double.parse(_pricePerItemToSellController.text);
                    int quantity = int.parse(_quantityController.text);

                    showDialog<void>(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text(
                              'Bedelid laguma samayn karo haddi ay wax qaldan yihin.'),
                          content: const Text(
                              "Ma hubtaa maclumadka ad galisay in ay sax yihin ?"),
                          actions: [
                            ElevatedButton(
                                onPressed: () async {
                                  await context
                                      .read(productListProvider)
                                      .addData(
                                          productName:
                                              _productNameController.text,
                                          pricePerItemPurchased: pricePurchased,
                                          pricePerItemToSell: priceToSell,
                                          quantity: quantity);
                                  Fluttertoast.showToast(
                                          msg: "wala fuliyay dalabkaga",
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0)
                                      .then((value) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProductsListScreen()));
                                  });
                                },
                                child: Text("Haa")),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("maya"))
                          ],
                        );
                      },
                    );
                  } else {
                    Fluttertoast.showToast(
                        msg: "Meel ayaa banaan wali, Fadlan dhameystir!",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                },
                child: Text("Add"))
          ],
        ),
      ),
    );
  }
}
