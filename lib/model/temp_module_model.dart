class TempModuleModel {
  int value;
  bool upperAlertOptions;
  bool lowerAlertOptions;
  int upperbound;
  int lowerbound;
  TempModuleModel(
    this.value,
    this.upperAlertOptions,
    this.lowerAlertOptions,
    this.upperbound,
    this.lowerbound,
  );
  factory TempModuleModel.fromJson(Map<String, dynamic> json) {
    return TempModuleModel(
      json["value"] as int,
      json["upperAlertOptions"] as bool,
      json["lowerAlertOptions"] as bool,
      json["upperbound"] as int,
      json["lowerbound"] as int,
    );
  }
}
