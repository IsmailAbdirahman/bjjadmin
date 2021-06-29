import 'package:bjjapp/models/product_model.dart';
import 'package:bjjapp/productsListScreen/product_list_screen.dart';
import 'package:flutter/material.dart';


class SearchProduct extends SearchDelegate {
  final List<ProductModel>? searchProductName;

  SearchProduct({this.searchProductName});

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      primaryColor: Colors.blueAccent,
      backgroundColor: Colors.blueAccent,
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear, color: Colors.white70),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.white70,
        ),
        onPressed: () {
          Navigator.pop(context);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    final List suggestionList = (query.isEmpty
        ? searchProductName
        : searchProductName!
        .where((element) => element.productName
        .toString()
        .toLowerCase()
        .startsWith(query.toLowerCase()))
        .toList())!;
    return Container(
      height: 140,
      width: double.infinity,
      child: ListView.builder(
          primary: false,
          itemCount: suggestionList.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return  ProductTile(
              productModel: suggestionList[index],
              //  productModel: suggestionList[index],
            );
          }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List suggestionList = (query.isEmpty
        ? searchProductName
        : searchProductName!
        .where((element) => element.productName
        .toString()
        .toLowerCase()
        .startsWith(query.toLowerCase()))
        .toList())!;
    return Container(
      height: 140,
      width: double.infinity,

      child: ListView.builder(
          primary: false,
          itemCount: suggestionList.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return  ProductTile(
              productModel: suggestionList[index],
              //  productModel: suggestionList[index],
            );
          }),
    );
  }
}