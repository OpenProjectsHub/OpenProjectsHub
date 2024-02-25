

import 'dart:convert';

HelpModel helpModelFromJson(String str) => HelpModel.fromJson(json.decode(str));

String helpModelToJson(HelpModel data) => json.encode(data.toJson());

class HelpModel {
  HelpModel({
    this.data,
    this.links,
    this.meta,
  });

  List<Datum>? data;
  Links? links;
  Meta? meta;

  factory HelpModel.fromJson(Map<String, dynamic> json) => HelpModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    links: Links.fromJson(json["links"]),
    meta: Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "links": links?.toJson(),
    "meta": meta?.toJson(),
  };
}

class Datum {
  Datum({
    this.id,
    this.uuid,
    this.type,
    this.active,
    this.createdAt,
    this.updatedAt,
    this.translation,
    this.locales,
  });

  int? id;
  String? uuid;
  String? type;
  bool? active;
  DateTime? createdAt;
  DateTime? updatedAt;
  Translation? translation;
  List<String>? locales;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    uuid: json["uuid"],
    type: json["type"],
    active: json["active"],
    createdAt: DateTime.tryParse(json["created_at"])?.toLocal(),
    updatedAt: DateTime.tryParse(json["updated_at"])?.toLocal(),
    translation: Translation.fromJson(json["translation"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "type": type,
    "active": active,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "translation": translation?.toJson(),
    "locales": List<dynamic>.from(locales!.map((x) => x)),
  };
}

class Translation {
  Translation({
    this.id,
    this.locale,
    this.question,
    this.answer,
  });

  int? id;
  String? locale;
  String? question;
  String? answer;

  factory Translation.fromJson(Map<String, dynamic> json) => Translation(
    id: json["id"],
    locale: json["locale"],
    question: json["question"],
    answer: json["answer"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "locale": locale,
    "question": question,
    "answer": answer,
  };
}

class Links {
  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  String? first;
  String? last;
  dynamic prev;
  dynamic next;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    first: json["first"],
    last: json["last"],
    prev: json["prev"],
    next: json["next"],
  );

  Map<String, dynamic> toJson() => {
    "first": first,
    "last": last,
    "prev": prev,
    "next": next,
  };
}

class Meta {
  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.links,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  int? currentPage;
  int? from;
  int? lastPage;
  List<Link>? links;
  String? path;
  int? perPage;
  int? to;
  int? total;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    currentPage: json["current_page"],
    from: json["from"],
    lastPage: json["last_page"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    path: json["path"],
    perPage: json["per_page"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "from": from,
    "last_page": lastPage,
    "links": List<dynamic>.from(links!.map((x) => x.toJson())),
    "path": path,
    "per_page": perPage,
    "to": to,
    "total": total,
  };
}

class Link {
  Link({
    this.url,
    this.label,
    this.active,
  });

  String? url;
  String? label;
  bool? active;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"] ?? "",
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url ?? "",
    "label": label,
    "active": active,
  };
}
