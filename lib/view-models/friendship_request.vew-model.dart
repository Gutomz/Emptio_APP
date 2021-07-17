class FriendshipRequestViewModel {
  String friendId;

  FriendshipRequestViewModel({
    required this.friendId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['friendId'] = friendId;
    return data;
  }
}
