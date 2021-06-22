import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iot_app/model/notification_model.dart';
import 'package:iot_app/my_wiget/container_wrapper.dart';
import 'package:iot_app/globals.dart' as global;
import 'package:http/http.dart' as http;
import 'package:iot_app/model/storage.dart';
import 'dart:convert';

class Notifications extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  var notifications = [
    NotificationModel("content", "time"),
    NotificationModel("content", "time"),
    NotificationModel("content", "time"),
    NotificationModel("content", "time"),
    NotificationModel("content", "time"),
  ];

  Future<List<NotificationModel>> getNotification() async {
    var myStorage = await Storage.getInstance();
    var res = await http.get(
      Uri.https(global.url, "api/user/${myStorage.getUsername()}/notification"),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "bearer ${myStorage.getToken()}",
      },
    );
    if (!global.successStatus(res.statusCode)) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error")));
      return null;
    } else {
      var notiListJson =
          Map<String, List<dynamic>>.from(jsonDecode(res.body))["notification"];
      return notiListJson.map((e) => NotificationModel.fromJson(e)).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getNotification(),
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          notifications = snapshot.data;
          return ListView(
            // padding: EdgeInsets.all(15),
            children: notifications
                .map((noti) => DecoratedContainer(ListTile(
                      selected: false,
                      title: Text(noti.content),
                      subtitle: Text(noti.time),
                      leading: Icon(Icons.notifications_active),
                    )))
                .toList(),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    );
  }
}
