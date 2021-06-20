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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['checked'] = this.checked;
    return data;
  }
}
