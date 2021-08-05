class MarketFilterViewModel {
  String search;
  int limit;
  int skip;
  String? favoriteId;

  MarketFilterViewModel({
    required this.search,
    this.limit = 10,
    this.skip = 0,
    this.favoriteId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['search'] = search;
    data['limit'] = limit;
    data['skip'] = skip;
    if (favoriteId != null) data['favorite_id'] = favoriteId;
    return data;
  }

  Map<String, String> toQuery() {
    final Map<String, String> data = <String, String>{};
    data['search'] = search;
    data['limit'] = limit.toString();
    data['skip'] = skip.toString();
    if (favoriteId != null) data['favorite_id'] = favoriteId!;
    return data;
  }
}
