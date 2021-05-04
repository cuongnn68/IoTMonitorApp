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
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: Offset(1, 3), // changes position of shadow
                    ),],
                  border: Border.all(width: 1.2),
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                ),
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
              ))
          .toList(),
    );
  }
}
