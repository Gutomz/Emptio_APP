import 'package:emptio/common/delegates/market_search/market_search.dart';
import 'package:emptio/common/widgets/dismissible_background.widget.dart';
import 'package:emptio/common/widgets/error_placeholder.widget.dart';
import 'package:emptio/common/widgets/image_builder.widget.dart';
import 'package:emptio/common/widgets/product_header.widget.dart';
import 'package:emptio/common/widgets/subtitle_item.widget.dart';
import 'package:emptio/core/app_colors.dart';
import 'package:emptio/models/market.model.dart';
import 'package:emptio/views/favorite_details/store/favorite_details.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:emptio/helpers/extensions.dart';

class FavoriteDetailsView extends StatelessWidget {
  final FavoriteDetailsStore _store;

  FavoriteDetailsView({Key? key, required String favoriteId})
      : _store = FavoriteDetailsStore(favoriteId: favoriteId),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes"),
      ),
      body: Observer(builder: (context) {
        if (_store.loading) {
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
              retry: _store.load,
            ),
          );
        }

        if (!_store.favoriteLoaded) {
          return Center(
            child: ErrorPlaceholder(
              error: "Ocorreu um error inesperado!",
              retry: _store.load,
            ),
          );
        }

        final favorite = _store.favorite!;

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 50),
                child: ProductHeader(product: favorite.product),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Mercados conectados",
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.blue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextButton(
                          onPressed: () => _searchMarket(context),
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all(AppColors.orange),
                            overlayColor:
                                MaterialStateProperty.all(Colors.orange[50]),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.add, size: 16),
                              Text('adicionar'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    if (favorite.markets.isEmpty)
                      Text(
                        "Nenhum mercado conectado.",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.grey,
                        ),
                      ),
                  ],
                ),
              ),
              if (favorite.markets.isNotEmpty)
                ..._buildMarketList(context, favorite.markets),
            ],
          ),
        );
      }),
    );
  }

  List<Widget> _buildMarketList(
          BuildContext context, List<MarketModel> markets) =>
      markets
          .map<Widget>((market) => Column(
                children: [
                  Dismissible(
                    key: Key(market.sId),
                    onDismissed: (direction) => _store.removeMarket(market.sId),
                    background: DismissibleBackground(
                      color: AppColors.red,
                      icon: Icons.delete,
                      title: "Remover",
                      secondary: true,
                    ),
                    direction: DismissDirection.endToStart,
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      leading: ImageBuilder.fromString(
                        market.image,
                        size: 60,
                        iconSize: 22,
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
                  ),
                  Divider(height: 1, color: AppColors.lightGrey),
                ],
              ))
          .toList();

  Future<void> _searchMarket(BuildContext context) async {
    final response = await showSearch(
      context: context,
      delegate: MarketSearch(favoriteId: _store.favoriteId),
    );

    if (response == null) return;

    if (_store.favorite!.markets.containElement(
        (e) => (e.placeId == response.sId) || (e.sId == response.sId))) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Este mercado já está conectado!")));
      return;
    }

    if (response.isSuggestion) {
      _store.addMarket(placeId: response.sId);
    } else {
      _store.addMarket(marketId: response.sId);
    }
  }
}
