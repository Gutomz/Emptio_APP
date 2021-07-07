class PurchasesFilterViewModel {
  String? status;
  int limit;
  int skip;
  bool isDesc;
  String? orderBy;

  PurchasesFilterViewModel({
    this.status,
    this.limit = 10,
    this.skip = 0,
    this.isDesc = true,
    this.orderBy,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['limit'] = limit;
    data['skip'] = skip;
    data['isDesc'] = isDesc;
    data['orderBy'] = orderBy;
    return data;
  }

  Map<String, String> toQuery() {
    final Map<String, String> data = <String, String>{};
    if (status != null) data['status'] = status!;
    if (orderBy != null) data['orderBy'] = orderBy!;
    data['limit'] = limit.toString();
    data['skip'] = skip.toString();
    data['isDesc'] = isDesc.toString();
    return data;
  }
}
