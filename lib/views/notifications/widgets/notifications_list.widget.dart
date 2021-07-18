import 'package:emptio/core/app_colors.dart';
import 'package:emptio/models/notification.model.dart';
import 'package:emptio/views/notifications/store/notifications_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:emptio/helpers/extensions.dart';

class NotificationsList extends StatelessWidget {
  final NotificationsStore store;

  const NotificationsList({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      if (store.hasError) {
        return Center(
          child: Text(
            store.error,
            textAlign: TextAlign.center,
          ),
        );
      }

      if (store.firstLoading) {
        return Center(
          child: CircularProgressIndicator(
            color: AppColors.darkOrange,
          ),
        );
      }

      if (store.list.isEmpty) {
        return Container();
      }

      return RefreshIndicator(
        backgroundColor: AppColors.lightBlue,
        color: Colors.white,
        onRefresh: store.resetPage,
        child: ListView.separated(
          padding: EdgeInsets.only(bottom: 50),
          separatorBuilder: (context, index) => Divider(
            height: 1,
            color: AppColors.grey,
          ),
          itemCount: store.itemCount,
          itemBuilder: (context, index) {
            if (index < store.list.length) {
              final notification = store.list[index];

              return Opacity(
                opacity: notification.viewed ? 0.6 : 1,
                child: ListTile(
                  tileColor: notification.viewed ? null : Colors.white,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  leading: Icon(
                    Icons.info_outline_rounded,
                    size: 36,
                    color: AppColors.darkOrange,
                  ),
                  title: Text(notification.title),
                  subtitle: Text(notification.body),
                  trailing: _buildTrailing(context, notification),
                ),
              );
            }

            store.loadNextPage();
            return SizedBox(
              height: 5,
              child: LinearProgressIndicator(
                valueColor: AlwaysStoppedAnimation(AppColors.darkOrange),
              ),
            );
          },
        ),
      );
    });
  }

  Widget _buildTrailing(BuildContext context, NotificationModel model) {
    final date = model.createdAt.customFormatDate('dd/MM/yy');
    final time = model.createdAt.customFormatDate('HH:mm');

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Icon(
          model.viewed ? Icons.visibility_rounded : Icons.double_arrow_rounded,
          size: 16,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              date,
              textAlign: TextAlign.end,
              style: TextStyle(
                color: AppColors.lightGrey,
                fontSize: 12,
                fontWeight: FontWeight.w300,
              ),
            ),
            Text(
              time,
              textAlign: TextAlign.end,
              style: TextStyle(
                color: AppColors.lightGrey,
                fontSize: 12,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
