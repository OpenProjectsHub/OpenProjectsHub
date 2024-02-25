

import 'package:shoppingapp/infrastructure/models/data/take_data.dart';

class TagResponse {
  TagResponse({
    List<TakeModel>? data,
    // Links? links,

  }) {
    _data = data;

  }

  TagResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(TakeModel.fromJson(v));
      });
    }


  }

  List<TakeModel>? _data;


  List<TakeModel>? get data => _data;


}

class PriceModel {
  PriceModel({
    required this.timestamp,
    required this.status,
    required this.message,
    required this.data,
  });

  DateTime timestamp;
  bool status;
  String message;
  Data data;

  factory PriceModel.fromJson(Map<String, dynamic> json) => PriceModel(
    timestamp: DateTime.now(),
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "timestamp": timestamp.toIso8601String(),
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.min,
    required this.max,
  });

  double min;
  double max;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    min: double.tryParse(json["min"].toString()) ?? 1,
    max:  double.tryParse(json["max"].toString()) ?? 100,
  );

  Map<String, dynamic> toJson() => {
    "min": min,
    "max": max,
  };
}
