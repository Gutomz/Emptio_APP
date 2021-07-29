import 'package:emptio/core/app_errors.dart';
import 'package:emptio/data/database.dart';
import 'package:emptio/data/database_errors.dart';
import 'package:emptio/data/models/market/market.dart';
import 'package:emptio/models/market.model.dart';
import 'package:emptio/view-models/market_filter.view-model.dart';
import 'package:hive/hive.dart';

class MarketDao {
  static Box<Market>? _mBox;

  static Future<void> _openBox() async {
    _mBox ??= await Hive.openBox<Market>(Database.marketBoxName);
  }

  static Future<Box<Market>> get instance async {
    await _openBox();

    return _mBox!;
  }

  static Future<Market> get(int key) async {
    await _openBox();

    final Market? market = _mBox!.get(key);

    if (market != null) {
      return market;
    }

    throw DatabaseError.notFoundError(AppErrors.marketNotFound);
  }

  static Future<List<Market>> getAll(MarketFilterViewModel filter) async {
    await _openBox();

    final Iterable<Market> list = _mBox!.values;

    filter.search = filter.search.toLowerCase();

    final List<Market> markets = (list
        .where((market) => market.name.toLowerCase().contains(filter.search))
        .toList())
      ..skip(filter.skip).take(filter.limit);

    return markets;
  }

  static Future<MarketModel> getParsed(int key) async {
    final Market market = await get(key);

    return parseToMarketModel(market);
  }

  static Future<List<MarketModel>> getAllParsed(
      MarketFilterViewModel filter) async {
    final List<MarketModel> models = List.empty(growable: true);
    final List<Market> markets = await getAll(filter);
    for (final market in markets) {
      final MarketModel model = await parseToMarketModel(market);
      models.add(model);
    }
    return models;
  }

  static Future<MarketModel> parseToMarketModel(Market market) async {
    return MarketModel(
      sId: market.key.toString(),
      placeId: market.key.toString(),
      name: market.name,
      openingHours: [],
      updatedAt: market.updatedAt,
      createdAt: market.createdAt,
    );
  }
}
