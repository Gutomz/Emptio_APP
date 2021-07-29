import 'package:emptio/helpers/parsers.dart';

class MarketSuggestion {
  final String sId;
  final String name;
  final String address;
  final String description;
  final double distanceMeters;

  MarketSuggestion({
    required this.sId,
    required this.name,
    required this.address,
    required this.description,
    required this.distanceMeters,
  });

  factory MarketSuggestion.fromJson(Map<String, dynamic> json) {
    final model = MarketSuggestion(
      sId: JsonParser.parseToString(json['place_id']),
      name:
          JsonParser.parseToString(json['structured_formatting']['main_text']),
      address: JsonParser.parseToString(
          json['structured_formatting']['secondary_text']),
      description: JsonParser.parseToString(json['description']),
      distanceMeters: JsonParser.parseToDouble(json['distance_meters']),
    );

    return model;
  }
}
