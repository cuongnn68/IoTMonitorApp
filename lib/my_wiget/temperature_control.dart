import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iot_app/model/data_model.dart';
import 'package:iot_app/model/temp_module_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;
import 'package:iot_app/globals.dart' as global;
import 'container_wrapper.dart';
import 'package:iot_app/model/storage.dart';

class TemperatureControl extends StatefulWidget {
  int deviceId;
  TemperatureControl(this.deviceId);
  @override
  _TemperatureControlState createState() => _TemperatureControlState();
}

class _TemperatureControlState extends State<TemperatureControl> {
  int _tempValue = 33;
  List<bool> _hourDayWeekOptions = [false, true];
  List<bool> _upperBoundAlert = [
    true,
    false,
  ];
  List<bool> _lowerBoundAlert = [
    true,
    false,
  ];

  var _upperboundCtrl = TextEditingController();
  var _lowerboundCtrl = TextEditingController();

  Future<TempModuleModel> futureTempModule;
  TempModuleModel tempModule;

  var _tempData = <DataModel>[
    DataModel('Mon', 30),
    DataModel('Tue', null),
    DataModel('Wed', 31),
    DataModel('Thu', 32),
    DataModel('Fri', null),
    DataModel('Sat', 33),
    DataModel('Sun', 34),
  ];

  @override
  void dispose() {
    _upperboundCtrl.dispose();
    _lowerboundCtrl.dispose();
    super.dispose();
  }

