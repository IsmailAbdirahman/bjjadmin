import 'package:bjjapp/AddNewuser/add_new_user.dart';
import 'package:bjjapp/history/history_screen.dart';
import 'package:bjjapp/jumlo_history/jumlo_history.dart';
import 'package:bjjapp/productsListScreen/product_list_screen.dart';
import 'package:flutter/material.dart';

class DisplayUserData extends StatefulWidget {
  DisplayUserData({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return homeState();
  }
}

class homeState extends State<DisplayUserData> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[HistoryScreen(), JumloHistory()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: getBottomNavigationBar());
  }

  Widget getBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.deepPurple,
      elevation: 0,
      unselectedItemColor: Colors.white70,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "tafaariiq"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Jumlo"),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.white,
      onTap: _onItemTapped,
    );
  }
}
