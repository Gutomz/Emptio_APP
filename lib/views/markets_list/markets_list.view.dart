import 'package:emptio/common/widgets/dismissible_background.widget.dart';
import 'package:emptio/common/widgets/empty_placeholder.widget.dart';
import 'package:emptio/common/widgets/error_placeholder.widget.dart';
import 'package:emptio/common/widgets/image_builder.widget.dart';
import 'package:emptio/common/widgets/search_dialog.widget.dart';
import 'package:emptio/common/widgets/simple_confirm_dialog.widget.dart';
import 'package:emptio/common/widgets/subtitle_item.widget.dart';
import 'package:emptio/core/app_assets.dart';
import 'package:emptio/core/app_colors.dart';
import 'package:emptio/models/market.model.dart';
import 'package:emptio/models/product.model.dart';
import 'package:emptio/views/market_details/market_details.view.dart';
import 'package:emptio/views/markets_list/store/markets_list.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class MarketsListView extends StatelessWidget {
  final MarketsListStore _store = MarketsListStore();

  MarketsListView({Key? key}) : super(key: key);

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
        title: GestureDetector(
          onTap: () => openSearch(context),
          child: LayoutBuilder(
            builder: (context, constraints) => SizedBox(
              width: constraints.biggest.width,
              child: Observer(builder: (_) {
                return Text(
                  _store.search.isNotEmpty
                      ? _store.search
                      : "Lista de Mercados",
                );
              }),
            ),
          ),
        ),
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
        if (_store.firstLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.orange,
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
                        title: "Nenhum mercado cadastrado!",
                        subTitle: "Arraste para recarregar.",
                        asset: AppAssets.svgIcPurchaseItemsEmpty,
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
                      final market = _store.list[index];

                      return Dismissible(
                        key: Key(market.sId),
                        onDismissed: (direction) =>
                            _store.deleteMarket(market.sId),
                        confirmDismiss: (direction) =>
                            _confirmDismiss(context, direction, market),
                        direction: DismissDirection.endToStart,
                        background: DismissibleBackground(
                          title: "Excluir",
                          icon: Icons.delete_forever_rounded,
                          color: AppColors.red,
                          secondary: true,
                        ),
                        child: ListTile(
                          onTap: () =>
                              _navigateToMarketDetails(context, market),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          leading: SizedBox(
                            child: ImageBuilder.fromString(
                              market.image,
                              size: 60,
                              iconSize: 22,
                            ),
                          ),
                          title: Text(
                            market.name,
                            style: TextStyle(
                              color: AppColors.blue,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Column(
                            children: [
                              SizedBox(height: 10),
                              SubtitleItem(
                                icon: Icons.location_on_outlined,
                                text: market.address,
                                canWrap: true,
                              ),
                            ],
                          ),
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
      MarketModel model) async {
    final response = await showDialog(
      context: context,
      builder: (context) => SimpleConfirmDialog(
        title: "Excluir mercado?",
        content: "Tem certeza que deseja excluir este mercado? (${model.name})",
        acceptText: "excluir",
        rejectText: "cancelar",
      ),
    );

    return response != null && response == true;
  }

  void _navigateToMarketDetails(BuildContext context, MarketModel model) {
    Navigator.push<ProductModel>(
      context,
      MaterialPageRoute(
          builder: (context) => MarketDetailsView(sId: model.sId)),
    );
  }
}
