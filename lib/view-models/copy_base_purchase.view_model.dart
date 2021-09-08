class CopyBasePurchaseViewModel {
  String? purchaseId;
  String? basePurchaseId;
  String name;

  CopyBasePurchaseViewModel({
    this.name = "",
    this.purchaseId,
    this.basePurchaseId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['purchaseId'] = purchaseId;
    data['basePurchaseId'] = basePurchaseId;
    return data;
  }
}
