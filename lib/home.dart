import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iot_app/view/dashboar2.dart';
import 'package:iot_app/view/dashboard.dart';
import 'package:iot_app/view/images_view.dart';
import 'package:iot_app/view/info.dart';
import 'package:iot_app/view/notifications.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _activedIndex = 0;
  var _wigets = <Widget>[
    DashBoard2(),
    // ImageView(),
    // Text("alert view"),
    Notifications(),
    Info(),
  ];
  var _titles = <Text>[
    Text("Bảng điều khiển"),
    // Text("Photo"),
    Text("Thống báo"),
    Text("Thong tin"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _titles[_activedIndex],
      ),
      body: _wigets[_activedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_remote),
            label: "Dashboard",
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.photo),
          //   label: "Photo",
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications), 
            label: "Notification",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt),
            label: "Info",
          ),
        ],
        currentIndex: _activedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: _onTapNavigation,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        
      ),
    );
  }

  _onTapNavigation(int newIndex) {
    setState(() {
      _activedIndex = newIndex;
    });
  }
}
