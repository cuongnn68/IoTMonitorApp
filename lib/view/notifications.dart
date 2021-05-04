import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  var tests = [
    "Test notification 1 Test notification 1 Test notification 1 Test notification 1 Test notification 1 Test notification 1 Test notification 1 ",
    "Test notification 22",
    "Test notification 3",
    "Test notification 14",
    "Test notification 5",
  ];
  @override
  Widget build(BuildContext context) {
    return ListView(
      // padding: EdgeInsets.all(15),
      children: tests
          .map((e) => Container(
                child: ListTile(
                  selected: false,
                  // contentPadding: EdgeInsets.all(8),
                  // minVerticalPadding: 8,
                  title: Text(e),
                  leading: Icon(
                    Icons.notifications_active,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow( // TODO fix this shit
                      color: Colors.grey[300].withOpacity(1),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(3, 4), // changes position of shadow
                    ),],
                  border: Border.all(width: 0.3),
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                ),
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
              ))
          .toList(),
    );
  }
}
