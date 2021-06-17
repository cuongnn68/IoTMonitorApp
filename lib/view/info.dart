import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iot_app/view/login.dart';
import 'package:iot_app/model/storage.dart';
import 'package:iot_app/view/update_user_info.dart';
// TODO user info

class Info extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => UpdateUserInfo()));
            },
            child: Text("Update user info")),
        ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute<void>(builder: (_) => LoginPage()),
                  (route) => false);
              var myStorage = await Storage.getInstance();
              await myStorage.removeTokenUser();
            },
            child: Text("Logout")),
        Text(
          "App lam bang flutter + dart",
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
        Image.asset("images/flutter.jpeg"),
        Text(""),
        Text(""),
        Text(
          "Server lam bang dotnet 5",
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
        Image.asset("images/dotnet-5.jpg"),
      ],
    );
  }
}
