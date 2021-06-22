class NotificationModel {
  String content;
  String time;
  NotificationModel(this.content, this.time);
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      json["content"],
      json["time"],
    );
  }
}
