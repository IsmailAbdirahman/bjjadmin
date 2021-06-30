import 'package:bjjapp/history/history_screen.dart';
import 'package:bjjapp/models/history_moddel.dart';
import 'package:bjjapp/models/product_model.dart';
import 'package:bjjapp/productsListScreen/product_list_screen.dart';
import 'package:flutter/material.dart';

class SearchBarHistoryWidget extends StatelessWidget {
  final List<HistoryModel>? searchHistoryID;

  const SearchBarHistoryWidget({this.searchHistoryID});

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
            delegate: SearchHistory(searchHistoryID: searchHistoryID));
      },
    );
  }
}

//--
class SearchHistory extends SearchDelegate {
  final List<HistoryModel>? searchHistoryID;

  SearchHistory({this.searchHistoryID});

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
          Icons.arrow_back,
          color: Colors.white70,
        ),
        onPressed: () {
          Navigator.pop(context);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    final List suggestionList = (query.isEmpty
        ? searchHistoryID
        : searchHistoryID!
            .where((element) => element.historyID
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
            return HistoryTile(
              historyModel: suggestionList[index],
              //  productModel: suggestionList[index],
            );
          }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List suggestionList = query.isEmpty
        ? searchHistoryID!
        : searchHistoryID!
            .where((element) => element.historyID
                .toString()
                .toLowerCase()
                .startsWith(query.toLowerCase()))
            .toList();
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
            return HistoryTile(
              historyModel: suggestionList[index],
              //  productModel: suggestionList[index],
            );
          }),
    );
  }
}
