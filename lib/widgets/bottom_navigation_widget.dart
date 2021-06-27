import 'package:bjjapp/AddNewuser/add_new_user.dart';
import 'package:bjjapp/history/history_screen.dart';
import 'package:bjjapp/productsListScreen/product_list_screen.dart';
import 'package:flutter/material.dart';

class DisplayData extends StatefulWidget {
  DisplayData({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return homeState();
  }
}

class homeState extends State<DisplayData> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    ProductsListScreen(),
    HistoryScreen(),
    AddNewUser()
  ];

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
        bottomNavigationBar: ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
            ),
            child: getBottomNavigationBar()));
  }

  Widget getBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: Color(0Xff000000),
      elevation: 0,
      unselectedItemColor: Colors.grey,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
        BottomNavigationBarItem(icon: Icon(Icons.create_outlined), label: "New Account"),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.white,
      onTap: _onItemTapped,
    );
  }
}
