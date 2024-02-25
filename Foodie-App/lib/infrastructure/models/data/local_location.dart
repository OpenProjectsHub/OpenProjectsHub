class LocalLocation {
  LocalLocation({double? latitude, double? longitude}) {
    _latitude = latitude;
    _longitude = longitude;
  }

  LocalLocation.fromJson(dynamic json) {
    _latitude = json['latitude'];
    _longitude = json['longitude'];
  }

  double? _latitude;
  double? _longitude;

  LocalLocation copyWith({double? latitude, double? longitude}) =>
      LocalLocation(
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
