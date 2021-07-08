import 'package:emptio/common/widgets/main_app_bar.widget.dart';
import 'package:emptio/common/widgets/notification_action_button.widget.dart';
import 'package:flutter/material.dart';

class FeedView extends StatelessWidget {
  const FeedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: Text("Notícias"),
        drawerContext: context,
        actions: [
          NotificationActionButton(),
        ],
      ),
    );
  }
}
