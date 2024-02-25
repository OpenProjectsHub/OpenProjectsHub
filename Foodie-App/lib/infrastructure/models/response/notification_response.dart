

import '../models.dart';

class NotificationResponse {
  List<NotificationModel>? data;

  NotificationResponse({
    this.data,
  });

  NotificationResponse copyWith({
    List<NotificationModel>? data,
  }) =>
      NotificationResponse(
        data: data ?? this.data,
      );

  factory NotificationResponse.fromJson(Map<String, dynamic> json) =>
      NotificationResponse(
        data: json["data"] == null
            ? []
            : List<NotificationModel>.from(
                json["data"]!.map((x) => NotificationModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class NotificationModel {
  int? id;
  String? type;
  String? title;
  String? body;
  Data? data;
  int? userId;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? readAt;
  Client? client;
  OrderData? orderData;
  BlogData? blogData;

  NotificationModel({
    this.id,
    this.type,
    this.title,
    this.body,
    this.data,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.readAt,
    this.client,
    this.orderData,
    this.blogData,
  });

  NotificationModel copyWith({
    int? id,
    String? type,
    String? title,
    String? body,
    Data? data,
    int? userId,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? readAt,
    Client? client,
    OrderData? orderData,
    BlogData? blogData
  }) =>
      NotificationModel(
        id: id ?? this.id,
        type: type ?? this.type,
        title: title ?? this.title,
        body: body ?? this.body,
        data: data ?? this.data,
        userId: userId ?? this.userId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        readAt: readAt ?? this.readAt,
        client: client ?? this.client,
        orderData: orderData ?? this.orderData,
        blogData: blogData ?? this.blogData
      );

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: json["id"],
        type: json["type"],
        title: json["title"],
        body: json["body"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        userId: json["user_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.tryParse(json["created_at"])?.toLocal(),
        updatedAt: json["updated_at"] == null
            ? null
              : DateTime.tryParse(json["updated_at"])?.toLocal(),
        readAt:
            json["read_at"] == null ? null : DateTime.tryParse(json["read_at"])?.toUtc().toLocal(),
        client: json["client"] == null ? null : Client.fromJson(json["client"]),
        orderData: json["order"] == null ? null : OrderData.fromJson(json["order"]),
        blogData: json["blog"] == null ? null : BlogData.fromJson(json["blog"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "title": title,
        "body": body,
        "data": data?.toJson(),
        "user_id": userId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "read_at": readAt?.toIso8601String(),
        "client": client?.toJson(),
        "order": orderData?.toJson(),
      };
}

class Client {
  int? id;
  String? firstname;
  String? lastname;
  bool? emptyP;
  int? active;
  String? role;
  String? img;

  Client({
    this.id,
    this.firstname,
    this.lastname,
    this.emptyP,
    this.active,
    this.role,
    this.img,
  });

  Client copyWith({
    int? id,
    String? firstname,
    String? lastname,
    bool? emptyP,
    int? active,
    String? role,
    String? img,
  }) =>
      Client(
        id: id ?? this.id,
        firstname: firstname ?? this.firstname,
        lastname: lastname ?? this.lastname,
        emptyP: emptyP ?? this.emptyP,
        active: active ?? this.active,
        role: role ?? this.role,
        img: img ?? this.img,
      );

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        id: json["id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        emptyP: json["empty_p"],
        active: json["active"],
        role: json["role"],
        img: json["img"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "empty_p": emptyP,
        "active": active,
        "role": role,
        "img": img,
      };
}

class Data {
  int? id;
  String? type;
  String? status;

  Data({
    this.id,
    this.type,
    this.status,
  });

  Data copyWith({
    int? id,
    String? type,
    String? status,
  }) =>
      Data(
        id: id ?? this.id,
        type: type ?? this.type,
        status: status ?? this.status,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        type: json["type"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "status": status,
      };
}
