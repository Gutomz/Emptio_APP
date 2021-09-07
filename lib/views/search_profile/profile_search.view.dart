import 'package:emptio/common/widgets/empty_placeholder.widget.dart';
import 'package:emptio/common/widgets/error_placeholder.widget.dart';
import 'package:emptio/common/widgets/profile_avatar.widget.dart';
import 'package:emptio/common/widgets/search_dialog.widget.dart';
import 'package:emptio/core/app_assets.dart';
import 'package:emptio/core/app_colors.dart';
import 'package:emptio/models/friendship_request.model.dart';
import 'package:emptio/models/profile_search.model.dart';
import 'package:emptio/views/profile/profile.view.dart';
import 'package:emptio/views/search_profile/store/profile_search.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ProfileSearchView extends StatelessWidget {
  final ProfileSearchStore _store = ProfileSearchStore();

  ProfileSearchView({Key? key}) : super(key: key);

  Future<void> openSearch(BuildContext context) async {
    final search = await showDialog<String?>(
      context: context,
      builder: (context) => SearchDialog(currentSearch: _store.search),
    );

    if (search != null) {
      _store.setSearch(search);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Observer(builder: (context) {
          return GestureDetector(
            onTap: () => openSearch(context),
            child: LayoutBuilder(
              builder: (context, constraints) => SizedBox(
                width: constraints.biggest.width,
                child: Observer(builder: (_) {
                  return Text(
                      _store.search.isNotEmpty ? _store.search : "Pesquisar");
                }),
              ),
            ),
          );
        }),
        actions: [
          Observer(builder: (_) {
            if (_store.search.isNotEmpty) {
              return IconButton(
                onPressed: () => _store.setSearch(""),
                icon: Icon(Icons.close),
              );
            }

            return IconButton(
              onPressed: () => openSearch(context),
              icon: Icon(Icons.search),
            );
          }),
        ],
      ),
      body: Observer(builder: (context) {
        if (_store.isFirstLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.darkOrange,
              strokeWidth: 2,
            ),
          );
        }

        if (_store.hasError) {
          return Center(
            child: ErrorPlaceholder(
              error: _store.error,
              retry: _store.reset,
            ),
          );
        }

        return RefreshIndicator(
          backgroundColor: AppColors.lightBlue,
          color: Colors.white,
          onRefresh: _store.reset,
          child: _store.list.isEmpty
              ? Center(
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Center(
                      child: EmptyPlaceholder(
                        title: "Pesquise um perfil.",
                        subTitle: "Arraste para recarregar.",
                        asset: AppAssets.svgIcFollowersEmpty,
                      ),
                    ),
                  ),
                )
              : ListView.separated(
                  itemCount: _store.itemsCount,
                  separatorBuilder: (context, index) => Divider(
                    height: 1,
                    color: AppColors.lightGrey,
                  ),
                  itemBuilder: (context, index) {
                    if (index < _store.list.length) {
                      final user = _store.list[index];

                      return _buildItem(context, user);
                    }

                    _store.loadNextPage();
                    return SizedBox(
                      height: 5,
                      child: LinearProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation(AppColors.darkOrange),
                      ),
                    );
                  },
                ),
        );
      }),
    );
  }

  Widget _buildItem(BuildContext context, ProfileSearchModel model) {
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
      trailing: model.friendshipStatus.contains(FriendshipStatusTypes.accepted)
          ? Icon(
              Icons.double_arrow_rounded,
              color: AppColors.darkBlue,
              size: 16,
            )
          : OutlinedButton(
              onPressed:
                  model.friendshipStatus.contains(FriendshipStatusTypes.pending)
                      ? model.friendshipId != null
                          ? () => _store.removeRequest(
                              model.user.sId, model.friendshipId!)
                          : null
                      : () => _store.request(model.user.sId),
              style: ButtonStyle(
                foregroundColor:
                    MaterialStateProperty.all<Color>(AppColors.orange),
                side: MaterialStateProperty.all(
                    BorderSide(color: AppColors.orange)),
                overlayColor: MaterialStateProperty.all<Color>(
                    AppColors.orange.withOpacity(0.1)),
              ),
              child: Text(
                model.friendshipStatus.contains(FriendshipStatusTypes.pending)
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

    _store.reset();
  }
}
