class GetPostProfileFilterViewModel {
  int limit;
  int skip;

  GetPostProfileFilterViewModel({
    this.limit = 10,
    this.skip = 0,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['limit'] = limit;
    data['skip'] = skip;
    return data;
  }

  Map<String, String> toQuery() {
    final Map<String, String> data = <String, String>{};
    data['limit'] = limit.toString();
    data['skip'] = skip.toString();
    return data;
  }
}
