import 'package:bjjapp/models/product_model.dart';
import 'package:bjjapp/productsListScreen/add_new_products.dart';
import 'package:bjjapp/productsListScreen/product_list_screen_state.dart';
import 'package:bjjapp/widgets/serach_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductsListScreen extends StatefulWidget {
  @override
  _ProductsListScreenState createState() => _ProductsListScreenState();
}

class _ProductsListScreenState extends State<ProductsListScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (BuildContext context, watch, child) {
      final productProviderWatch = watch(productListProvider);
      return StreamBuilder<List<ProductModel>>(
          stream: productProviderWatch.getProductStream,
          builder: (BuildContext context, snapshot) {
            if (snapshot.data != null) {
              productProviderWatch.getListOfProducts(snapshot.data!);
              List<ProductModel> data = productProviderWatch.productList;
              return Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  title: Text("Home"),
                  actions: [
                    SearchBarWidget(
                      searchProductName:
                          context.read(productListProvider).productList,
                    ),
                  ],
                ),
                body: Column(
                  children: [
                    Expanded(
                        child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ProductTile(
                                productModel: data[index],
                              );
                            }))
                  ],
                ),
                floatingActionButton: FloatingActionButton(
                  child: Icon(Icons.add),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddNewProducts()),
                    );
                  },
                ),
              );
            } else {
              return CircularProgressIndicator();
            }
          });
    });
  }
}

class ProductTile extends StatelessWidget {
  final ProductModel? productModel;

  const ProductTile({this.productModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlueAccent[100],
      child: Column(
        children: [
          CardInfo(
            desc: "Magaca: ",
            text: productModel!.productName,
          ),
          SizedBox(
            height: 20,
          ),
          CardInfo(
            desc: "Inta Xabo ka taalo: ",
            text: productModel!.quantity,
          ),
          SizedBox(
            height: 20,
          ),
          CardInfo(
            desc: "Halki Xabo Qiimahiisa: ",
            text: productModel!.pricePerItemToSell,
          ),
          CardInfo(
            desc: "Qiimaha lagu so iibiyay: ",
            text: productModel!.pricePerItemPurchased,
          ),
        ],
      ),
    );
  }
}

class CardInfo extends StatelessWidget {
  final String? desc;
  final String? text;

  const CardInfo({Key? key, this.desc, this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          desc!,
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        SizedBox(
          width: 70,
        ),
        Text(text!),
      ],
    );
  }
}
