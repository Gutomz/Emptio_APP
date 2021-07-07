class UpdateBasePurchaseItemViewModel {
  int quantity;

  UpdateBasePurchaseItemViewModel({
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['quantity'] = quantity;
    return data;
  }
}
