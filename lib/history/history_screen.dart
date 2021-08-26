import 'package:bjjapp/AddNewuser/add_new_user_state.dart';
import 'package:bjjapp/history/search_history.dart';
import 'package:bjjapp/models/history_moddel.dart';
import 'package:bjjapp/productsListScreen/product_list_screen.dart';
import 'package:bjjapp/widgets/serach_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryScreen extends StatefulWidget {


  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  String? userID;
  @override
  void initState() {
    super.initState();
    userID = context.read(addingNewUserProvider).userID;
  }


  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (BuildContext context, watch, child) {
      final historyStateWatch = watch(addingNewUserProvider);

      return StreamBuilder<List<HistoryModel>>(
          stream: historyStateWatch.getHistoryStreamm(userID!),
          builder: (BuildContext context, snapshot) {
            if (snapshot.data != null) {
              List<HistoryModel> dataSnapshot = snapshot.data!;

              return Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  automaticallyImplyLeading: false,
                  title: Text("Tafaariiq"),
                  actions: [
                    SearchBarHistoryWidget(
                      searchHistoryID: dataSnapshot,
                    ),
                  ],
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemCount: dataSnapshot.length,
                          itemBuilder: (BuildContext context, int index) {
                            return HistoryTile(
                              historyModel: dataSnapshot[index],
                            );
                          }),
                    ),
                  ],
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          });
    });
  }
}

class HistoryTile extends StatelessWidget {
  final HistoryModel? historyModel;

  const HistoryTile({this.historyModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 10,
        color: Colors.deepPurple[700],
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              CardInfo(
                desc: "Taarikhda la iibiyay: ",
                text: historyModel!.dateSold,
              ),
              Divider(
                color: Colors.white,
              ),
              CardInfo(
                desc: "ID: ",
                text: historyModel!.historyID,
              ),
              Divider(
                color: Colors.white,
              ),
              CardInfo(
                desc: "Magaca: ",
                text: historyModel!.productName,
              ),
              Divider(
                color: Colors.white,
              ),
              CardInfo(
                desc: "Inta Xabo la iibiyay: ",
                text: historyModel!.quantity.toString(),
              ),
              Divider(
                color: Colors.white,
              ),
              CardInfo(
                desc: "Halki xabo Qiimaha Lagu iibiyay: ",
                text: historyModel!.pricePerItemToSell.toString(),
              ),
              Divider(
                color: Colors.white,
              ),
              CardInfo(
                desc: "Total: ",
                text: historyModel!.totalPrice.toString(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
