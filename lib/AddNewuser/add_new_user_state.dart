import 'package:bjjapp/service/service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final addingNewUserProvider = ChangeNotifierProvider((ref) => AddNewUserState());

//--
class AddNewUserState extends ChangeNotifier {
  Service _service = Service();

  addNewUser(String phoneNumber) async {
    return await _service.addNewUser(phoneNumber);
  }

  // getUsersInfo(String registeredPhoneNumber, BuildContext context) {
  //   return _service.getUsersInfo(registeredPhoneNumber, context);

  //}
}
