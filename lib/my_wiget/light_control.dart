import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iot_app/my_wiget/container_wrapper.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class LightControl extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LightControlState();
}

class _LightControlState extends State<LightControl> {
  // TODO get data from server
  List<bool> _lightSate = [false, true];
  TimeOfDay _lightOnTime = TimeOfDay(hour: 12, minute: 12);
  List<bool> _lightOnAuto = [false, true];
  TimeOfDay _lightOffTime = TimeOfDay(hour: 12, minute: 12);
  List<bool> _lightOffAuto = [false, true];
  @override
  Widget build(BuildContext context) => DecoratedContainer(Column(
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
                onPressed: (i) {  // TODO update to server
                  setState(() {
                    if (i == 0) {
                      _lightSate = [true, false];
                    } else {
                      _lightSate = [false, true];
                    }
                  });
                },
              ),
              

            ],
          ),
          Divider(thickness: 1, height: 40,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Time on"),
              SizedBox(width: 10),
              ElevatedButton(
                
                onPressed: _pickTimeOn,
                child: Text("${_lightOnTime.hour} : ${_lightOnTime.minute}")),
              SizedBox(width: 10),
              ToggleButtons(
                children: [Icon(Icons.alarm), Icon(Icons.alarm_off)],
                isSelected: _lightOnAuto,
                onPressed: (i) { // TODO update to server
                  setState(() {
                    if (i == 0) {
                      _lightOnAuto = [true, false];
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
                child: Text("${_lightOffTime.hour} : ${_lightOffTime.minute}")),
              SizedBox(width: 10),
              ToggleButtons(
                children: [Icon(Icons.alarm), Icon(Icons.alarm_off)],
                isSelected: _lightOffAuto,
                onPressed: (i) { // TODO update to server
                  setState(() {
                    if (i == 0) {
                      _lightOffAuto = [true, false];
                    } else {
                      _lightOffAuto = [false, true];
                    }
                  });
                },
              )
            ],
          ),
        ],
      ));

  void _pickTimeOn() {
    DatePicker.showTimePicker(context, 
      showSecondsColumn: false,
      onConfirm: (dateTime) {
        setState(() {
          _lightOnTime = TimeOfDay.fromDateTime(dateTime);
        });
      }
    );
  }
  void _pickTimeOff() {
    DatePicker.showTimePicker(context, 
      showSecondsColumn: false,
      onConfirm: (dateTime) {
        setState(() {
          _lightOffTime = TimeOfDay.fromDateTime(dateTime);
        });
      }
    );
  }
}
