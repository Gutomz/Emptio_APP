import 'package:emptio/views/notifications/store/friendship_requests_store.dart';
import 'package:emptio/views/notifications/widgets/requests_list.widget.dart';
import 'package:flutter/material.dart';

class NotificationsView extends StatelessWidget {
  final int initialIndex;
  // final FollowersListStore _followingStore;
  final FriendshipRequestsStore _requestsStore = FriendshipRequestsStore();

  NotificationsView({Key? key, this.initialIndex = 0})
      : /* _followersStore = FollowersListStore(userId: userId, followers: true),
        _followingStore = FollowersListStore(userId: userId), */
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: initialIndex,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Avisos"),
          bottom: TabBar(
            // onTap: (index) =>
            //     index == 0 ? _followersStore.load() : _followingStore.load(),
            tabs: [
              Tab(text: "Notificações"),
              Tab(text: "Solicitações"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(),
            FriendshipRequestList(store: _requestsStore),
          ],
        ),
      ),
    );
  }
}
