import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iot_app/my_wiget/data_num_fix.dart';
import 'package:iot_app/my_wiget/data_switch.dart';

class DashBoard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Divider(height: 40,),
        Wrap(
          spacing: 40, 
          runSpacing: 20, // FIXME: weird
          direction: Axis.horizontal,
          alignment: WrapAlignment.center,
          children: [
            DataNumFix(),
            DataNumFix(),
            DataNumFix(),
            DataNumFix(),
            DataNumFix(),
          ],
        ),
        Divider(height: 40,),
        Wrap(
          spacing: 40,
          runSpacing: 5,
          direction: Axis.horizontal,
          alignment: WrapAlignment.center,
          children: [
            DataSwitch(),
            DataSwitch(),
            DataSwitch(),
            DataSwitch(),
            DataSwitch(),
          ],
        ),
      ],
    );
    //TODO: this
  }
}
