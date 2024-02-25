

import 'dart:convert';

NotificationsListModel? notificationsListModelFromJson(dynamic str) => NotificationsListModel.fromJson(str);

String notificationsListModelToJson(NotificationsListModel? data) => json.encode(data!.toJson());

class NotificationsListModel {
  NotificationsListModel({
    this.data,
  });

  List<NotificationData>? data;

  factory NotificationsListModel.fromJson(Map<String, dynamic> json) => NotificationsListModel(
    data: json["data"] == null ? [] : List<NotificationData>.from(json["data"]!.map((x) => NotificationData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class NotificationData {
  NotificationData({
    this.id,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.payload,
    this.active
  });

  int? id;
  String? type;
  bool? active;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<String?>? payload;

  factory NotificationData.fromJson(Map<String, dynamic> json) => NotificationData(
    id: json["id"],
    type: json["type"],
    createdAt: DateTime.tryParse(json["created_at"])?.toLocal(),
    updatedAt: DateTime.tryParse(json["updated_at"])?.toLocal(),
    active: false,
    payload: json["payload"] == null ? [] : json["payload"] == null ? [] : List<String?>.from(json["payload"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "payload": payload == null ? [] : payload == null ? [] : List<dynamic>.from(payload!.map((x) => x)),
  };
}
