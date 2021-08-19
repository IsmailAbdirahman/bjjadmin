import 'package:bjjapp/history/history_screen.dart';
import 'package:bjjapp/models/users_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'add_new_user_state.dart';

class AddNewUser extends ConsumerWidget {
  TextEditingController _newPhoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final newUserProvider = watch(addingNewUserProvider);
    newUserProvider.userStatus();
    bool isBlocked = newUserProvider.isBlocked;

    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
        centerTitle: true,
      ),
      body: (Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(38.0),
              child: TextField(
                maxLength: 10,
                keyboardType: TextInputType.number,
                controller: _newPhoneNumberController,
                decoration: InputDecoration(hintText: "Enter Mobile Number",),
              )),
          TextButton(
              onPressed: () async {
                if (_newPhoneNumberController.text.length >= 10 &&
                    _newPhoneNumberController.text.length <= 10) {
                  await context
                      .read(addingNewUserProvider)
                      .addNewUser(_newPhoneNumberController.text, false);
                  _newPhoneNumberController.clear();
                  FocusScope.of(context).unfocus();
                }else{
                  Fluttertoast.showToast(
                      msg: "Mobile Numberka aad galisay sax ma ahan",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
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
    );
  }
}
