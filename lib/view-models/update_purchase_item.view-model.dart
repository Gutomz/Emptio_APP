class UpdatePurchaseItemViewModel {
  double price;
  int quantity;
  bool checked;

  UpdatePurchaseItemViewModel({
    required this.price,
    required this.quantity,
    required this.checked,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['price'] = price;
    data['quantity'] = quantity;
    data['checked'] = checked;
    return data;
  }
}
