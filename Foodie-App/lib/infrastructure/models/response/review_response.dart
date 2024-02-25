

class ReviewResponseModel {
  ReviewResponseModel({
    this.data,
  });

  List<ReviewModel>? data;

  ReviewResponseModel copyWith({
    List<ReviewModel>? data,
  }) =>
      ReviewResponseModel(
        data: data ?? this.data,
      );

  factory ReviewResponseModel.fromJson(Map<String, dynamic> json) => ReviewResponseModel(
    data: json["data"] == null ? [] : List<ReviewModel>.from(json["data"]!.map((x) => ReviewModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ReviewModel {
  ReviewModel({
    this.id,
    this.reviewableId,
    this.reviewableType,
    this.assignableId,
    this.assignableType,
    this.rating,
    this.comment,
    this.img,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.order,
  });

  int? id;
  int? reviewableId;
  String? reviewableType;
  int? assignableId;
  String? assignableType;
  int? rating;
  String? comment;
  dynamic img;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? user;
  Order? order;

  ReviewModel copyWith({
    int? id,
    int? reviewableId,
    String? reviewableType,
    int? assignableId,
    String? assignableType,
    int? rating,
    String? comment,
    dynamic img,
    DateTime? createdAt,
    DateTime? updatedAt,
    User? user,
    Order? order,
  }) =>
      ReviewModel(
        id: id ?? this.id,
        reviewableId: reviewableId ?? this.reviewableId,
        reviewableType: reviewableType ?? this.reviewableType,
        assignableId: assignableId ?? this.assignableId,
        assignableType: assignableType ?? this.assignableType,
        rating: rating ?? this.rating,
        comment: comment ?? this.comment,
        img: img ?? this.img,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        user: user ?? this.user,
        order: order ?? this.order,
      );

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
    id: json["id"],
    reviewableId: json["reviewable_id"],
    reviewableType: json["reviewable_type"],
    assignableId: json["assignable_id"],
    assignableType: json["assignable_type"],
    rating: json["rating"],
    comment: json["comment"],
    img: json["img"],
    createdAt: json["created_at"] == null ? null : DateTime.tryParse(json["created_at"])?.toLocal(),
    updatedAt: json["updated_at"] == null ? null : DateTime.tryParse(json["updated_at"])?.toLocal(),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    order: json["order"] == null ? null : Order.fromJson(json["order"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "reviewable_id": reviewableId,
    "reviewable_type": reviewableType,
    "assignable_id": assignableId,
    "assignable_type": assignableType,
    "rating": rating,
    "comment": comment,
    "img": img,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "user": user?.toJson(),
    "order": order?.toJson(),
  };
}

class Order {
  Order({
    this.id,
    this.address,
    this.current,
    this.createdAt,
  });

  int? id;
  Address? address;
  bool? current;
  dynamic createdAt;

  Order copyWith({
    int? id,
    Address? address,
    bool? current,
    dynamic createdAt,
  }) =>
      Order(
        id: id ?? this.id,
        address: address ?? this.address,
        current: current ?? this.current,
        createdAt: createdAt ?? this.createdAt,
      );

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"],
    address: json["address"] == null ? null : Address.fromJson(json["address"]),
    current: json["current"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "address": address?.toJson(),
    "current": current,
    "created_at": createdAt,
  };
}

class Address {
  Address({
    this.address,
    this.office,
    this.house,
    this.floor,
  });

  String? address;
  dynamic office;
  dynamic house;
  dynamic floor;

  Address copyWith({
    String? address,
    dynamic office,
    dynamic house,
    dynamic floor,
  }) =>
      Address(
        address: address ?? this.address,
        office: office ?? this.office,
        house: house ?? this.house,
        floor: floor ?? this.floor,
      );

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    address: json["address"],
    office: json["office"],
    house: json["house"],
    floor: json["floor"],
  );

  Map<String, dynamic> toJson() => {
    "address": address,
    "office": office,
    "house": house,
    "floor": floor,
  };
}

class User {
  User({
    this.id,
    this.uuid,
    this.firstname,
    this.lastname,
    this.emptyP,
    this.active,
    this.img,
    this.role,
  });

  int? id;
  String? uuid;
  String? firstname;
  String? lastname;
  bool? emptyP;
  int? active;
  String? img;
  String? role;

  User copyWith({
    int? id,
    String? uuid,
    String? firstname,
    String? lastname,
    bool? emptyP,
    int? active,
    String? img,
    String? role,
  }) =>
      User(
        id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        firstname: firstname ?? this.firstname,
        lastname: lastname ?? this.lastname,
        emptyP: emptyP ?? this.emptyP,
        active: active ?? this.active,
        img: img ?? this.img,
        role: role ?? this.role,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    uuid: json["uuid"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    emptyP: json["empty_p"],
    active: json["active"],
    img: json["img"],
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "firstname": firstname,
    "lastname": lastname,
    "empty_p": emptyP,
    "active": active,
    "img": img,
    "role": role,
  };
}
