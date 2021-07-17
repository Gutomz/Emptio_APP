import 'package:emptio/core/app_api.dart';
import 'package:emptio/models/base_purchase_item.model.dart';
import 'package:emptio/models/follower.model.dart';
import 'package:emptio/models/location.model.dart';
import 'package:emptio/models/market.model.dart';
import 'package:emptio/models/measurement.model.dart';
import 'package:emptio/models/product.model.dart';
import 'package:emptio/models/product_market.model.dart';
import 'package:emptio/models/profile_user.model.dart';
import 'package:emptio/models/purchase_item.model.dart';
import 'package:emptio/models/user_configurations.model.dart';

class JsonParser {
  static double parseToDouble(dynamic value) {
    try {
      return (value as num).toDouble();
    } catch (_) {
      return 0;
    }
  }

  static int parseToInt(dynamic value) {
    try {
      return (value as num).toInt();
    } catch (_) {
      return 0;
    }
  }

  static bool parseToBool(dynamic value) {
    try {
      return value as bool;
    } catch (_) {
      return false;
    }
  }

  static String parseToString(dynamic value) {
    try {
      return value as String;
    } catch (_) {
      return "";
    }
  }

  static String? parseToNullableString(dynamic value) {
    try {
      return value as String;
    } catch (_) {
      return null;
    }
  }

  static List<String> parseToStringList(dynamic value) {
    final list = List<String>.empty(growable: true);
    try {
      if (value != null) {
        final items = value as List<dynamic>;
        for (final item in items) {
          list.add(item as String);
        }
      }
    } catch (_) {}
    return list;
  }

  static Map<String, dynamic> parseToJsonObject(dynamic value) {
    try {
      return value as Map<String, dynamic>;
    } catch (_) {
      return {};
    }
  }

  static String? parseToImageUrl(dynamic value) {
    String? url;
    try {
      if ((value as String).isNotEmpty) url = AppApi.getUrl(value);
    } catch (_) {}

    return url;
  }

  static LocationModel? parseToLocation(dynamic value) {
    try {
      return LocationModel.fromJson(value as Map<String, dynamic>);
    } catch (_) {
      return null;
    }
  }

  static MeasurementModel? parseToMeasurement(dynamic value) {
    try {
      return MeasurementModel.fromJson(value as Map<String, dynamic>);
    } catch (_) {
      return null;
    }
  }

  static ProfileUserModel? parseToProfileUser(dynamic value) {
    try {
      return ProfileUserModel.fromJson(value as Map<String, dynamic>);
    } catch (_) {
      return null;
    }
  }

  static UserConfigurationsModel? parseToUserConfiguration(dynamic value) {
    try {
      return UserConfigurationsModel.fromJson(value as Map<String, dynamic>);
    } catch (_) {
      return null;
    }
  }

  static MarketModel? parseToMarket(dynamic value) {
    try {
      return MarketModel.fromJson(value as Map<String, dynamic>);
    } catch (_) {
      return null;
    }
  }

  static ProductModel? parseToProduct(dynamic value) {
    try {
      return ProductModel.fromJson(value as Map<String, dynamic>);
    } catch (_) {
      return null;
    }
  }

  static ProductMarketModel? parseToProductMarket(dynamic value) {
    try {
      return ProductMarketModel.fromJson(value as Map<String, dynamic>);
    } catch (_) {
      return null;
    }
  }

  static List<PurchaseItemModel> parseToPurchaseItemList(dynamic value) {
    final list = List<PurchaseItemModel>.empty(growable: true);
    try {
      if (value != null) {
        final items = value as List<dynamic>;
        for (final item in items) {
          list.add(PurchaseItemModel.fromJson(item as Map<String, dynamic>));
        }
      }
    } catch (_) {}
    return list;
  }

  static List<BasePurchaseItemModel> parseToBasePurchaseItemList(
      dynamic value) {
    final list = List<BasePurchaseItemModel>.empty(growable: true);
    try {
      if (value != null) {
        final items = value as List<dynamic>;
        for (final item in items) {
          list.add(
              BasePurchaseItemModel.fromJson(item as Map<String, dynamic>));
        }
      }
    } catch (_) {}
    return list;
  }

  static FollowerUserModel? parseToFollowerUser(dynamic value) {
    try {
      return FollowerUserModel.fromJson(value as Map<String, dynamic>);
    } catch (_) {
      return null;
    }
  }
}
