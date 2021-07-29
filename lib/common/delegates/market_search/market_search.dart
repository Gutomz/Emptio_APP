import 'package:emptio/common/delegates/market_search/store/market_search.store.dart';
import 'package:emptio/common/widgets/error_placeholder.widget.dart';
import 'package:emptio/common/widgets/subtitle_item.widget.dart';
import 'package:emptio/core/app_colors.dart';
import 'package:emptio/models/market_suggestion.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:emptio/helpers/extensions.dart';

class MarketSearchResponse {
  String? sId;
  bool isSuggestion;
  bool isNew;

  MarketSearchResponse({
    this.sId,
    this.isSuggestion = false,
    this.isNew = false,
  }) : assert(!(isNew && isSuggestion) && !(isNew && sId == null));
}

class MarketSearch extends SearchDelegate<MarketSearchResponse?> {
  final MarketSearchStore _store = MarketSearchStore();

  @override
  String? get searchFieldLabel => "Pesquisar mercado";

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      textTheme: TextTheme(
        headline6: TextStyle(
          color: Colors.white,
          decoration: TextDecoration.none,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: InputBorder.none,
        errorBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white70),
      ),
      textSelectionTheme: TextSelectionThemeData(cursorColor: AppColors.orange),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.clear),
        ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty && query.length > 1) {
      _store.loadSuggestions(query);
    }

    return Observer(builder: (context) {
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
            retry: () => _store.loadSuggestions(query),
          ),
        );
      }

      if (_store.suggestionList.isEmpty) {
        return Center(
          child: Text(
            'Nenhum mercado encontrado.',
            style: TextStyle(color: AppColors.black),
            textAlign: TextAlign.center,
          ),
        );
      }

      return ListView.separated(
        itemCount: _store.suggestionsCount,
        separatorBuilder: (context, index) => Divider(
          height: 1,
          color: AppColors.lightGrey,
        ),
        itemBuilder: (context, index) {
          final suggestion = _store.suggestionList[index];

          return ListTile(
            onTap: () => _onPressedSuggestion(context, suggestion),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            title: Text(
              suggestion.name,
              style: TextStyle(color: AppColors.blue),
            ),
            subtitle: Column(
              children: [
                SizedBox(height: 10),
                SubtitleItem(
                  icon: Icons.location_on_outlined,
                  text: suggestion.address,
                  canWrap: true,
                ),
                SizedBox(height: 5),
                SubtitleItem(
                  icon: Icons.directions_walk_rounded,
                  text: suggestion.distanceMeters.formatDistance(),
                ),
              ],
            ),
          );
        },
      );
    });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(
        "Nenhuma mercado encontrado!",
        style: TextStyle(
          color: AppColors.grey,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Future<void> _onPressedSuggestion(
      BuildContext context, MarketSuggestion suggestion) async {
    final response = MarketSearchResponse(
      sId: suggestion.sId,
      isSuggestion: true,
    );

    close(context, response);
  }
}

// class AddProductTile extends StatelessWidget {
//   final String title;
//   final Function() onTap;

//   const AddProductTile({
//     required this.title,
//     required this.onTap,
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       onTap: () => onTap(),
//       tileColor: Colors.white,
//       leading: Icon(
//         Icons.add_circle_outline_outlined,
//         color: AppColors.grey,
//       ),
//       minLeadingWidth: 55,
//       title: Text(
//         title,
//         style: TextStyle(
//           color: AppColors.grey,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//       trailing: Icon(
//         Icons.double_arrow_rounded,
//         size: 16,
//         color: AppColors.grey,
//       ),
//     );
//   }
// }
