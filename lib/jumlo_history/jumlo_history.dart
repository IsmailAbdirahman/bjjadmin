import 'package:bjjapp/jumlo_history/search_jumlo_history.dart';
import 'package:bjjapp/models/jumlo_history_model.dart';
import 'package:bjjapp/productsListScreen/product_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'jumlo_history_state.dart';

class JumloHistory extends StatefulWidget {
  const JumloHistory({Key? key}) : super(key: key);

  @override
  _JumloHistoryState createState() => _JumloHistoryState();
}

class _JumloHistoryState extends State<JumloHistory> {
  Stream<List<JumloHistoryModel>>? jumloHistoryStreamData;

  static String? loanType;
  int _selectedIndex = 0;
  List<String> loanList = ['Deen-lagu-leyahay', 'Deen-lagu-leheen'];

  Widget genderType(int index) {
    print("OUTSIDE ${loanList[index]}");
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
          loanType = loanList[index];
          if (loanType == loanList[0]) {
            jumloHistoryStreamData = context
                .read(jumloHistoryState)
                .getJumloHistoryStream(isLoan: true);
          } else {
            jumloHistoryStreamData = context
                .read(jumloHistoryState)
                .getJumloHistoryStream(isLoan: false);
          }
        });
      },
      child: Container(
          margin: const EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60.0),
          ),
          child: OutlineButton(
            disabledBorderColor: Colors.deepPurple,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            onPressed: null,
            child: Text(
              loanList[index],
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
                color: _selectedIndex == index ? Colors.black : Colors.grey,
              ),
            ),
          )),
    );
  }

  Widget categories() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: loanList
            .asMap()
            .entries
            .map((singleType) => genderType(singleType.key))
            .toList());
  }

  @override
  void initState() {
    super.initState();
    jumloHistoryStreamData =
        context.read(jumloHistoryState).getJumloHistoryStream(isLoan: true);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<JumloHistoryModel>>(
        stream: jumloHistoryStreamData,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            List<JumloHistoryModel> dataSnapshot = snapshot.data!;

            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Text("Jumlo"),
                centerTitle: true,
                actions: [
                  SearchBarJumloHistoryWidget(
                    searchHistoryID: dataSnapshot,
                  ),
                ],
              ),
              body: Column(
                children: [
                  categories(),
                  Expanded(
                    child: ListView.builder(
                        itemCount: dataSnapshot.length,
                        itemBuilder: (BuildContext context, int index) {
                          return JumloHistoryTile(
                            jumloHistoryModel: dataSnapshot[index],
                          );
                        }),
                  )
                ],
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}

class JumloHistoryTile extends StatelessWidget {
  final JumloHistoryModel? jumloHistoryModel;

  const JumloHistoryTile({this.jumloHistoryModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Colors.deepPurple[700],
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Deen ma bixyay",
                  style: TextStyle(
                      fontWeight: FontWeight.w800, color: Colors.white70),
                ),
                VerticalDivider(
                  color: Colors.white,
                ),
                Padding(
                    padding: const EdgeInsets.only(right: 28.0),
                    child: jumloHistoryModel!.isLoan! == false
                        ? Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    )
                        : Icon(
                          Icons.dangerous,
                          color: Colors.red,
                        )),
              ],
            ),
            Divider(
              color: Colors.white70,
            ),
            CardInfo(
              desc: "Taarikhda la iibiyay: ",
              text: jumloHistoryModel!.dateTold,
            ),
            Divider(
              color: Colors.white70,
            ),
            CardInfo(
              desc: "ID: ",
              text: jumloHistoryModel!.historyID,
            ),
            Divider(
              color: Colors.white70,
            ),
            CardInfo(
              desc: "Magaca Sheyga: ",
              text: jumloHistoryModel!.productName,
            ),
            Divider(
              color: Colors.white70,
            ),
            CardInfo(
              desc: "Magaca Qofka deynta qatay: ",
              text: jumloHistoryModel!.nameOfPerson,
            ),
            Divider(
              color: Colors.white70,
            ),
            CardInfo(
              desc: "Inta Xabo la iibiyay: ",
              text: jumloHistoryModel!.quantity.toString(),
            ),
            Divider(
              color: Colors.white70,
            ),
            CardInfo(
              desc: "Halki xabo Qiimaha Lagu iibiyay: ",
              text: "\$${jumloHistoryModel!.priceGroupItems}",
            ),
            Divider(
              thickness: 2.5,
              color: Colors.white70,
            ),
            CardInfo(
              desc: "Total: ",
              text: "\$${jumloHistoryModel!.totalPrice}",
            ),
          ],
        ),
      ),
    );
  }
}
