import 'package:bjjapp/widgets/bottom_navigation_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'signin/signin_state.dart';
import 'signinScreen/sign_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: Consumer(builder: (context, watch, child) {
          final signInProviderWatch = watch(signInProvider);
          return FutureBuilder(
              future: signInProviderWatch.getUserUID(),
              builder: (BuildContext context, snapshot) {
                var uid = snapshot.data;
                if (uid != null) {
                  return DisplayData();
                } else {
                  return SignManager();
                }
              });
        }));
  }
}
