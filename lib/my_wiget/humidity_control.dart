import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iot_app/model/data_model.dart';
import 'package:iot_app/model/humi_module_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'container_wrapper.dart';
import 'package:http/http.dart' as http;
import 'package:iot_app/globals.dart' as global;
import 'dart:convert';
import 'package:iot_app/model/storage.dart';

class HumidityControl extends StatefulWidget {
  int deviceId;
  HumidityControl(this.deviceId);

  @override
  _HumidityControlState createState() => _HumidityControlState();
}

class _HumidityControlState extends State<HumidityControl> with AutomaticKeepAliveClientMixin{
  int _humiValue;
  List<bool> _hourDayWeekOptions = [false, true];
  List<bool> _autoPump = [
    false,
    true,
  ];
  var _upperboundCtrl = TextEditingController();
  var _lowerboundCtrl = TextEditingController();

  var _humiData = <DataModel>[
    DataModel('Mon', 53),
    DataModel('Tue', 68),
    DataModel('Wed', 64),
    DataModel('Thu', 62),
    DataModel('Fri', 68),
    DataModel('Sat', 61),
    DataModel('Sun', 62),
  ];

  HumiModuleModel humiModule;
  Future<HumiModuleModel> futureModule;

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  Future<HumiModuleModel> getHumiModule() async {
    var myStorage = await Storage.getInstance();
    var res = await http.get(
      Uri.https(global.url, "api/device/${widget.deviceId}/humi"),
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
      return HumiModuleModel.fromJson(json);
    }
  }

  Future<List<DataModel>> getDayHumi() async {
    var myStorage = await Storage.getInstance();
    var res = await http.get(
      Uri.https(global.url, "api/device/${widget.deviceId}/humi/day"),
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

  Future<List<DataModel>> getWeekHumi() async {
    var myStorage = await Storage.getInstance();
    var res = await http.get(
      Uri.https(global.url, "api/device/${widget.deviceId}/humi/week"),
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
  void dispose() {
    super.dispose();
    _upperboundCtrl.dispose();
    _lowerboundCtrl.dispose();
  }

  @override
  void initState() {
    super.initState();
    getWeekHumi().then((value) => _humiData = value);
    futureModule = getHumiModule();
    futureModule.then((value) {
      _humiValue = value.value;
      _autoPump = List<bool>.from([value.auto, !value.auto]);
      _upperboundCtrl.text = value.upperbound.toString();
      _lowerboundCtrl.text = value.lowerbound.toString();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedContainer(FutureBuilder(
      future: futureModule,
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
                  Text("Humidity"),
                  Text(
                    // "30 ℃ (now)",
                    "$_humiValue % (now)",
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
                    // title: AxisTitle(text: "Humidity (%)", alignment: ChartAlignment.center),
                  ),
                  title: ChartTitle(text: "Humidity (%)"),
                  series: <ColumnSeries<DataModel, String>>[
                    ColumnSeries<DataModel, String>(
                      // Bind data source
                      dataSource: _humiData,
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
                    _humiData = await getDayHumi();
                    _hourDayWeekOptions = [true, false];
                  } else {
                    _humiData = await getWeekHumi();
                    _hourDayWeekOptions = [false, true];
                  }
                  setState(() {});
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
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ToggleButtons(
                children: [
                  Row(
                    children: [
                      SizedBox(width: 20),
                      Text("AUTO ON"),
                      SizedBox(width: 20),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width: 20),
                      Text("AUTO OFF"),
                      SizedBox(width: 20),
                    ],
                  ),
                ],
                isSelected: _autoPump,
                onPressed: (i) {
                  setState(() {
                    if (i == 0)
                      _autoPump = [true, false];
                    else
                      _autoPump = [false, true];
                  });
                },
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
                            "${_upperboundCtrl.text} không phải là số nguyên dương")));
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
                          global.url, "api/device/${widget.deviceId}/humi"),
                      headers: {
                        "Accept": "application/json",
                        "Content-Type": "application/json",
                        "Authorization": "bearer ${myStorage.getToken()}",
                      },
                      body: jsonEncode({
                        "auto": _autoPump.first,
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
