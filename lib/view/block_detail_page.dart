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
  BlockDetailPage(
      this.deviceId, this.name, this.hasLight, this.hasTemp, this.hasHumi);
  @override
  _BlockDetailPageState createState() => _BlockDetailPageState();
}

class _BlockDetailPageState extends State<BlockDetailPage> {
  var _widgetList = <Widget>[];
  @override
  void initState() {
    super.initState();
    // if (widget.hasLight) _widgetList.add(LightControl(widget.deviceId));
    // if (widget.hasTemp) _widgetList.add(TemperatureControl(widget.deviceId));
    // if (widget.hasHumi) _widgetList.add(HumidityControl(widget.deviceId));
    // _widgetList.add(
    //   SizedBox(
    //     height: 12,
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: ListView(
        addAutomaticKeepAlives: true,
        
        children:
        [
          if (widget.hasLight) LightControl(widget.deviceId),
          if (widget.hasTemp) TemperatureControl(widget.deviceId),
          if (widget.hasHumi) HumidityControl(widget.deviceId),
          SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}
