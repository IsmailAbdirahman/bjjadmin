import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'add_new_user_state.dart';

class AddNewUser extends ConsumerWidget {
  TextEditingController _newPhoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final newUserProvider = watch(addingNewUserProvider);
    return SafeArea(
      child: Scaffold(
        body: (Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(38.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _newPhoneNumberController,
                  decoration:
                      InputDecoration(hintText: "new id or phoneNumber"),
                )),
            TextButton(
                onPressed: () async {
                  await context
                      .read(addingNewUserProvider)
                      .addNewUser(_newPhoneNumberController.text);
                },
                child: Text("Create")),
          ],
        )),
      ),
    );
  }
}
