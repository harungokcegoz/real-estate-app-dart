import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiClient {
  static String get _baseUrl => dotenv.env['API_BASE_URL'] ?? '';
  static String get _apiKey => dotenv.env['API_KEY'] ?? '';

  static Dio get dio {
    final dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        headers: {'Access-Key': _apiKey},
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 3),
      ),
    );

    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
      ),
    );

    return dio;
  }
} 