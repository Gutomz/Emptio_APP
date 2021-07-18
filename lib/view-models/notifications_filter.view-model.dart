class NotificationsFilterViewModel {
  int limit;
  int skip;

  NotificationsFilterViewModel({
    this.limit = 10,
    this.skip = 0,
  });

  Map<String, String> toQuery() {
    final Map<String, String> data = <String, String>{};
    data['limit'] = limit.toString();
    data['skip'] = skip.toString();
    return data;
  }
}
