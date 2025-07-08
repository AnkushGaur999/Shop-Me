import 'package:dio/dio.dart';
import 'package:shop_me/core/constants/app_apis.dart';

class DioClient {
  late Dio _dio;

  factory DioClient() {
    return _singleton;
  }

  static final DioClient _singleton = DioClient._internal();

  DioClient._internal() {
    _dio = Dio()
      ..options.baseUrl = AppApis.baseUrl
      ..options.connectTimeout = const Duration(seconds: 30)
      ..options.receiveTimeout = const Duration(seconds: 30)
      ..options.sendTimeout = const Duration(seconds: 30);
  }

  Future<Response> get({
    required String url,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(url, queryParameters: queryParameters);
      return response;
    } on DioException catch (_) {
      rethrow;
    }
  }

  Future<Response> post({
    required String url,
    required Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (_) {
      rethrow;
    }
  }
}
