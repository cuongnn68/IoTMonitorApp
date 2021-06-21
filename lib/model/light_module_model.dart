import 'package:iot_app/globals.dart' as global;

class LightModuleModel {
  bool lightState;
  bool lightOnOption;
  bool lightOffOption;
  DateTime timeOn;
  DateTime timeOff;
  bool auto;
  LightModuleModel(
    {this.lightState,
    this.lightOnOption,
    this.lightOffOption,
    this.timeOn,
    this.timeOff,
    this.auto,}
  );
  
  factory LightModuleModel.fromJson(Map<String, dynamic> json) {
    return LightModuleModel(
      lightState: json["lightState"] as bool, 
      lightOnOption: json["lightOnOption"] as bool, 
      lightOffOption: json["lightOffOption"] as bool, 
      timeOn: global.format.parse(json["timeOn"]), 
      timeOff: global.format.parse(json["timeOff"]), 
      auto: json["auto"] as bool,
    );
  }
}
