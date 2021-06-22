import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../home.dart';
import '../globals.dart' as global;
import '../model/storage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  void dispose() {
    usernameCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          // padding: EdgeInsets.all(60),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: 300,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Đăng nhập"),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Username",
                  ),
                  controller: usernameCtrl,
                ),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                  ),
                  controller: passwordCtrl,
                ),
                Divider(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                          child: Text("Login"),
                          onPressed: () async {
                            var mess = ScaffoldMessenger.of(context);
                            if (usernameCtrl.text.isEmpty ||
                                passwordCtrl.text.isEmpty) {
                              mess.hideCurrentSnackBar();
                              mess.showSnackBar(SnackBar(
                                  content: Text("Input username & password")));
                              return;
                            }
                            // TODO
                            var myStorage = await Storage.getInstance();
                            var res = await http.post(
                                Uri.https(global.url, "api/auth/user-token"),
                                headers: {
                                  "Accept": "application/json",
                                  "Content-Type": "application/json",
                                },
                                body: jsonEncode({
                                  "username": usernameCtrl.text,
                                  "password": passwordCtrl.text
                                }));
                            var jsonRes =
                                Map<String, String>.from(jsonDecode(res.body));
                            if (global.successStatus(res.statusCode)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      // content: Text(jsonRes["userToken"])));
                                      content: Text("Logined !")));
                              // TODO
                              myStorage?.setToken(jsonRes["userToken"]);
                              myStorage?.setUsername(usernameCtrl.text);
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute<void>(builder: (_) => Home()),
                                (route) => false);
                            } else {
                              String error;
                              if (jsonRes.containsKey("error")) {
                                error = jsonRes["error"];
                              } else {
                                error = "Cant login";
                              }
                              mess.showSnackBar(SnackBar(content: Text(error)));
                            }

                          }),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
