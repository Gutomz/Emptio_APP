class UpdateBasePurchaseItemViewModel {
  int quantity;

  UpdateBasePurchaseItemViewModel({
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quantity'] = this.quantity;
    return data;
  }
}
