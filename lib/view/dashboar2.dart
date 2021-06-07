import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iot_app/my_wiget/block_info.dart';
import 'package:iot_app/my_wiget/light_control.dart';
import 'package:iot_app/my_wiget/temperature_control.dart';

class DashBoard2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DashBoard2State();
  }
}

class _DashBoard2State extends State<DashBoard2> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      children: [
        BlockInfo("1", "First name blah"),
        BlockInfo("2", "Rau bap cai"),
        BlockInfo("3", "rau ..."),
        BlockInfo("4", "other"),
        BlockInfo("5", "empty"),
        SizedBox(height: 12,),
      ],
    );
    // return ElevatedButton(
    //     onPressed: () => Navigator.of(context)
    //       .push(MaterialPageRoute(
    //         builder: (context) => Scaffold(
    //           appBar: AppBar(
    //             title: Text("test content"),
    //           ),
    //           body: ListView(
    //             children: [
    //               LightControl(),
    //               TemperatureControl(),
    //               TemperatureControl(),
    //               SizedBox(height: 12,),
    //             ],
    //           ),
    //         ))),
    //     child: Text("Test"));
  }
}
