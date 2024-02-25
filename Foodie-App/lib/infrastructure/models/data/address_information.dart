class AddressInformation {
  AddressInformation({
    String? office,
    String? house,
    String? floor,
  }) {
    _office = office;
    _house = house;
    _floor = floor;
  }

  AddressInformation.fromJson(dynamic json) {
    _office = json['office'];
    _house = json['house'];
    _floor = json['floor'];
  }

  String? _office;
  String? _house;
  String? _floor;

  AddressInformation copyWith({
    String? office,
    String? house,
    String? floor,
  }) =>
      AddressInformation(
        office: office ?? _office,
        house: house ?? _house,
        floor: floor ?? _floor,
      );

  String? get office => _office;

  String? get house => _house;

  String? get floor => _floor;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['office'] = _office;
    map['house'] = _house;
    map['floor'] = _floor;
    return map;
  }
}
