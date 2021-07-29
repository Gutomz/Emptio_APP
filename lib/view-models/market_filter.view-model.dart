class MarketFilterViewModel {
  String search;
  int limit;
  int skip;

  MarketFilterViewModel({
    required this.search,
    this.limit = 10,
    this.skip = 0,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['search'] = search;
    data['limit'] = limit;
    data['skip'] = skip;
    return data;
  }

  Map<String, String> toQuery() {
    final Map<String, String> data = <String, String>{};
    data['search'] = search;
    data['limit'] = limit.toString();
    data['skip'] = skip.toString();
    return data;
  }
}
