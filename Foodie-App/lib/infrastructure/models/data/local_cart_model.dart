

class CartLocalModelList {
  final List<CartLocalModel> list;


  CartLocalModelList({required this.list,});

  factory CartLocalModelList.fromJson(Map data) {
    List<CartLocalModel> list = [];
    data["list"].forEach((e){
      list.add(CartLocalModel.fromJson(e));
    });
    return CartLocalModelList(
      list: list,
    );
  }

  Map toJson() {
    return {
      "list": list.map((e) => e.toJson()).toList(),
    };
  }
}

class CartLocalModel {
   int count;
  final int stockId;

  CartLocalModel({required this.count, required this.stockId});

  factory CartLocalModel.fromJson(Map data) {
    return CartLocalModel(
      count: data["count"],
      stockId: data["stockId"],
    );
  }

  Map toJson() {
    return {
      "count": count,
      "stockId": stockId,
    };
  }
}
