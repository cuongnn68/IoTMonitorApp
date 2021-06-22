import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iot_app/model/light_module_model.dart';
import 'package:iot_app/my_wiget/container_wrapper.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http/http.dart' as http;
import 'package:iot_app/model/storage.dart';
import 'package:iot_app/globals.dart' as global;
import 'dart:convert';
import 'package:intl/intl.dart';

class LightControl extends StatefulWidget {
  int deviceId;
  LightControl(this.deviceId);

  @override
  State<StatefulWidget> createState() => _LightControlState();
}

class _LightControlState extends State<LightControl> with AutomaticKeepAliveClientMixin{
  // TODO get data from server
  List<bool> _lightSate = [false, true];
  TimeOfDay _lightOnTime = TimeOfDay(hour: 18, minute: 0);
  List<bool> _lightOnAuto = [false, true];
  TimeOfDay _lightOffTime = TimeOfDay(hour: 7, minute: 0);
  List<bool> _lightOffAuto = [false, true];
  List<bool> _lightAutoOnOff = [false, true];
  LightModuleModel device;

  Future<LightModuleModel> futureDevice;

  Future<LightModuleModel> getLightState() async {
    var myStorage = await Storage.getInstance();
    var res = await http.get(
        Uri.https(global.url, "api/device/${this.widget.deviceId}/light"),
        headers: {
          "Authorization": "bearer ${myStorage.getToken()}",
          "Accept": "application/json",
        });
    var json = Map<String, dynamic>.from(jsonDecode(res.body));
    return LightModuleModel.fromJson(json);
    // return jsonDevice.map((value) => DeviceDataModel.fromJson(value)).toList();
  }

  
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    futureDevice = getLightState();
    futureDevice.then((value) {
      _lightSate = List<bool>.from([value.lightState, !value.lightState]);
      _lightOnAuto =
          List<bool>.from([value.lightOnOption, !value.lightOnOption]);
      _lightOffAuto =
          List<bool>.from([value.lightOffOption, !value.lightOnOption]);
      _lightOnTime = TimeOfDay.fromDateTime(value.timeOn);
      _lightOffTime = TimeOfDay.fromDateTime(value.timeOff);
      _lightAutoOnOff = List<bool>.from([value.auto, !value.auto]);
    });
  }

  @override
  Widget build(BuildContext context) => DecoratedContainer(
        FutureBuilder(
          future: futureDevice,
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              device = snapshot.data as LightModuleModel;
              return Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("LIGHT CONTROL"), // TODO style
                      SizedBox(width: 10),
                      ToggleButtons(
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 10),
                              Icon(Icons.lightbulb),
                              SizedBox(width: 10),
                              Text("ON"),
                              SizedBox(width: 20),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(width: 10),
                              Icon(Icons.lightbulb_outline),
                              SizedBox(width: 10),
                              Text("OFF"),
                              SizedBox(width: 20),
                            ],
                          ),
                        ],
                        isSelected: _lightSate,
                        onPressed: (i) async {
                          // TODO update to server
                          var myStorage = await Storage.getInstance();
                          var res = await http.post(
                              Uri.https(global.url,
                                  "api/device/${this.widget.deviceId}/light"),
                              headers: {
                                "Accept": "application/json",
                                "Content-Type": "application/json",
                                "Authorization":
                                    "bearer ${myStorage.getToken()}",
                              },
                              body: jsonEncode({
                                "state": (i == 0 ? true : false),
                              }));
                          if (global.successStatus(res.statusCode)) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Đã gửi lệnh điều khiển")));
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text("Error")));
                          }
                          if (i == 0) {
                            _lightSate = [true, false];
                          } else {
                            _lightSate = [false, true];
                          }
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1,
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Time on"),
                      SizedBox(width: 10),
                      ElevatedButton(
                          onPressed: _pickTimeOn,
                          child: Text(
                              "${_lightOnTime.hour} : ${_lightOnTime.minute}")),
                      SizedBox(width: 10),
                      ToggleButtons(
                        children: [Icon(Icons.alarm), Icon(Icons.alarm_off)],
                        isSelected: _lightOnAuto,
                        onPressed: (i) {
                          // TODO update to server
                          setState(() {
                            if (i == 0) {
                              _lightOnAuto = [true, false];
                              _lightAutoOnOff = [false, true];
                            } else {
                              _lightOnAuto = [false, true];
                            }
                          });
                        },
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Time off"),
                      SizedBox(width: 10),
                      ElevatedButton(
                          onPressed: _pickTimeOff,
                          child: Text(
                              "${_lightOffTime.hour} : ${_lightOffTime.minute}")),
                      SizedBox(width: 10),
                      ToggleButtons(
                        children: [Icon(Icons.alarm), Icon(Icons.alarm_off)],
                        isSelected: _lightOffAuto,
                        onPressed: (i) {
                          // TODO update to server
                          setState(() {
                            if (i == 0) {
                              _lightOffAuto = [true, false];
                              _lightAutoOnOff = [false, true];
                            } else {
                              _lightOffAuto = [false, true];
                            }
                          });
                        },
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Auto switch light:"), // TODO style
                      SizedBox(width: 10),
                      ToggleButtons(
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 10),
                              Icon(Icons.flash_auto),
                              SizedBox(width: 10),
                              Text("ON"),
                              SizedBox(width: 20),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(width: 10),
                              Icon(Icons.flash_auto),
                              SizedBox(width: 10),
                              Text("OFF"),
                              SizedBox(width: 20),
                            ],
                          ),
                        ],
                        isSelected: _lightAutoOnOff,
                        onPressed: (i) {
                          // TODO update to server
                          setState(() {
                            if (i == 0) {
                              _lightAutoOnOff = [true, false];
                              _lightOnAuto = [false, true];
                              _lightOffAuto = [false, true];
                            } else {
                              _lightAutoOnOff = [false, true];
                            }
                          });
                        },
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1,
                    height: 40,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      var myStorage = await Storage.getInstance();
                      var res = await http.put(
                          Uri.https(global.url,
                              "api/device/${this.widget.deviceId}/light"),
                          headers: {
                            "Accept": "application/json",
                            "Content-Type": "application/json",
                            "Authorization": "bearer ${myStorage.getToken()}",
                          },
                          body: jsonEncode({
                            "TimeOn": DateFormat("HH:mm").format(DateTime(
                                0,
                                0,
                                0,
                                this._lightOnTime.hour,
                                this._lightOnTime.minute)),
                            "TimeOff": DateFormat("HH:mm").format(DateTime(
                                0,
                                0,
                                0,
                                this._lightOffTime.hour,
                                this._lightOffTime.minute)),
                            "TimeOnOption": this._lightOnAuto.first,
                            "TimeOffOption": this._lightOffAuto.first,
                            "Auto": this._lightAutoOnOff.first,
                          }));
                      var messenger = ScaffoldMessenger.of(context);
                      if (global.successStatus(res.statusCode)) {
                        messenger
                            .showSnackBar(SnackBar(content: Text("Updated !")));
                      } else {
                        messenger
                            .showSnackBar(SnackBar(content: Text("Error")));
                      }
                    },
                    child: Text("Update"),
                  ),
                  SizedBox(height: 10),
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      );

  void _pickTimeOn() {
    DatePicker.showTimePicker(context, showSecondsColumn: false,
        onConfirm: (dateTime) {
      setState(() {
        _lightOnTime = TimeOfDay.fromDateTime(dateTime);
      });
    });
  }

  void _pickTimeOff() {
    DatePicker.showTimePicker(context, showSecondsColumn: false,
        onConfirm: (dateTime) {
      setState(() {
        _lightOffTime = TimeOfDay.fromDateTime(dateTime);
      });
    });
  }

}
