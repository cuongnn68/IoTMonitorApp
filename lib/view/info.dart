import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iot_app/my_wiget/container_wrapper.dart';
import 'package:iot_app/view/about.dart';
import 'package:iot_app/view/login.dart';
import 'package:iot_app/model/storage.dart';
import 'package:iot_app/view/update_user_info.dart';
// TODO user info

class Info extends StatelessWidget {
  ButtonStyle buttonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Colors.white), 
  );
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // ElevatedButton(
        //   onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => AboutPage())), 
        //   child: Text("About"), 

        // ),
        // ElevatedButton(
        //     onPressed: () {
        //       Navigator.push(
        //           context, MaterialPageRoute(builder: (_) => UpdateUserInfo()));
        //     },
        //     child: Text("Update user info")
        // ),
        // ElevatedButton(
        //     onPressed: () async {
        //       Navigator.of(context).pushAndRemoveUntil(
        //           MaterialPageRoute<void>(builder: (_) => LoginPage()),
        //           (route) => false);
        //       var myStorage = await Storage.getInstance();
        //       await myStorage.removeTokenUser();
        //     },
        //     child: Text("Logout")
        // ),
        DecoratedContainer(
          InkWell(
            child: Center(child: Text("About")),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => AboutPage())), 
          )
        ),
        DecoratedContainer(
          InkWell(
            child: Center(child: Text("Update user info")),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => UpdateUserInfo()));
            },
          )
        ),
        DecoratedContainer(
          InkWell(
            child: Center(child: Text("Logout")),
            onTap: () async {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute<void>(builder: (_) => LoginPage()),
                  (route) => false);
              var myStorage = await Storage.getInstance();
              await myStorage?.removeTokenUser();
            },
          )
        ),
      ],
    );
  }
}