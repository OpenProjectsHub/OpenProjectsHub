

class NotificationsModel {
  NotificationsModel({
    this.id,
    this.payload,
    this.active,
    this.createdAt,
    this.updatedAt,
    this.type,
  });

  int? id;
  List<String?>? payload;
  bool? active;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? type;


  factory NotificationsModel.fromJson(Map<String, dynamic> json) {
    return NotificationsModel(
    id: json["id"],
    payload: json["payload"] == null ? [] : json["payload"] == null ? [] : List<String?>.from(json["payload"]!.map((x) => x)),
    active: (json["notification"] != null ? json["notification"]["active"] ?? 0 : 0) == 0 ? false : true,
    createdAt: DateTime.tryParse(json["created_at"])?.toLocal(),
    updatedAt: DateTime.tryParse(json["updated_at"])?.toLocal(),
    type: json["type"],

  );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "payload": payload == null ? [] : payload == null ? [] : List<dynamic>.from(payload!.map((x) => x)),
    "active": active,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "type": type,
  };
}


