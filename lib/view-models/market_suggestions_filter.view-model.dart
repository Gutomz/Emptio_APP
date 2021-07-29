import 'package:emptio/models/location.model.dart';

class MarketSuggestionFilterViewModel {
  String input;
  LocationModel origin;
  LocationModel location;
  double radius;
  String language;

  MarketSuggestionFilterViewModel({
    required this.input,
    required this.origin,
    required this.location,
    this.radius = 40000,
    this.language = 'pt-BR',
  });

  Map<String, String> toQuery() {
    final Map<String, String> data = <String, String>{};
    data['input'] = input;
    data['origin'] = origin.toString();
    data['location'] = location.toString();
    data['radius'] = radius.toStringAsFixed(0);
    data['language'] = language;
    data['types'] = "establishment";
    data['strictbounds'] = "true";
    return data;
  }
}
