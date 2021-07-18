import 'package:emptio/common/widgets/dismissible_background.widget.dart';
import 'package:emptio/common/widgets/empty_placeholder.widget.dart';
import 'package:emptio/common/widgets/profile_avatar.widget.dart';
import 'package:emptio/common/widgets/simple_confirm_dialog.widget.dart';
import 'package:emptio/core/app_assets.dart';
import 'package:emptio/core/app_colors.dart';
import 'package:emptio/models/friendship_request.model.dart';
import 'package:emptio/views/notifications/store/friendship_requests_store.dart';
import 'package:emptio/views/profile/profile.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:emptio/helpers/extensions.dart';

class FriendshipRequestList extends StatelessWidget {
  final FriendshipRequestsStore store;

  const FriendshipRequestList({
    Key? key,
    required this.store,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      if (store.loading) {
        return Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: AppColors.darkOrange,
          ),
        );
      }

      if (store.hasError) {
        return Center(
          child: Text(
            store.error,
            textAlign: TextAlign.center,
          ),
        );
      }

      return RefreshIndicator(
        onRefresh: store.load,
        backgroundColor: AppColors.lightBlue,
        color: Colors.white,
        child: store.list.isEmpty
            ? Center(
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Center(
                    child: EmptyPlaceholder(
                      title: 'Nenhuma requisição encontrada!',
                      subTitle: 'Arraste para baixo para recarregar.',
                      asset: AppAssets.svgIcNotificationsEmpty,
                    ),
                  ),
                ),
              )
            : ListView.separated(
                itemCount: store.list.length,
                itemBuilder: (context, index) {
                  return Observer(builder: (context) {
                    final request = store.list[index];

                    return Tooltip(
                      message:
                          "Deslize para os lados, para aceitar ou recusar o pedido.",
                      child: Dismissible(
                        key: Key(request.sId),
                        onDismissed: (direction) =>
                            _onDismissItem(direction, request),
                        confirmDismiss: (direction) =>
                            _confirmDismiss(context, direction, request),
                        background: DismissibleBackground(
                          icon: Icons.check_outlined,
                          title: 'Aceitar',
                          color: AppColors.green,
                        ),
                        secondaryBackground: DismissibleBackground(
                          icon: Icons.cancel_outlined,
                          title: 'Ignorar',
                          color: AppColors.red,
                          secondary: true,
                        ),
                        child: _buildItem(context, request),
                      ),
                    );
                  });
                },
                separatorBuilder: (context, index) => Divider(
                  height: 1,
                  color: AppColors.lightGrey,
                ),
              ),
      );
    });
  }

  Widget _buildItem(BuildContext context, FriendshipRequestModel model) {
    return ListTile(
      onTap: () => _navigateToProfileView(context, model.user.sId),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      leading: ProfileAvatar(
        image: model.user.photo,
        radius: 24,
        borderGap: 2,
        iconSize: 24,
        backgroundColor: AppColors.orange,
      ),
      title: RichText(
        text: TextSpan(
          text: model.user.name,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: AppColors.grey,
          ),
          children: [
            TextSpan(
              text:
                  ' está solicitando para te seguir, e acompanhar suas publicações',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColors.grey,
              ),
            ),
          ],
        ),
      ),
      trailing: _buildTrailing(context, model),
    );
  }

  Widget _buildTrailing(BuildContext context, FriendshipRequestModel model) {
    final date = model.updatedAt.customFormatDate('dd/MM/yy');
    final time = model.updatedAt.customFormatDate('HH:mm');

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Icon(
          Icons.double_arrow_rounded,
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

  void _navigateToProfileView(BuildContext context, String userId) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ProfileView(userId: userId),
    ));
  }

  void _onDismissItem(
      DismissDirection direction, FriendshipRequestModel model) {
    if (direction == DismissDirection.startToEnd) {
      store.acceptRequest(model.sId);
    } else {
      store.ignoreRequest(model.sId);
    }
  }

  Future<bool?> _confirmDismiss(BuildContext context,
      DismissDirection direction, FriendshipRequestModel model) async {
    final SimpleConfirmDialog confirmDialog;
    final name = model.user.name;

    if (direction == DismissDirection.startToEnd) {
      confirmDialog = SimpleConfirmDialog(
        title: "Aceitar solicitação?",
        content:
            "Tem certeza que deseja permitir que $name tenha acesso às suas postagens?",
        acceptText: "sim",
        rejectText: "cancelar",
      );
    } else {
      confirmDialog = SimpleConfirmDialog(
        title: "Ignorar solicitação?",
        content:
            "Tem certeza que deseja ignorar a solicitação de $name? Isso fará com que $name continue sem acesso às suas postagens.",
        acceptText: "sim",
        rejectText: "cancelar",
      );
    }

    final response = await showDialog<bool>(
      context: context,
      builder: (context) => confirmDialog,
    );

    return Future.value(response ?? false);
  }
}
