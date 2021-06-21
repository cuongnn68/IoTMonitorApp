import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'container_wrapper.dart';

class HumidityControl extends StatefulWidget {
  @override
  _HumidityControlState createState() => _HumidityControlState();
}

class _HumidityControlState extends State<HumidityControl> {
  List<bool> _hourDayWeekOptions = [false, true];
  List<bool> _upperBoundAlert = [true, false,];
  List<bool> _lowerBoundAlert = [true, false,];
  @override
  Widget build(BuildContext context) {
    return DecoratedContainer(Column(
      children: [
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Humidity"),
            Text("70 % (now)",),
          ],
        ),
        Divider(thickness: 1,),
        SfCartesianChart(
            // Initialize category axis
            primaryXAxis: CategoryAxis(), // have to use this, dont know why
            primaryYAxis: NumericAxis(
              edgeLabelPlacement: EdgeLabelPlacement.shift,
            ),
            title: ChartTitle(text: "Humidity (%)"),
            series: <ColumnSeries<TestData, String>>[
              ColumnSeries<TestData, String>(
                // Bind data source
                dataSource: <TestData>[
                  TestData('Mon', 60),
                  TestData('Tue', null),
                  TestData('Wed', 60),
                  TestData('Thu', 60),
                  TestData('Fri', null),
                  TestData('Sat', 60),
                  TestData('Sun', 61),
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
            Text("TODO number picker"),
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
            Text("TODO number picker"),
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
