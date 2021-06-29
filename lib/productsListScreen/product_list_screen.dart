import 'package:bjjapp/models/product_model.dart';
import 'package:bjjapp/productsListScreen/add_new_products.dart';
import 'package:bjjapp/productsListScreen/product_list_screen_state.dart';
import 'package:bjjapp/signin/signin_state.dart';
import 'package:bjjapp/widgets/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductsListScreen extends StatefulWidget {
  @override
  _ProductsListScreenState createState() => _ProductsListScreenState();
}

class _ProductsListScreenState extends State<ProductsListScreen> {
  Widget searchBar(BuildContext context, var searchProductName) {
    return IconButton(
      icon: Icon(
        Icons.search,
        color: Colors.white,
        size: 27,
      ),
      onPressed: () {
        showSearch(
            context: context,
            delegate: SearchProduct(searchProductName: searchProductName));
      },
    );
  }

  @override
  void initState() {
    super.initState();
    //context.read(productListProvider).getProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Home"),
        // actions: [
        //   searchBar(context, productDataList),
        // ],
      ),
      body: Column(
        children: [
          Consumer(
            builder: (BuildContext context, watch, child) {
              final productProviderWatch = watch(productListProvider);
              return Expanded(
                child: StreamBuilder<List<ProductModel>>(
                  stream: productProviderWatch.getProductStream,
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.hasData) {
                      var dataSnapshot = snapshot.data;
                      return ListView.builder(
                          itemCount: dataSnapshot!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ProductTile(
                              productModel: dataSnapshot[index],
                            );
                          });
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              );
            },
          )
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
