import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iot_app/globals.dart' as global;

class DataSwitch extends StatefulWidget {
  bool _status = true;
  String _name;
  @override
  State<StatefulWidget> createState() => _DataSwitchState();
}

class _DataSwitchState extends State<DataSwitch> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Trạng thái test",
          style: global.myTextStyle,
        ),
        Transform.scale(
          scale: 1.2,
          child: Switch(
            value: this.widget._status,
            onChanged: (_) {
              setState(() {
                this.widget._status = !this.widget._status;
              });
            },
          ),
        )
      ],
    );
  }
}
