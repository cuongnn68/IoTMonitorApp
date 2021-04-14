import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iot_app/globals.dart' as global;

class DataNumFix extends StatelessWidget {
  String _name;
  String _value;
  DataNumFix(String name, String value)
      : _name = name,
        _value = value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "$_name: ",
          style: global.myTextStyle,
        ),
        Text(
          _value,
          style: TextStyle(fontSize: 19, backgroundColor: Colors.grey),
        )
        // TextField(
        //   maxLength: 10,
        //   style: global.myTextStyle,
        // ),
      ],
    );
  }
}
