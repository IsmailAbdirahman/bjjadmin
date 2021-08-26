import 'dart:developer';

import 'package:bjjapp/AddNewuser/add_new_user_state.dart';
import 'package:bjjapp/models/jumlo_history_model.dart';
import 'package:bjjapp/service/service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final jumloHistoryState = ChangeNotifierProvider<JumloHistoryState>((ref) {
  final id = ref.watch(addingNewUserProvider).userID;
  return JumloHistoryState(userID: id);
});

//--
class JumloHistoryState extends ChangeNotifier {
  String? userID;

  JumloHistoryState({this.userID});

  Service _service = Service();

  Stream<List<JumloHistoryModel>> getJumloHistoryStream({bool? isLoan}) {
    return _service.users
        .doc(userID)
        .collection("jumlo")
        .where("isLoan", isEqualTo: isLoan)
        .snapshots()
        .map(_service.getJumloSnapshot);
  }
}
