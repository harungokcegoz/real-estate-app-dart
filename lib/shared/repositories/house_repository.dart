import 'package:dio/dio.dart';
import 'package:real_estate_app/core/network/api_client.dart';
import 'package:real_estate_app/shared/models/house.dart';

class HouseRepository {
  final Dio _dio = ApiClient.dio;

  Future<List<House>> getHouses() async {
    try {
      final response = await _dio.get('/house');
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => House.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load houses');
      }
    } catch (e) {
      throw Exception('Failed to load houses: $e');
    }
  }

  Future<House> getHouseById(int id) async {
    try {
      final response = await _dio.get('/house/$id');
      
      if (response.statusCode == 200) {
        return House.fromJson(response.data);
      } else {
        throw Exception('Failed to load house details');
      }
    } catch (e) {
      throw Exception('Failed to load house details: $e');
    }
  }
} 