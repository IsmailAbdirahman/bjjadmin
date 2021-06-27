import 'package:bjjapp/history/history_screen.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  final String? name;
  final String? quantity;
  final String? pricePerItem;

  const ProductDetails({Key? key, this.name, this.quantity, this.pricePerItem});

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int incrementDecrement = 1;
  late int total;

  int calculateTotal(int priceperItem, int incrementDecremt) {
    int total = priceperItem * incrementDecrement;
    return total;
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ma Hubtaa in aad ii bisay?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Haa'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HistoryScreen()),
                );
              },
            ),
            TextButton(
              child: const Text('Maya'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    String aa = widget.pricePerItem!.replaceAll("\$", "");
    total = pricePerItemValue(aa);
    super.initState();
  }

  int pricePerItemValue(String pricePerItem) {
    String aa = widget.pricePerItem!.replaceAll("\$", "");
    int totall = int.parse(aa);
    return totall;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          Container(
            height: 200,
            child: Card(
              color: Colors.blue,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("Magaca:  "),
                      Text(widget.name!),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Text("Inta Xabo la rabo: "),
                        Text(incrementDecrement.toString())
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Expanded(
                    child: Row(
                      children: [Text("Qiimaha: "), Text(total.toString())],
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 40,
            width: 80,
            color: Colors.amber,
            child: Row(
              children: [
                InkWell(
                    onTap: () {
                      setState(() {
                        incrementDecrement++;
                        total = calculateTotal(
                            pricePerItemValue(widget.pricePerItem!),
                            incrementDecrement);
                      });
                    },
                    child: Center(child: Icon(Icons.add))),
                VerticalDivider(
                  color: Colors.black,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      incrementDecrement--;
                      total = calculateTotal(
                          pricePerItemValue(widget.pricePerItem!),
                          incrementDecrement);
                      if (incrementDecrement < 1) {
                        incrementDecrement = 1;
                        total = pricePerItemValue(widget.pricePerItem!);
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 28.0),
                    child: Icon(Icons.minimize),
                  ),
                )
              ],
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                await _showMyDialog();
              },
              child: Text("Sell"))
        ],
      )),
    );
  }
}