  Future<TempModuleModel> getTempModule() async {
    var myStorage = await Storage.getInstance();
    var res = await http.get(
      Uri.https(global.url, "api/device/${widget.deviceId}/temp"),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "bearer ${myStorage.getToken()}",
      },
    );
    if (!global.successStatus(res.statusCode)) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error")));
      Navigator.of(context).pop();
      return null;
    } else {
      var json = Map<String, dynamic>.from(jsonDecode(res.body));
      return TempModuleModel.fromJson(json);
    }
  }

  Future<List<DataModel>> getDayTemp() async {
    var myStorage = await Storage.getInstance();
    var res = await http.get(
      Uri.https(global.url, "api/device/${widget.deviceId}/temp/day"),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "bearer ${myStorage.getToken()}",
      },
    );
    if (!global.successStatus(res.statusCode)) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error")));
      Navigator.of(context).pop();
      return null;
    } else {
      var jsonData =
          Map<String, List<dynamic>>.from(jsonDecode(res.body))["data"];
      return jsonData.map<DataModel>((e) => DataModel.fromJson(e)).toList();
      // return TempModuleModel.fromJson(json);
    }
  }

  Future<List<DataModel>> getWeekTemp() async {
    var myStorage = await Storage.getInstance();
    var res = await http.get(
      Uri.https(global.url, "api/device/${widget.deviceId}/temp/week"),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "bearer ${myStorage.getToken()}",
      },
    );
    if (!global.successStatus(res.statusCode)) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error")));
      Navigator.of(context).pop();
      return null;
    } else {
      var jsonData =
          Map<String, List<dynamic>>.from(jsonDecode(res.body))["data"];
      return jsonData.map<DataModel>((e) => DataModel.fromJson(e)).toList();
    }
  }

  @override
  void initState() {
    super.initState();
    getWeekTemp().then((value) => _tempData = value);
    futureTempModule = getTempModule();
    futureTempModule.then((value) {
      tempModule = value;
      _tempValue = value.value;
      _upperboundCtrl.text = value.upperbound.toString();
      _lowerboundCtrl.text = value.lowerbound.toString();
      _upperBoundAlert =
          List<bool>.from([value.upperAlertOptions, !value.upperAlertOptions]);
      _lowerBoundAlert =
          List<bool>.from([value.lowerAlertOptions, !value.lowerAlertOptions]);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedContainer(FutureBuilder(
      future: futureTempModule,
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Temperature"),
                  Text(
                    "$_tempValue ℃ (now)",
                  ),
                ],
              ),
              Divider(
                thickness: 1,
              ),
              SfCartesianChart(
                  // Initialize category axis
                  primaryXAxis:
                      CategoryAxis(), // have to use this, dont know why

                  primaryYAxis: NumericAxis(
                    edgeLabelPlacement: EdgeLabelPlacement.shift,
                    // visibleMinimum: 0,
                    // majorGridLines: MajorGridLines(
                    //   width: 1,
                    //   color: Colors.red,
                    //   // dashArray: <double>[5,5]
                    // ),
                    // minorGridLines: MinorGridLines(
                    //   width: 1,
                    //   color: Colors.green,
                    //   // dashArray: <double>[5,5]
                    // ),

                  ),
                  title: ChartTitle(text: "Temperature (%)"),

                  series: <ColumnSeries<DataModel, String>>[
                    ColumnSeries<DataModel, String>(
                      // Bind data source
                      dataSource: _tempData,
                      xValueMapper: (DataModel sales, _) => sales.time,
                      yValueMapper: (DataModel sales, _) => sales.value,
                      dataLabelSettings: DataLabelSettings(isVisible: true),
                      color: Theme.of(context).primaryColor,
                    )
                  ]),
              ToggleButtons(
                children: [
                  Text("Day"),
                  Text("Week"),
                ],
                isSelected: _hourDayWeekOptions,
                onPressed: (i) async {
                  // TODO change grahp
                  if (i == 0) {
                    _tempData = await getDayTemp();
                    _hourDayWeekOptions = [true, false];
                  } else {
                    _tempData = await getWeekTemp();
                    _hourDayWeekOptions = [false, true];
                  }

                  setState(() {
                  });
                },
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 1,
              ),
              SizedBox(
                height: 10,
              ),
              Text("Setting"),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Above:"),
                  Container(
                    width: 200,
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "Upper bound",
                      ),
                      controller: _upperboundCtrl,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  ToggleButtons(
                    children: [
                      Icon(Icons.notifications_active_outlined),
                      Icon(Icons.notifications_off_outlined),
                    ],
                    isSelected: _upperBoundAlert,
                    onPressed: (i) {
                      setState(() {
                        if (i == 0)
                          _upperBoundAlert = [true, false];
                        else
                          _upperBoundAlert = [false, true];
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Below:"),
                  Container(
                    width: 200,
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "Lower bound",
                      ),
                      controller: _lowerboundCtrl,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  ToggleButtons(
                    children: [
                      Icon(Icons.notifications_active_outlined),
                      Icon(Icons.notifications_off_outlined),
                    ],
                    isSelected: _lowerBoundAlert,
                    onPressed: (i) {
                      setState(() {
                        if (i == 0)
                          _lowerBoundAlert = [true, false];
                        else
                          _lowerBoundAlert = [false, true];
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
                child: Text("Update setting"),
                onPressed: () async {
                  if (_upperboundCtrl.text.isEmpty ||
                      _lowerboundCtrl.text.isEmpty) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("Điền dữ liệu")));
                    return;
                  }
                  if (int.tryParse(_upperboundCtrl.text) == null ||
                      int.parse(_upperboundCtrl.text) < 0) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            "${_upperboundCtrl.text}  không phải là số nguyên dương")));
                    return;
                  }
                  if (int.tryParse(_lowerboundCtrl.text) == null ||
                      int.parse(_lowerboundCtrl.text) < 0) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            "${_lowerboundCtrl.text} không phải là số nguyên dương")));
                    return;
                  }
                  var myStorage = await Storage.getInstance();
                  var res = await http.put(
                      Uri.https(
                          global.url, "api/device/${widget.deviceId}/temp"),
                      headers: {
                        "Accept": "application/json",
                        "Content-Type": "application/json",
                        "Authorization": "bearer ${myStorage.getToken()}",
                      },
                      body: jsonEncode({
                        "upperAlertOptions": _upperBoundAlert.first,
                        "lowerAlertOptions": _lowerBoundAlert.first,
                        "upperbound": int.parse(_upperboundCtrl.text),
                        "lowerbound": int.parse(_lowerboundCtrl.text),
                      }));
                  if (!global.successStatus(res.statusCode)) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("Error")));
                  } else {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("Update !")));
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
            ],
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    ));
  }
}

class TestData {
  String _name;
  String get name => _name;
  double _value;
  double get value => _value;

  TestData(String name, double value)
      : _name = name,
        _value = value;
}
