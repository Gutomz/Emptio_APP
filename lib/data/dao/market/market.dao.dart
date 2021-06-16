import 'package:emptio/data/database.dart';
import 'package:emptio/data/models/market/market.dart';
import 'package:emptio/models/market.model.dart';
import 'package:hive/hive.dart';

class MarketDao {
  Box<Market>? _mBox;

  Future<void> openBox() async {
    if (_mBox == null) {
      _mBox = await Hive.openBox<Market>(Database.marketBoxName);
    }
  }

  Future<MarketModel> get(int key) async {
    await openBox();

    Market? market = _mBox!.get(key);

    if (market != null) {
      return parseToMarketModel(market);
    }

    // TODO - create error structure
    throw {
      "code": "product_not_found",
    };
  }

  Future<MarketModel> parseToMarketModel(Market market) async {
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
