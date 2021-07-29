class ConnectMarketViewModel {
  final String? placeId;
  final String? marketId;

  ConnectMarketViewModel({this.placeId, this.marketId});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['market_id'] = marketId;
    data['place_id'] = placeId;
    return data;
  }
}
