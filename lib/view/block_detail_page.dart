import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iot_app/my_wiget/humidity_control.dart';
import 'package:iot_app/my_wiget/light_control.dart';
import 'package:iot_app/my_wiget/temperature_control.dart';

class BlockDetailPage extends StatefulWidget {
  int deviceId;
  String name;
  bool hasLight;
  bool hasTemp;
  bool hasHumi;
  BlockDetailPage(this.deviceId, this.name, this.hasLight, this.hasTemp, this.hasHumi);
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
          if(this.widget.hasLight) LightControl(this.widget.deviceId),
          if(this.widget.hasTemp) TemperatureControl(),
          if(this.widget.hasHumi) HumidityControl(),
          SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}
