

class ReviewCountModel {
  ReviewCountModel({
    this.group,
  });

  Map<String, int>? group;

  ReviewCountModel copyWith({
    Map<String, int>? group,
  }) =>
      ReviewCountModel(
        group: group ?? this.group,
      );

  factory ReviewCountModel.fromJson(Map<String, dynamic> json) => ReviewCountModel(
    group: Map.from(json["group"]!).map((k, v) => MapEntry<String, int>(k, v)),
  );

  Map<String, dynamic> toJson() => {
    "group": Map.from(group!).map((k, v) => MapEntry<String, dynamic>(k, v)),
  };
}
