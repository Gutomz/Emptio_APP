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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['limit'] = this.limit;
    data['skip'] = this.skip;
    data['isDesc'] = this.isDesc;
    data['orderBy'] = this.orderBy;
    return data;
  }

  Map<String, String> toQuery() {
    final Map<String, String> data = new Map<String, String>();
    if (this.status != null) data['status'] = this.status!;
    if (this.orderBy != null) data['orderBy'] = this.orderBy!;
    data['limit'] = this.limit.toString();
    data['skip'] = this.skip.toString();
    data['isDesc'] = this.isDesc.toString();
    return data;
  }
}
