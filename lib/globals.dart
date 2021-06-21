import 'package:flutter/foundation.dart';
import 'package:flutter/src/painting/text_style.dart';
import 'package:intl/intl.dart';

// const url = "192.168.100.7:5001";
var url = kDebugMode ? "192.168.100.7:5001" : "iot-app-nnc.herokuapp.com";
final myTextStyle = TextStyle(
  fontSize: 18,
);

bool successStatus(int code) {
  return code >= 200 && code < 400;
}

var format = DateFormat("HH:mm");
