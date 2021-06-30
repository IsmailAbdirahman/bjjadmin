import 'package:bjjapp/models/product_model.dart';
import 'package:flutter/material.dart';
import 'search.dart';

class SearchBarWidget extends StatelessWidget {
  final List<ProductModel>? searchProductName;

  const SearchBarWidget({this.searchProductName});

  @override
  Widget build(BuildContext context) {
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
}
