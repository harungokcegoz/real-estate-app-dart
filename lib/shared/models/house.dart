import 'package:freezed_annotation/freezed_annotation.dart';

part 'house.freezed.dart';
part 'house.g.dart';

@freezed
class House with _$House {
  const factory House({
    required int id,
    required String image,
    required int price,
    required int bedrooms,
    required int bathrooms,
    required int size,
    required String zip,
    required String city,
    required double latitude,
    required double longitude,
    required DateTime createdDate,
    required String description,
  }) = _House;

  factory House.fromJson(Map<String, dynamic> json) => _$HouseFromJson(json);
} 