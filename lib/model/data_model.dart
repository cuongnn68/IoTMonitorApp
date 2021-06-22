class DataModel {
  double value;
  String time;
  DataModel(this.time, this.value);
  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      json["time"] as String,
      (json["value"] as int).toDouble(),
    );
  }
}
