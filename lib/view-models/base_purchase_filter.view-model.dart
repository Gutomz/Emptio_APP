class BasePurchasesFilterViewModel {
  String search;
  int limit;
  int skip;
  bool isDesc;
  String? orderBy;

  BasePurchasesFilterViewModel({
    this.search = "",
    this.limit = 10,
    this.skip = 0,
    this.isDesc = true,
    this.orderBy,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['search'] = search;
    data['limit'] = limit;
    data['skip'] = skip;
    data['isDesc'] = isDesc;
    data['orderBy'] = orderBy;
    return data;
  }

  Map<String, String> toQuery() {
    final Map<String, String> data = <String, String>{};
    data['search'] = search;
    data['limit'] = limit.toString();
    data['skip'] = skip.toString();
    data['isDesc'] = isDesc.toString();
    if (orderBy != null) data['orderBy'] = orderBy!;
    return data;
  }
}
