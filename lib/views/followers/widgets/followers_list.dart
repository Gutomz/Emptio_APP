import 'package:emptio/common/widgets/dismissible_background.widget.dart';
import 'package:emptio/common/widgets/empty_placeholder.widget.dart';
import 'package:emptio/common/widgets/profile_avatar.widget.dart';
import 'package:emptio/core/app_colors.dart';
import 'package:emptio/models/follower.model.dart';
import 'package:emptio/models/friendship_request.model.dart';
import 'package:emptio/stores/auth.store.dart';
import 'package:emptio/views/followers/store/followers_list.store.dart';
import 'package:emptio/views/profile/profile.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class FollowersList extends StatelessWidget {
  final FollowersListStore store;
  final AuthStore _authStore = GetIt.I<AuthStore>();
  final EmptyPlaceholder emptyPlaceholder;

  FollowersList({
    Key? key,
    required this.store,
    required this.emptyPlaceholder,
  }) : super(key: key);

  bool get isLoggedUser =>
      store.userId == null || _authStore.loggedId.contains(store.userId!);

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
        backgroundColor: AppColors.lightBlue,
        color: Colors.white,
        onRefresh: store.load,
        child: store.list.isEmpty
            ? Center(
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Center(
                    child: emptyPlaceholder,
                  ),
                ),
              )
            : ListView.separated(
                itemCount: store.list.length,
                itemBuilder: (context, index) {
                  return Observer(builder: (context) {
                    final follower = store.list[index];

                    if (isLoggedUser) {
                      return Dismissible(
                        key: Key(follower.sId),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) => store.remove(follower.sId),
                        background: DismissibleBackground(
                          icon: Icons.delete,
                          title: 'Remover',
                          color: AppColors.red,
                          secondary: true,
                        ),
                        child: _buildItem(context, follower),
                      );
                    }

                    return _buildItem(context, follower);
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

  Widget _buildItem(BuildContext context, FollowerModel model) {
    return ListTile(
      onTap: () => _navigateToProfileView(context, model.user.sId),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      leading: ProfileAvatar(
        image: model.user.photo,
        radius: 18,
        borderGap: 2,
        iconSize: 24,
        backgroundColor: AppColors.orange,
      ),
      title: Text(model.user.name),
      trailing: !isLoggedUser ||
              model.followingStatus.contains(FriendshipStatusTypes.accepted)
          ? Icon(
              Icons.double_arrow_rounded,
              color: AppColors.darkBlue,
              size: 16,
            )
          : OutlinedButton(
              onPressed:
                  model.followingStatus.contains(FriendshipStatusTypes.pending)
                      ? model.followingRequestId != null
                          ? () => store.removeRequest(
                              model.sId, model.followingRequestId!)
                          : null
                      : () => store.request(model.user.sId),
              style: ButtonStyle(
                foregroundColor:
                    MaterialStateProperty.all<Color>(AppColors.orange),
                side: MaterialStateProperty.all(
                    BorderSide(color: AppColors.orange)),
                overlayColor: MaterialStateProperty.all<Color>(
                    AppColors.orange.withOpacity(0.1)),
              ),
              child: Text(
                model.followingStatus.contains(FriendshipStatusTypes.pending)
                    ? 'pendente'
                    : 'seguir',
              ),
            ),
    );
  }

  Future<void> _navigateToProfileView(
      BuildContext context, String userId) async {
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ProfileView(userId: userId),
    ));

    store.load();
  }
}
