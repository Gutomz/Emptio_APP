class UpdateBasePurchaseViewModel {
  String name;

  UpdateBasePurchaseViewModel({required this.name});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}
