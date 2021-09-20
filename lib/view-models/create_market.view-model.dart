class MarketCreateViewModel {
  String name;
  String? image;

  MarketCreateViewModel({
    required this.name,
    this.image,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['image'] = image;
    return data;
  }
}
