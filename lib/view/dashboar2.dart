import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iot_app/model/device_data_model.dart';
import 'package:iot_app/model/storage.dart';
import 'package:iot_app/my_wiget/block_info.dart';
import 'package:iot_app/my_wiget/light_control.dart';
import 'package:iot_app/my_wiget/temperature_control.dart';
import 'package:http/http.dart' as http;
import 'package:iot_app/globals.dart' as global;

class DashBoard2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DashBoard2State();
  }
}

class _DashBoard2State extends State<DashBoard2> {
  List<DeviceDataModel> devices;

  Future<List<DeviceDataModel>> getDeviceData() async {
    var myStorage = await Storage.getInstance();
    var res = await http.get(
        Uri.https(global.url, "api/user/${myStorage.getUsername()}/device"),
        headers: {
          "Authorization": "bearer ${myStorage.getToken()}",
          "Accept": "application/json",
        });
    if (!global.successStatus(res.statusCode)) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error")));
    }
    var jsonDevice =
        Map<String, List<dynamic>>.from(jsonDecode(res.body))["devices"];
    return jsonDevice.map((value) => DeviceDataModel.fromJson(value)).toList();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder(
      future: getDeviceData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          devices = snapshot.data;
          return ListView(
            children: [
              for (var device in devices)
                BlockInfo(
                  device.id,
                  device.name,
                  hasLight: device.hasLightModule,
                  hasTemp: device.hasTempModule,
                  hasHumi: device.hasHumiModule,
                  lightState: device.lightState,
                  temp: device.tempValue,
                  humi: device.humiValue,
                ),
              // BlockInfo(1, "First name blah",hasLight: true, lightState: false,),
              // BlockInfo(2, "Rau bap cai", hasTemp: true, hasHumi: true, temp: 30, humi: 70,),
              // BlockInfo(3, "rau ..."),
              // BlockInfo(4, "other"),
              // BlockInfo(5, "empty"),
              SizedBox(
                height: 12,
              ),
            ],
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
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
