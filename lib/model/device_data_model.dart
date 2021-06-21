class DeviceDataModel {
  int id;
  String name;
  bool hasLightModule;
  bool hasTempModule;
  bool hasHumiModule;
  bool lightState;
  int tempValue;
  int humiValue;

  DeviceDataModel({
    this.id,
    this.name,
    this.hasLightModule,
    this.hasTempModule,
    this.hasHumiModule,
    this.lightState,
    this.tempValue,
    this.humiValue,
  });

  factory DeviceDataModel.fromJson(Map<String, dynamic> json) {
    return DeviceDataModel(
      id: json["id"],
      name: json["name"],
      hasLightModule: json["hasLightModule"],
      hasTempModule: json["hasTempModule"],
      hasHumiModule: json["hasHumiModule"],
      lightState: json["lightState"],
      tempValue: json["tempValue"],
      humiValue: json["humiValue"],
    );
  }
}
