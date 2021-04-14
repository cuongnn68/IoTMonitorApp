import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iot_app/globals.dart' as global;

class DataSwitch extends StatefulWidget {
  bool _status;
  String _name;
  Future<void> Function(bool) _onPress;
  DataSwitch(String name, bool status, Future<void> Function(bool) onPress)
      : _name = name,
        _status = status,
        _onPress = onPress;
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
          widget._name,
          style: global.myTextStyle,
        ),
        Transform.scale(
          scale: 1.2,
          child: Switch(
            value: this.widget._status,
            // onChanged: widget._onPress,
            onChanged: (_) {
              widget._onPress(!this.widget._status); //TODO check this one if its synchronized with multi devices
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
