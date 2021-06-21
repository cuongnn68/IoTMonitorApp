import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iot_app/my_wiget/data_num_fix.dart';
import 'package:iot_app/my_wiget/data_switch.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:iot_app/globals.dart';

class DashBoard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  HubConnection _connection;
  var _boolState = Map<String, bool>();
  var _stringState = Map<String, String>();

  @override
  void initState() {
    super.initState();
    var updateState = (List<dynamic> args) {
      setState(() {
        _boolState = Map<String, bool>.from(args[0]);
        _stringState = Map<String, String>.from(args[1]);
      });
      print("done??");
    };
    _initSignalr(updateState);
  }

  Future<void> _initSignalr(void Function(List<dynamic>) updateState) async {
    _connection = HubConnectionBuilder()
        .withUrl(Uri.https(url, "/realtime").toString())
        .withAutomaticReconnect()
        .build();
    await _connection?.start();
    _connection..on(
        "test",
        (arguments) => print(arguments.toString() +
            " (recived on mobile: ${DateTime.now().toString()}) "));
    _connection?.on("updateState", updateState);
    _connection
      ..send(methodName: "getUpdate", args: [])
      ..send(
          methodName: "test",
          args: [" (send on mobile: ${DateTime.now().toString()}) "]);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // ElevatedButton(
        //   child: Text("Test"),
        //   onPressed: () => _connection.send(methodName: "Test", args: [" this from mobile "]),
        // ),
        Divider(
          height: 40,
        ),
        Wrap(
          spacing: 40,
          runSpacing: 20,
          direction: Axis.horizontal,
          alignment: WrapAlignment.center,
          children: [
            if (_stringState != null && _stringState.isNotEmpty)
              for (MapEntry<String, String> state in _stringState.entries)
                DataNumFix(state.key, " ${state.value} ")
          ],
        ),
        Divider(
          height: 40,
        ),
        Wrap(
          spacing: 40,
          runSpacing: 5,
          direction: Axis.horizontal,
          alignment: WrapAlignment.center,
          children: [
            if (_boolState != null && _boolState.isNotEmpty)
              for (MapEntry<String, bool> state in _boolState.entries)
                DataSwitch(
                    state.key,
                    state.value,
                    (bool newValue) => _connection.send(
                        methodName: "ChangeStateBool",
                        args: [state.key, newValue]))
          ],
        ),
      ],
    );
    //TODO: this
  }
}
