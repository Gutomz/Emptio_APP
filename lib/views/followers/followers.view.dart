import 'package:emptio/views/followers/store/followers_list.store.dart';
import 'package:emptio/views/followers/widgets/followers_list.dart';
import 'package:flutter/material.dart';

class FollowersView extends StatelessWidget {
  final int initialIndex;
  final String? userId;
  final String title;

  final FollowersListStore _followersStore;
  final FollowersListStore _followingStore;

  FollowersView(
      {Key? key, this.initialIndex = 0, this.userId, this.title = "Perfil"})
      : _followersStore = FollowersListStore(userId: userId, followers: true),
        _followingStore = FollowersListStore(userId: userId),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: initialIndex,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          bottom: TabBar(
            onTap: (index) =>
                index == 0 ? _followersStore.load() : _followingStore.load(),
            tabs: [
              Tab(text: "Seguidores"),
              Tab(text: "Seguindo"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            FollowersList(store: _followersStore),
            FollowersList(store: _followingStore),
          ],
        ),
      ),
    );
  }
}
