class FollowersListFilterViewModel {
  String? userId;
  bool followers;

  FollowersListFilterViewModel({
    this.userId,
    this.followers = false,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['followers'] = followers;
    return data;
  }

  Map<String, String> toQuery() {
    final Map<String, String> data = <String, String>{};
    if (userId != null) data['userId'] = userId!;
    data['followers'] = followers.toString();
    return data;
  }
}
