class FilterModel {
  List<double>? price;
  String? rating;
  int? offer;
  String? sort;
  bool? isFreeDelivery;
  bool? isDeal;
  bool? isOpen;

  FilterModel(
      {this.price,
      this.rating = "",
      this.offer,
      this.sort = "",
      this.isFreeDelivery = false,
      this.isDeal = false,
      this.isOpen = true});
}
