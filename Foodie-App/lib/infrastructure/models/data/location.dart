class LocationModel {
  LocationModel({double? latitude, double? longitude}) {
    _latitude = latitude;
    _longitude = longitude;
  }

  LocationModel.fromJson(dynamic json) {
    _latitude = double.tryParse(json['latitude'].toString());
    _longitude = double.tryParse(json['longitude'].toString());
  }

  double? _latitude;
  double? _longitude;

  LocationModel copyWith({double? latitude, double? longitude}) => LocationModel(
        latitude: latitude ?? _latitude,
        longitude: longitude ?? _longitude,
      );

  double? get latitude => _latitude;

  double? get longitude => _longitude;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    return map;
  }
}
