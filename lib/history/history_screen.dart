import 'package:bjjapp/AddNewuser/add_new_user_state.dart';
import 'package:bjjapp/models/history_moddel.dart';
import 'package:bjjapp/productsListScreen/product_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryScreen extends StatefulWidget {
  final String? userID;

  HistoryScreen({required this.userID});

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("History"),
        // actions: [
        //   searchBar(context, productDataList),
        // ],
      ),
      body: Column(
        children: [
          Consumer(
            builder: (BuildContext context, watch, child) {
              final historyStateWatch = watch(addingNewUserProvider);
              return Expanded(
                child: StreamBuilder<List<HistoryModel>>(
                  stream: historyStateWatch.getHistoryStreamm(widget.userID!),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.hasData) {
                      var dataSnapshot = snapshot.data;
                      return ListView.builder(
                          itemCount: dataSnapshot!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return HistoryTile(
                              historyModel: dataSnapshot[index],
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
    );
  }
}

class HistoryTile extends StatelessWidget {
  final HistoryModel? historyModel;

  const HistoryTile({this.historyModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlueAccent[100],
      child: Column(
        children: [
          CardInfo(
            desc: "ID: ",
            text: historyModel!.historyID,
          ),
          CardInfo(
            desc: "Magaca: ",
            text: historyModel!.productName,
          ),
          SizedBox(
            height: 20,
          ),
          CardInfo(
            desc: "Inta Xabo la iibiyay: ",
            text: historyModel!.quantity,
          ),
          SizedBox(
            height: 20,
          ),
          CardInfo(
            desc: "Halki xabo Qiimaha Lagu iibiyay: ",
            text: historyModel!.pricePerItemToSell,
          ),
          CardInfo(
            desc: "Total: ",
            text: historyModel!.totalPrice,
          ),
        ],
      ),
    );
  }
}
