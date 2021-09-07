import 'package:emptio/common/widgets/empty_placeholder.widget.dart';
import 'package:emptio/common/widgets/error_placeholder.widget.dart';
import 'package:emptio/core/app_assets.dart';
import 'package:emptio/core/app_colors.dart';
import 'package:emptio/views/feed/widgets/post.widget.dart';
import 'package:emptio/views/profile_posts/store/profile_posts.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ProfilePostsView extends StatelessWidget {
  final ProfilePostsStore _store;

  final Function()? onUpdateList;

  ProfilePostsView(
    String userId, {
    Key? key,
    bool isMe = false,
    bool lock = false,
    this.onUpdateList,
  })  : _store = ProfilePostsStore(userId, isMe: isMe, lock: lock),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      if (_store.firstLoading) {
        return Center(
          child: CircularProgressIndicator(
            color: AppColors.darkOrange,
            strokeWidth: 3,
          ),
        );
      }

      if (_store.hasError) {
        return Center(
          child: ErrorPlaceholder(
            error: _store.error,
            retry: _store.resetPage,
          ),
        );
      }

      if (_store.list.isEmpty) {
        return Center(
          child: Center(
            child: EmptyPlaceholder(
              asset: AppAssets.svgIcFollowersEmpty,
              title: "Nenhuma publicação encontrada.",
              subTitle: "Volte mais tarde para mais atualizações!",
              hideScrollIndicator: true,
            ),
          ),
        );
      }

      return ListView.builder(
        itemCount: _store.listCount,
        padding: EdgeInsets.only(top: 20),
        itemBuilder: (context, index) {
          if (index < _store.list.length) {
            final post = _store.list[index];

            return Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: PostWidget(
                post: post,
                canDelete: _store.isMe,
                onDelete: () {
                  _store.delete(post.sId);
                  if (onUpdateList != null) {
                    onUpdateList!();
                  }
                },
              ),
            );
          }

          _store.loadNextPage();
          return SizedBox(
            height: 5,
            child: LinearProgressIndicator(
              valueColor: AlwaysStoppedAnimation(AppColors.darkOrange),
            ),
          );
        },
      );
    });
  }
}
