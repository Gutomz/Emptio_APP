import 'package:emptio/common/widgets/dismissible_background.widget.dart';
import 'package:emptio/common/widgets/empty_placeholder.widget.dart';
import 'package:emptio/common/widgets/error_placeholder.widget.dart';
import 'package:emptio/common/widgets/main_app_bar.widget.dart';
import 'package:emptio/common/widgets/notification_action_button.widget.dart';
import 'package:emptio/common/widgets/product_tile.widget.dart';
import 'package:emptio/common/widgets/simple_confirm_dialog.widget.dart';
import 'package:emptio/core/app_assets.dart';
import 'package:emptio/core/app_colors.dart';
import 'package:emptio/models/favorites.model.dart';
import 'package:emptio/models/product.model.dart';
import 'package:emptio/stores/app.store.dart';
import 'package:emptio/views/favorite_details/favorite_details.view.dart';
import 'package:emptio/views/favorites/store/favorites.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class FavoritesView extends StatelessWidget {
  final FavoritesStore _store = GetIt.I<AppStore>().favoritesStore;

  FavoritesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: Text("Favoritos"),
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
                      child: EmptyPlaceholderCreation(
                        asset: AppAssets.svgIcFavoritesEmpty,
                        title: "Nenhum favorito foi encontrado!",
                        subTitleBefore: "Clique em",
                        subTitleAfter: "para adicionar um novo!",
                        icon: Icons.favorite_border_rounded,
                      ),
                    ),
                  ),
                )
              : ListView.separated(
                  itemCount: _store.listCount,
                  separatorBuilder: (context, index) => Divider(
                    height: 1,
                    color: AppColors.lightGrey,
                  ),
                  itemBuilder: (context, index) {
                    if (index < _store.list.length) {
                      final favorite = _store.list[index];

                      return Dismissible(
                        key: Key(favorite.sId),
                        onDismissed: (direction) => _store.delete(favorite.sId),
                        confirmDismiss: (direction) => _confirmDismiss(
                            context, direction, favorite.product),
                        direction: DismissDirection.endToStart,
                        background: DismissibleBackground(
                          title: "Excluir",
                          icon: Icons.delete_forever_rounded,
                          color: AppColors.red,
                          secondary: true,
                        ),
                        child: ProductTile(
                          favorite.product,
                          onTap: () =>
                              _navigateToFavoriteDetails(context, favorite),
                          hidePrice: true,
                          isFavorite: true,
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

  Future<bool> _confirmDismiss(BuildContext context, DismissDirection direction,
      ProductModel model) async {
    final response = await showDialog(
      context: context,
      builder: (context) => SimpleConfirmDialog(
        title: "Excluir favorito?",
        content:
            "Tem certeza que deseja remover este produto dos seus favoritos? (${model.getCombinedName()})",
        acceptText: "excluir",
        rejectText: "cancelar",
      ),
    );

    return response != null && response == true;
  }

  Future<void> _navigateToFavoriteDetails(
      BuildContext context, FavoritesModel favorite) async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FavoriteDetailsView(
          favoriteId: favorite.sId,
        ),
      ),
    );
  }
}
