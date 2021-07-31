import 'package:emptio/common/widgets/error_placeholder.widget.dart';
import 'package:emptio/common/widgets/image_builder.widget.dart';
import 'package:emptio/core/app_colors.dart';
import 'package:emptio/models/market.model.dart';
import 'package:emptio/views/market_details/store/market_details.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:url_launcher/url_launcher.dart';

class MarketDetailsView extends StatelessWidget {
  final MarketDetailsStore _store;

  MarketDetailsView({Key? key, required String sId})
      : _store = MarketDetailsStore(sId: sId),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes do Mercado"),
      ),
      body: SingleChildScrollView(
        child: Observer(builder: (context) {
          if (_store.loading) {
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
                retry: _store.load,
              ),
            );
          }

          if (!_store.marketLoaded) {
            return Center(
              child: ErrorPlaceholder(
                error: "Ocorreu um erro inesperado!",
                retry: _store.load,
              ),
            );
          }

          final market = _store.market!;

          return Padding(
            padding:
                const EdgeInsets.only(top: 50, left: 15, right: 15, bottom: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(8),
                        child: Hero(
                          tag: market.sId,
                          child: ImageBuilder.fromString(
                            market.image,
                            size: 75,
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      Flexible(
                        child: Text(
                          market.name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25),
                _buildAddress(context, market),
                SizedBox(height: 25),
                _buildOpenHours(context, market),
                SizedBox(height: 25),
                _buildContacts(context, market),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildTitle(BuildContext context, String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildAddress(BuildContext context, MarketModel market) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(context, "Endereço"),
        Text(
          market.address ?? "Nenhum endereço cadastrado.",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildOpenHours(BuildContext context, MarketModel market) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(context, "Horários de Funcionamento"),
        if (market.openingHours.isEmpty)
          Text(
            "Nenhum dado cadastrado.",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ...market.openingHours.map<Widget>((e) {
          final split = e.split(": ");
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: "${split[0]}: ",
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  children: [
                    TextSpan(
                      text: split[1],
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
            ],
          );
        }),
      ],
    );
  }

  Widget _buildContacts(BuildContext context, MarketModel market) {
    final itemTitleTextStyle = TextStyle(
      color: AppColors.grey,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    );

    final itemBodyTextStyle = TextStyle(
      fontWeight: FontWeight.w700,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(context, "Contato"),
        GestureDetector(
          onTap: market.phone != null
              ? () => _onTapPhoneContact(market.phone!)
              : null,
          child: RichText(
            text: TextSpan(
              text: "Telefone: ",
              style: itemTitleTextStyle,
              children: [
                TextSpan(
                  text: market.phone ?? "-",
                  style: itemBodyTextStyle,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 5),
        GestureDetector(
          onTap: market.website != null
              ? () => _onTapWebsiteContact(market.website!)
              : null,
          child: RichText(
            text: TextSpan(
              text: "Website: ",
              style: itemTitleTextStyle,
              children: [
                TextSpan(
                  text: market.website ?? "-",
                  style: itemBodyTextStyle,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _onTapPhoneContact(String phone) async {
    final url = "tel:$phone";
    if (await canLaunch(url)) {
      launch(url);
    }
  }

  Future<void> _onTapWebsiteContact(String website) async {
    if (await canLaunch(website)) {
      launch(website);
    }
  }
}
