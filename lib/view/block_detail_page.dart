import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iot_app/my_wiget/light_control.dart';
import 'package:iot_app/my_wiget/temperature_control.dart';

class BlockDetailPage extends StatefulWidget {
  String id;
  String name;
  BlockDetailPage(this.id, this.name);
  @override
  _BlockDetailPageState createState() => _BlockDetailPageState();
}

class _BlockDetailPageState extends State<BlockDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: ListView(
        children: [
          LightControl(),
          TemperatureControl(),
          TemperatureControl(),
          SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}
