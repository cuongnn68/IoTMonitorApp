import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'container_wrapper.dart';

class TemperatureControl extends StatefulWidget {
  @override
  _TemperatureControlState createState() => _TemperatureControlState();
}

class _TemperatureControlState extends State<TemperatureControl> {
  List<bool> _hourDayWeekOptions = [false, true];
  List<bool> _autoPump = [
    false,
    true,
  ];
  var _upperboundCtrl = TextEditingController();
  var _lowerboundCtrl = TextEditingController();

  @override
  void dispose() {
    _upperboundCtrl.dispose();
    _lowerboundCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _upperboundCtrl.text = "0";
    _lowerboundCtrl.text = "0";

    return DecoratedContainer(Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("TEMPERATURE"),
            Text(
              "30 ℃ (now)",
            ),
          ],
        ),
        Divider(
          thickness: 1,
        ),
        SfCartesianChart(
            // Initialize category axis
            primaryXAxis: CategoryAxis(), // have to use this, dont know why
            primaryYAxis: NumericAxis(
              edgeLabelPlacement: EdgeLabelPlacement.shift,
              // title: AxisTitle(text: "Temperature (℃)", alignment: ChartAlignment.center),
            ),
            title: ChartTitle(text: "Temperature (℃)"),
            series: <ColumnSeries<TestData, String>>[
              ColumnSeries<TestData, String>(
                // Bind data source
                dataSource: <TestData>[
                  TestData('Mon', 35),
                  TestData('Tue', 28),
                  TestData('Wed', 34),
                  TestData('Thu', 32),
                  TestData('Fri', 38),
                  TestData('Sat', 31),
                  TestData('Sun', 22),
                ],
                xValueMapper: (TestData sales, _) => sales.name,
                yValueMapper: (TestData sales, _) => sales.value,
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
          onPressed: (i) {
            // TODO change grahp
            setState(() {
              for (int j = 0; j < 2; j++) {
                if (j == i)
                  _hourDayWeekOptions[j] = true;
                else
                  _hourDayWeekOptions[j] = false;
              }
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
          onPressed: () {
            if (_upperboundCtrl.text.isEmpty || _lowerboundCtrl.text.isEmpty) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("Điền dữ liệu")));
              return;
            }
            if (int.tryParse(_upperboundCtrl.text) == null) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("${_upperboundCtrl.text} ko phai la so")));
              return;
            }
            if (int.tryParse(_lowerboundCtrl.text) == null) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("${_lowerboundCtrl.text} ko phai la so")));
              return;
            }
          },
        ),
        SizedBox(
          height: 10,
        ),
      ],
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
