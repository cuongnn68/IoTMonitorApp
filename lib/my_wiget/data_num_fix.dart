import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iot_app/globals.dart' as global;

class DataNumFix extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DataNumFixState();
}

class _DataNumFixState extends State<DataNumFix> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Test thông số: ",
          style: global.myTextStyle,
        ),
        Text(
          " 123 ",
          style: TextStyle(
            fontSize: 19,
            backgroundColor: Colors.grey
          ),
        )
        // TextField(
        //   maxLength: 10, 
        //   style: global.myTextStyle,
        // ),
      ],
    );
  }
}
