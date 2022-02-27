import 'package:json_annotation/json_annotation.dart';

part 'bottom_sheet_model.g.dart';

@JsonSerializable()
class BottomSheetState {
  BottomSheetState({
    required this.regions,
  });

  final List<Region> regions;

  factory BottomSheetState.fromJson(Map<String, dynamic> json) =>
      BottomSheetState(
        regions:
            List<Region>.from(json["regions"].map((x) => Region.fromJson(x))),
      );
}

@JsonSerializable()
class Region {
  Region({
    required this.name,
    required this.cities,
  });

  final String name;
  final List<City> cities;

  factory Region.fromJson(Map<String, dynamic> json) => Region(
        name: json["name"],
        cities: List<City>.from(json["cities"].map((x) => City.fromJson(x))),
      );
}

@JsonSerializable()
class City {
  City({
    required this.name,
    required this.lat,
    required this.lng,
  });

  final String name;
  final double lat;
  final double lng;

  factory City.fromJson(Map<String, dynamic> json) => City(
        name: json["name"],
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
      );
}
