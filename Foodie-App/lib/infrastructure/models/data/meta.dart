class Meta {
  Meta({int? total}) {
    _total = total;
  }

  Meta.fromJson(dynamic json) {
    _total = json['total'];
  }

  int? _total;

  Meta copyWith({int? total}) => Meta(total: total ?? _total);

  int? get total => _total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = _total;
    return map;
  }
}
