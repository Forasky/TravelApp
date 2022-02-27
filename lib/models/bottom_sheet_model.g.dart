// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bottom_sheet_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BottomSheetState _$BottomSheetStateFromJson(Map<String, dynamic> json) =>
    BottomSheetState(
      regions: (json['regions'] as List<dynamic>)
          .map((e) => Region.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Region _$RegionFromJson(Map<String, dynamic> json) => Region(
      name: json['name'] as String,
      cities: (json['cities'] as List<dynamic>)
          .map((e) => City.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

City _$CityFromJson(Map<String, dynamic> json) => City(
      name: json['name'] as String,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );
