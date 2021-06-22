class HumiModuleModel {
  int value;
  int upperbound;
  int lowerbound;
  bool auto;
  HumiModuleModel(this.value, this.upperbound, this.lowerbound, this.auto);
  factory HumiModuleModel.fromJson(Map<String, dynamic> json) {
    return HumiModuleModel(
      json["value"] as int,
      json["upperbound"] as int,
      json["lowerbound"] as int,
      json["auto"] as bool,
    );
  }
}
