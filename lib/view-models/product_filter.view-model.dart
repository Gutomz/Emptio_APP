class ProductFilterViewModel {
  String search;
  int limit;
  int skip;
  String purchaseId;
  String basePurchaseId;
  bool isFavorite;

  ProductFilterViewModel({
    required this.search,
    this.limit = 10,
    this.skip = 0,
    this.purchaseId = "",
    this.basePurchaseId = "",
    this.isFavorite = false,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['search'] = search;
    data['limit'] = limit;
    data['skip'] = skip;
    data['purchase_id'] = purchaseId;
    data['basePurchase_id'] = basePurchaseId;
    data['isFavorite'] = isFavorite;
    return data;
  }

  Map<String, String> toQuery() {
    final Map<String, String> data = <String, String>{};
    data['search'] = search;
    data['limit'] = limit.toString();
    data['skip'] = skip.toString();
    data['purchase_id'] = purchaseId;
    data['basePurchase_id'] = basePurchaseId;
    data['isFavorite'] = isFavorite.toString();
    return data;
  }
}
