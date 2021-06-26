class ProductFilterViewModel {
  String search;
  int limit;
  int skip;
  String purchaseId;
  String basePurchaseId;

  ProductFilterViewModel({
    required this.search,
    this.limit = 10,
    this.skip = 0,
    this.purchaseId = "",
    this.basePurchaseId = "",
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['search'] = this.search;
    data['limit'] = this.limit;
    data['skip'] = this.skip;
    data['purchase_id'] = this.purchaseId;
    data['basePurchase_id'] = this.basePurchaseId;
    return data;
  }

  Map<String, String> toQuery() {
    final Map<String, String> data = new Map<String, String>();
    data['search'] = this.search;
    data['limit'] = this.limit.toString();
    data['skip'] = this.skip.toString();
    data['purchase_id'] = this.purchaseId;
    data['basePurchase_id'] = this.basePurchaseId;
    return data;
  }
}
