class CreatePurchaseViewModel {
  String basePurchaseId;

  CreatePurchaseViewModel({
    this.basePurchaseId = "",
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['basePurchase_id'] = basePurchaseId;
    return data;
  }
}
