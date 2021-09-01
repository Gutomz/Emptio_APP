class ProductRecognizerViewModel {
  String image;
  String purchaseId;
  String basePurchaseId;
  bool isFavorite;

  ProductRecognizerViewModel({
    required this.image,
    this.purchaseId = "",
    this.basePurchaseId = "",
    this.isFavorite = false,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['purchase_id'] = purchaseId;
    data['basePurchase_id'] = basePurchaseId;
    data['isFavorite'] = isFavorite;
    return data;
  }

  Map<String, String> toQuery() {
    final Map<String, String> data = <String, String>{};
    data['image'] = image;
    data['purchase_id'] = purchaseId;
    data['basePurchase_id'] = basePurchaseId;
    data['isFavorite'] = isFavorite.toString();
    return data;
  }
}
