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
  List<bool> _upperBoundAlert = [true, false,];
  List<bool> _lowerBoundAlert = [true, false,];

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
    return DecoratedContainer(Column(
      children: [
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Temperature"),
            Text("30 ℃ (now)",),
          ],
        ),
        Divider(thickness: 1,),
        SfCartesianChart(
            // Initialize category axis
            primaryXAxis: CategoryAxis(), // have to use this, dont know why
            primaryYAxis: NumericAxis(
              edgeLabelPlacement: EdgeLabelPlacement.shift,
            ),
            title: ChartTitle(text: "Temperature (%)"),
            series: <ColumnSeries<TestData, String>>[
              ColumnSeries<TestData, String>(
                // Bind data source
                dataSource: <TestData>[
                  TestData('Mon', 30),
                  TestData('Tue', null),
                  TestData('Wed', 31),
                  TestData('Thu', 32),
                  TestData('Fri', null),
                  TestData('Sat', 33),
                  TestData('Sun', 34),
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
          onPressed: (i) { // TODO change grahp
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
        SizedBox(height: 10,),
        Divider(thickness: 1,),
        SizedBox(height: 10,),
        Text("Setting"),
        SizedBox(height: 10,),
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
                  if(i == 0) _upperBoundAlert = [true, false];
                  else _upperBoundAlert = [false, true];
                });
              },
            ),
          ],
        ),
        SizedBox(height: 10,),
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
                  if(i == 0) _lowerBoundAlert = [true, false];
                  else _lowerBoundAlert = [false, true];
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
          onPressed: () {
            if (_upperboundCtrl.text.isEmpty || _lowerboundCtrl.text.isEmpty) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("Điền dữ liệu")));
              return;
            }
            if (int.tryParse(_upperboundCtrl.text) == null) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("${_upperboundCtrl.text} không phải là chữ số")));
              return;
            }
            if (int.tryParse(_lowerboundCtrl.text) == null) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("${_lowerboundCtrl.text} ko phai la so")));
              return;
            }
          },
        ),

        SizedBox(height: 10,),
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
