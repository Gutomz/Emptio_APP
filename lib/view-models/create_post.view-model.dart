class CreatePostDataViewModel {
  String type;

  String? productMarket;

  String? name;
  String? purchase;
  String? basePurchase;

  CreatePostDataViewModel({
    required this.type,
    this.productMarket,
    this.name,
    this.purchase,
    this.basePurchase,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['productMarket'] = productMarket ?? "";
    data['name'] = name ?? "";
    data['purchase'] = purchase ?? "";
    data['basePurchase'] = basePurchase ?? "";
    return data;
  }
}

class CreatePostViewModel {
  String description;
  CreatePostDataViewModel data;

  CreatePostViewModel({
    required this.description,
    required String type,
    String? productMarket,
    String? name,
    String? purchase,
    String? basePurchase,
  }) : data = CreatePostDataViewModel(
          type: type,
          productMarket: productMarket,
          name: name,
          purchase: purchase,
          basePurchase: basePurchase,
        );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['data'] = this.data.toJson();
    return data;
  }
}
