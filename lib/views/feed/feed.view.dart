import 'package:emptio/common/widgets/empty_placeholder.widget.dart';
import 'package:emptio/common/widgets/error_placeholder.widget.dart';
import 'package:emptio/common/widgets/main_app_bar.widget.dart';
import 'package:emptio/common/widgets/notification_action_button.widget.dart';
import 'package:emptio/core/app_assets.dart';
import 'package:emptio/core/app_colors.dart';
import 'package:emptio/stores/app.store.dart';
import 'package:emptio/views/feed/store/feed.store.dart';
import 'package:emptio/views/feed/widgets/post.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class FeedView extends StatelessWidget {
  final FeedStore _store = GetIt.I<AppStore>().feedStore;

  FeedView({Key? key}) : super(key: key);

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
      body: Observer(builder: (context) {
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

        return RefreshIndicator(
          backgroundColor: AppColors.lightBlue,
          color: Colors.white,
          onRefresh: _store.resetPage,
          child: _store.list.isEmpty
              ? Center(
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Center(
                      child: EmptyPlaceholder(
                        asset: AppAssets.svgIcPostsEmpty,
                        title: "Nenhuma publicação encontrada.",
                        subTitle: "Volte mais tarde para mais atualizações!",
                      ),
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: _store.listCount,
                  padding: EdgeInsets.only(top: 20, bottom: 25),
                  itemBuilder: (context, index) {
                    if (index < _store.list.length) {
                      final post = _store.list[index];

                      return Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: PostWidget(
                          post: post,
                          onDelete: () => _store.delete(post.sId),
                        ),
                      );
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
}
