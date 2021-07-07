import 'package:emptio/core/app_errors.dart';
import 'package:emptio/data/database.dart';
import 'package:emptio/data/database_errors.dart';
import 'package:emptio/data/models/market/market.dart';
import 'package:emptio/models/market.model.dart';
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

  static Future<MarketModel> getParsed(int key) async {
    final Market market = await get(key);

    return parseToMarketModel(market);
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
