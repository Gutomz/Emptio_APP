class CreatePurchaseViewModel {
  String basePurchaseId;

  CreatePurchaseViewModel({
    this.basePurchaseId = "",
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['basePurchase_id'] = this.basePurchaseId;
    return data;
  }
}
