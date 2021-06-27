import 'package:bjjapp/service/local_storage.dart';
import 'package:bjjapp/signin/sign_with_google.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signInProvider =
    ChangeNotifierProvider<SignInState>((ref) => SignInState());

//--
class SignInState extends ChangeNotifier {
  SignInWithGoogle _signInWithGoogle = SignInWithGoogle();
  SharedPref _sharedPref = SharedPref();

  Future<UserCredential> signInWithGoogle() async {
    return await _signInWithGoogle.signInWithGoogle();
  }

  Future signOut() async {
    await clearUID();
    return await _signInWithGoogle.signOut();
  }

  void saveUserUID(String userUID) async {
    _sharedPref.saveUserUID(userUID);
  }

  Future<String> getUserUID() async {
    return await _sharedPref.getUserUID();
  }

  clearUID() async {
    return await _sharedPref.clearUID();
  }
}
