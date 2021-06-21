import 'dart:convert';
import 'package:iot_app/globals.dart' as global;
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iot_app/model/storage.dart';

class UpdateUserInfo extends StatefulWidget {
  @override
  _UpdateUserInfoState createState() => _UpdateUserInfoState();
}

class _UpdateUserInfoState extends State<UpdateUserInfo> {
  TextEditingController usernameCtrl = TextEditingController();
  TextEditingController fullNameCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();

  @override
  void dispose() {
    usernameCtrl.dispose();
    fullNameCtrl.dispose();
    phoneCtrl.dispose();
    emailCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    usernameCtrl.text = "test username";
    return Scaffold(
        appBar: AppBar(
          title: Text("Update user info"),
        ),
        body: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              usernameCtrl.text = snapshot.data["username"];
              fullNameCtrl.text = snapshot.data["fullName"];
              phoneCtrl.text = snapshot.data["phone"];
              emailCtrl.text = snapshot.data["email"];
              return Container(
                  alignment: Alignment.center,
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: 300,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("User info"),
                        TextField(
                          decoration: InputDecoration(
                            labelText: "Username",
                          ),
                          enabled: false,
                          controller: usernameCtrl,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            labelText: "Full name",
                          ),
                          controller: fullNameCtrl,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            labelText: "Phone number",
                          ),
                          controller: phoneCtrl,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            labelText: "Email",
                          ),
                          controller: emailCtrl,
                        ),
                        Divider(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: ElevatedButton(
                                child: Text("Update"),
                                onPressed: () async {
                                  print("pressed button updated");
                                  var myStorage = await Storage.getInstance();
                                  var res = await http.put(
                                      Uri.https(global.url,
                                          "/api/user/${myStorage.getUsername()}"),
                                      headers: {
                                        "Authorization":
                                            "Bearer ${myStorage.getToken()}",
                                        "Content-Type": "application/json",
                                        "Accept": "application/json",
                                      },
                                      body: jsonEncode({
                                        "username": usernameCtrl.text,
                                        "fullName": fullNameCtrl.text,
                                        "phoneNumber": phoneCtrl.text,
                                        "email": emailCtrl.text,
                                      }));
                                  print(res.statusCode);
                                  var mess = ScaffoldMessenger.of(context);
                                  if (global.successStatus(res.statusCode)) {
                                    mess.showSnackBar(SnackBar(
                                        content: Text("Updated success")));
                                    Navigator.of(context).pop();
                                  }
                                  mess.showSnackBar(
                                      SnackBar(content: Text("Error")));
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ));
            } else if (snapshot.hasError) {
              var mess = ScaffoldMessenger.of(context);
              mess.showSnackBar(SnackBar(content: Text("Error")));
              Navigator.of(context).pop();
              return Text("error");
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
          future: getUserInfo(),
        ));
  }

  Future<Map<String, String>> getUserInfo() async {
    var myStorage = await Storage.getInstance();
    var res = await http.get(
        Uri.https(global.url, "api/user/${myStorage.getUsername()}"),
        headers: {
          "Authorization": "bearer ${myStorage.getToken()}",
          "Accept": "application/json",
        });
    return Map<String, String>.from(jsonDecode(res.body));
  }
}
