import '../data/links.dart';
import '../data/meta.dart';
import '../data/user.dart';

class WalletHistoriesResponse {
  WalletHistoriesResponse({
    List<WalletData>? data,
    Links? links,
    Meta? meta,
  }) {
    _data = data;
    _links = links;
    _meta = meta;
  }

  WalletHistoriesResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(WalletData.fromJson(v));
      });
    }
    _links = json['links'] != null ? Links.fromJson(json['links']) : null;
    _meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  List<WalletData>? _data;
  Links? _links;
  Meta? _meta;

  WalletHistoriesResponse copyWith({
    List<WalletData>? data,
    Links? links,
    Meta? meta,
  }) =>
      WalletHistoriesResponse(
        data: data ?? _data,
        links: links ?? _links,
        meta: meta ?? _meta,
      );

  List<WalletData>? get data => _data;

  Links? get links => _links;

  Meta? get meta => _meta;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    if (_links != null) {
      map['links'] = _links?.toJson();
    }
    if (_meta != null) {
      map['meta'] = _meta?.toJson();
    }
    return map;
  }
}

class WalletData {
  WalletData({
    int? id,
    String? uuid,
    String? walletUuid,
    int? transactionId,
    String? type,
    num? price,
    String? note,
    String? status,
    String? createdAt,
    String? updatedAt,
    UserModel? author,
    UserModel? user,
  }) {
    _id = id;
    _uuid = uuid;
    _walletUuid = walletUuid;
    _transactionId = transactionId;
    _type = type;
    _price = price;
    _note = note;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _author = author;
    _user = user;
  }

  WalletData.fromJson(dynamic json) {
    _id = json['id'];
    _uuid = json['uuid'];
    _walletUuid = json['wallet_uuid'];
    _transactionId = json['transaction_id'];
    _type = json['type'];
    _price = json['price'];
    _note = json['note'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _author = json['author'] != null ? UserModel.fromJson(json['author']) : null;
    _user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
  }

  int? _id;
  String? _uuid;
  String? _walletUuid;
  int? _transactionId;
  String? _type;
  num? _price;
  String? _note;
  String? _status;
  String? _createdAt;
  String? _updatedAt;
  UserModel? _author;
  UserModel? _user;

  WalletData copyWith({
    int? id,
    String? uuid,
    String? walletUuid,
    int? transactionId,
    String? type,
    num? price,
    String? note,
    String? status,
    String? createdAt,
    String? updatedAt,
    UserModel? author,
    UserModel? user,
  }) =>
      WalletData(
        id: id ?? _id,
        uuid: uuid ?? _uuid,
        walletUuid: walletUuid ?? _walletUuid,
        transactionId: transactionId ?? _transactionId,
        type: type ?? _type,
        price: price ?? _price,
        note: note ?? _note,
        status: status ?? _status,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        author: author ?? _author,
        user: user ?? _user,
      );

  int? get id => _id;

  String? get uuid => _uuid;

  String? get walletUuid => _walletUuid;

  int? get transactionId => _transactionId;

  String? get type => _type;

  num? get price => _price;

  String? get note => _note;

  String? get status => _status;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  UserModel? get author => _author;

  UserModel? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['uuid'] = _uuid;
    map['wallet_uuid'] = _walletUuid;
    map['transaction_id'] = _transactionId;
    map['type'] = _type;
    map['price'] = _price;
    map['note'] = _note;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_author != null) {
      map['author'] = _author?.toJson();
    }
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }
}
