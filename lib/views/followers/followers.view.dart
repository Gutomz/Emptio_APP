import 'package:emptio/views/followers/widgets/followers_list.dart';
import 'package:flutter/material.dart';

class FollowersView extends StatelessWidget {
  final int initialIndex;
  final String? userId;

  FollowersView({Key? key, this.initialIndex = 0, this.userId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: initialIndex,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Perfil'),
          bottom: TabBar(
            tabs: [
              Tab(text: "Seguidores"),
              Tab(text: "Seguindo"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            FollowersList(userId: userId, followers: true),
            FollowersList(userId: userId),
          ],
        ),
      ),
    );
  }
}
