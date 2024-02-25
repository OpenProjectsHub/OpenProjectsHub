import 'local_location.dart';

class LocalAddressData {
  LocalAddressData({
    int? id,
    String? title,
    String? address,
    LocalLocation? location,
    bool? isDefault,
    bool? isSelected,
  }) {
    _id = id;
    _title = title;
    _address = address;
    _location = location;
    _default = isDefault;
    _isSelected = isSelected;
  }

  LocalAddressData.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _address = json['address'];
    _location = json['location'] != null
        ? LocalLocation.fromJson(json['location'])
        : null;
    _default = json['default'];
    _isSelected = json['selected'];
  }

  int? _id;
  String? _title;
  String? _address;
  LocalLocation? _location;
  bool? _default;
  bool? _isSelected;

  LocalAddressData copyWith({
    int? id,
    String? title,
    String? address,
    LocalLocation? location,
    bool? isDefault,
    bool? isSelected,
  }) =>
      LocalAddressData(
        id: id ?? _id,
        title: title ?? _title,
        address: address ?? _address,
        location: location ?? _location,
        isDefault: isDefault ?? _default,
        isSelected: isSelected ?? _isSelected,
      );

  int? get id => _id;

  String? get title => _title;

  String? get address => _address;

  LocalLocation? get location => _location;

  bool? get isDefault => _default;

  bool? get isSelected => _isSelected;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['address'] = _address;
    if (_location != null) {
      map['location'] = _location?.toJson();
    }
    map['default'] = _default;
    map['selected'] = _isSelected;
    return map;
  }

  @override
  String toString() {
    return 'LocalAddressData(title - $title})';
  }
}
