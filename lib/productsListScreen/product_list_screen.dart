import 'dart:math';
import 'dart:ui';

import 'package:bjjapp/models/product_model.dart';
import 'package:bjjapp/models/total_products_price_model.dart';
import 'package:bjjapp/productsListScreen/add_new_products.dart';
import 'package:bjjapp/productsListScreen/product_list_screen_state.dart';
import 'package:bjjapp/service/service.dart';
import 'package:bjjapp/widgets/serach_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

class ProductsListScreen extends StatefulWidget {
  @override
  _ProductsListScreenState createState() => _ProductsListScreenState();
}

class _ProductsListScreenState extends State<ProductsListScreen> {
  String? randomTex;

  Stream<List<ProductModel>>? productStream;
  Stream<TotalProductsPriceModel>? totalSoldStreamData;
  TextEditingController randomTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    productStream = context.read(productListProvider).getProductStream;
    totalSoldStreamData = context.read(productListProvider).totalSoldStream;

    Random rnd = Random();
    String getRandomString(int length) =>
        String.fromCharCodes(Iterable.generate(
            length, (_) => _chars.codeUnitAt(rnd.nextInt(_chars.length))));
    randomTex = getRandomString(10);
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
                  leading: InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              return BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: Dialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  //this right here
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.50,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Align(
                                              alignment: Alignment.topRight,
                                              child: InkWell(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Icon(Icons.clear))),
                                          RichText(
                                            text: TextSpan(
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text:
                                                        'Si aad delete u dhahdid Fadlan mesha banaan ku buuxi qoraalkan:  ',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                TextSpan(
                                                    text: randomTex,
                                                    style: TextStyle(
                                                        color:
                                                            Colors.deepPurple)),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(18.0),
                                            child: TextField(
                                              controller: randomTextController,
                                              decoration: InputDecoration(
                                                  hintText: "Example: hdsghdg"),
                                            ),
                                          ),
                                          Container(
                                            width: double.infinity,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 20,
                                                right: 20,
                                              ),
                                              child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                new BorderRadius
                                                                        .circular(
                                                                    30.0),
                                                          ),
                                                          primary:
                                                              Colors.red[800]),
                                                  child: Text(
                                                    "Delete All Data",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  onPressed: () {
                                                    if (randomTextController
                                                            .text ==
                                                        randomTex) {
                                                      Service().deleteAllData();
                                                      Navigator.pop(context);
                                                    } else {
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              "Waa Qalad, Fadlan si sax ah u geli",
                                                          toastLength:
                                                              Toast.LENGTH_LONG,
                                                          gravity: ToastGravity
                                                              .CENTER,
                                                          timeInSecForIosWeb: 1,
                                                          backgroundColor:
                                                              Colors.red,
                                                          textColor:
                                                              Colors.white,
                                                          fontSize: 16.0);
                                                    }
                                                  }),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                      child: Icon(Icons.dangerous,color: Colors.deepPurple[600],)),
                  title: Text("Home"),
                  centerTitle: true,
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
                          return Padding(
                            padding: const EdgeInsets.only(top: 18.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                DisplayTotalData(
                                  title: "Benefit",
                                  color: Colors.green[700],
                                  data: "\$${data.totalSold.toString()}",
                                ),
                                DisplayTotalData(
                                  title: "Paid",
                                  color: Colors.blue[700],
                                  data: "\$${data.totalPurchased.toString()}",
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Text("No data");
                        }
                      },
                    ),
                    Expanded(
                        child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onLongPress: () {
                                  showDialog<void>(
                                    context: context,
                                    barrierDismissible: false,
                                    // user must tap button!
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text(
                                            'Delete ayaad dhihi rabtaa'),
                                        content: const Text(
                                            "Ma hubtaa Sheygan in adan u baahneen ?"),
                                        actions: [
                                          ElevatedButton(
                                              onPressed: () {
                                                context
                                                    .read(productListProvider)
                                                    .deleteProduct(
                                                        prodID: data[index]
                                                            .productID!,
                                                        pricePurchase: data[
                                                                index]
                                                            .pricePerItemPurchased!,
                                                        priceSold: data[index]
                                                            .pricePerItemToSell!,
                                                        quantityLeft:
                                                            data[index]
                                                                .quantity!);
                                                Navigator.pop(context);
                                              },
                                              child: Text("Haa")),
                                          ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text("Maya")),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: ProductTile(
                                  productModel: data[index],
                                ),
                              );
                            })),
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
        child: Card(
          color: color,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title!,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(data!,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w800)),
              )
            ],
          ),
        ));
  }
}

class ProductTile extends StatelessWidget {
  final ProductModel? productModel;

  const ProductTile({this.productModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Card(
        elevation: 10,
        color: Colors.deepPurple[700],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              CardInfo(
                desc: "Magaca: ",
                text: productModel!.productName,
              ),
              Divider(
                color: Colors.white,
              ),
              CardInfo(
                desc: "Inta Xabo ka taalo: ",
                text: productModel!.quantity.toString(),
                color: productModel!.quantity! > 16 ? Colors.white : Colors.red,
              ),
              Divider(
                color: Colors.white,
              ),
              CardInfo(
                desc: "Halki Xabo Qiimahiisa: ",
                text: "\$${productModel!.pricePerItemToSell}",
              ),
              Divider(
                color: Colors.white,
              ),
              CardInfo(
                desc: "Qiimaha lagu so iibiyay: ",
                text: "\$${productModel!.pricePerItemPurchased}",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardInfo extends StatelessWidget {
  final String? desc;
  final String? text;
  final Color? color;

  const CardInfo({Key? key, this.desc, this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          desc!,
          style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white70),
        ),
        VerticalDivider(
          color: Colors.white,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 28.0),
          child: Text(
            text!,
            style: TextStyle(
                color: color ?? Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
