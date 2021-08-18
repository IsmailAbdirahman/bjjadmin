import 'package:bjjapp/history/history_screen.dart';
import 'package:bjjapp/models/users_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'add_new_user_state.dart';

class AddNewUser extends ConsumerWidget {
  TextEditingController _newPhoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final newUserProvider = watch(addingNewUserProvider);
    newUserProvider.userStatus();
    bool isBlocked = newUserProvider.isBlocked;

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
                      .addNewUser(_newPhoneNumberController.text, false);
                  FocusScope.of(context).unfocus();
                },
                child: Text("Create")),
            Expanded(
              child: StreamBuilder<List<UserInfo>>(
                  stream: newUserProvider.getPhoneNumberStream,
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.hasData) {
                      var userInfoList = snapshot.data;
                      return ListView.builder(
                          itemCount: userInfoList!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HistoryScreen(
                                                userID: userInfoList[index]
                                                    .phoneNumber!,
                                              )));
                                },
                                title: Text(userInfoList[index].phoneNumber!),
                                subtitle: Divider(),
                                trailing: InkWell(
                                  onTap: () {
                                    newUserProvider.blockUnblockUser(
                                        userInfoList[index].phoneNumber!,
                                        isBlocked);
                                  },
                                  child: Icon(
                                    Icons.block,
                                    color: userInfoList[index].isBlocked!
                                        ? Colors.red
                                        : Colors.green,
                                  ),
                                ),
                              ),
                            );
                          });
                    }
                    return Center(child: CircularProgressIndicator());
                  }),
            ),
          ],
        )),
      ),
    );
  }
}
