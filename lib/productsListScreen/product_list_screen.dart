import 'package:bjjapp/models/product_model.dart';
import 'package:bjjapp/models/total_products_price_model.dart';
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
  Stream<List<ProductModel>>? productStream;
  Stream<TotalProductsPriceModel>? totalSoldStreamData;

  @override
  void initState() {
    super.initState();
    productStream = context.read(productListProvider).getProductStream;
    totalSoldStreamData = context.read(productListProvider).totalSoldStream;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (BuildContext context, watch, child) {
      final productProviderWatch = watch(productListProvider);
      return StreamBuilder<List<ProductModel>>(
          stream: productStream,
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
                    StreamBuilder<TotalProductsPriceModel>(
                      stream: totalSoldStreamData,
                      builder: (BuildContext context, snapshot) {
                        if (snapshot.hasData) {
                          TotalProductsPriceModel data = snapshot.data!;
                          return SizedBox(
                            height: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                DisplayTotalData(
                                  title: "Total Benefit",
                                  color: Colors.green,
                                  data: data.totalSold.toString(),
                                ),
                                DisplayTotalData(
                                  title: "Total Paid",
                                  color: Colors.orange,
                                  data: data.totalPurchased.toString(),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
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

class DisplayTotalData extends StatelessWidget {
  final String? data;
  final String? title;
  final Color? color;

  DisplayTotalData({this.data, this.color, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        width: 120,
        color: color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text(title!), Text(data!)],
        ));
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
            text: productModel!.quantity.toString(),
          ),
          SizedBox(
            height: 20,
          ),
          CardInfo(
            desc: "Halki Xabo Qiimahiisa: ",
            text: productModel!.pricePerItemToSell.toString(),
          ),
          CardInfo(
            desc: "Qiimaha lagu so iibiyay: ",
            text: productModel!.pricePerItemPurchased.toString(),
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
