class Links {
  Links({
    String? first,
    String? last,
    dynamic prev,
    String? next,
  }) {
    _first = first;
    _last = last;
    _prev = prev;
    _next = next;
  }

  Links.fromJson(dynamic json) {
    _first = json['first'];
    _last = json['last'];
    _prev = json['prev'];
    _next = json['next'];
  }

  String? _first;
  String? _last;
  dynamic _prev;
  String? _next;

  Links copyWith({
    String? first,
    String? last,
    dynamic prev,
    String? next,
  }) =>
      Links(
        first: first ?? _first,
        last: last ?? _last,
        prev: prev ?? _prev,
        next: next ?? _next,
      );

  String? get first => _first;

  String? get last => _last;

  dynamic get prev => _prev;

  String? get next => _next;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first'] = _first;
    map['last'] = _last;
    map['prev'] = _prev;
    map['next'] = _next;
    return map;
  }
}