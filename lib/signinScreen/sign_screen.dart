import 'package:bjjapp/productsListScreen/product_list_screen.dart';
import 'package:bjjapp/signin/signin_state.dart';
import 'package:bjjapp/widgets/bottom_navigation_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// class SignInScreen extends StatelessWidget {
//   const SignInScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(38.0),
//             child: TextField(
//               decoration: InputDecoration(
//                   hintText: "Geli Username ",
//                   border: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.black))),
//             ),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => DisplayData()),
//               );
//             },
//             child: Text("Ok"),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// //-----------------------------------------------//
class SignManager extends StatefulWidget {
  const SignManager({Key? key}) : super(key: key);

  @override
  _SignManagerState createState() => _SignManagerState();
}

class _SignManagerState extends State<SignManager> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Center(
              child: Consumer(
                builder: (context, watch, child) {
                  final signInWatch = watch(signInProvider);
                  return TextButton(
                      onPressed: () async {
                        final userID = await context
                            .read(signInProvider)
                            .signInWithGoogle();
                        print("HELLO::    ${userID.user!.uid}");
                        if (userID.user!.uid.isNotEmpty) {
                          signInWatch.saveUserUID(userID.user!.uid);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DisplayData()),

                            //TODO: Go to Service class write Storing Data Feature and Displaying Data Feature
                            //TODO: Delete The existing demo Data and Display The stored Data
                          );
                        }
                      },
                      child: Text("Sign In With google"));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
