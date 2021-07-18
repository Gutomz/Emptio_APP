import 'package:emptio/stores/auth.store.dart';
import 'package:emptio/views/notifications/store/friendship_requests_store.dart';
import 'package:emptio/views/notifications/store/notifications_store.dart';
import 'package:emptio/views/notifications/widgets/notifications_list.widget.dart';
import 'package:emptio/views/notifications/widgets/requests_list.widget.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class NotificationsView extends StatelessWidget {
  final int initialIndex;
  final NotificationsStore _notificationsStore = NotificationsStore();
  final FriendshipRequestsStore _requestsStore = FriendshipRequestsStore();
  final AuthStore _authStore = GetIt.I<AuthStore>();

  NotificationsView({Key? key, this.initialIndex = 0}) : super(key: key);

  Future<bool> _onWillPop() async {
    _authStore.updateLoggedUser();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final user = _authStore.user;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: DefaultTabController(
        initialIndex: initialIndex,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Avisos"),
            bottom: TabBar(
              onTap: (index) => index == 1 ? _requestsStore.load() : null,
              tabs: [
                Tab(
                  text:
                      "Notificações${user != null && user.notificationCount != 0 ? " (${user.notificationCount})" : ""}",
                ),
                Tab(
                  text:
                      "Solicitações${user != null && user.requestsCount != 0 ? " (${user.requestsCount})" : ""}",
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              NotificationsList(store: _notificationsStore),
              FriendshipRequestList(store: _requestsStore),
            ],
          ),
        ),
      ),
    );
  }
}
