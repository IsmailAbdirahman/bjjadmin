import 'package:bjjapp/productsListScreen/product_list_screen.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text("History"),
          ),
          body: Column(
            children: [
              Card(
                color: Colors.lightBlueAccent[100],
                child: Column(
                  children: [
                    CardInfo(
                      desc: "Magaca: ",
                      text: "Nalka hore",
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CardInfo(
                      desc: "Inta Xabo ka taalo: ",
                      text: "67",
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CardInfo(
                      desc: "Halki Xabo Qiimahiisa: ",
                      text: "\$12",
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    CardInfo(
                      desc: "Taariikhda la i biyay: ",
                      text: "16-june-2021",
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
