// lib/data/api/api_service.dart
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../models/route_request.dart';
import '../models/route_response.dart';
import '../models/attraction.dart';

class ApiService {
  static const String baseUrl =
      'https://route-backend-419380759408.us-central1.run.app/api/';

  late final Dio _dio;

  ApiService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Logging interceptor (only in debug mode)
    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          error: true,
        ),
      );
    }
  }

  // Create route - with performance logging
  Future<RouteResponse> createRoute(RouteRequest request) async {
    final startTime = DateTime.now();

    try {
      final response = await _dio.post(
        'route/create',
        data: request.toJson(),
      );

      final duration = DateTime.now().difference(startTime);
      debugPrint('API_PERF: SUCCESS - ${duration.inMilliseconds}ms');

      return RouteResponse.fromJson(response.data);
    } catch (e) {
      final duration = DateTime.now().difference(startTime);
      debugPrint('API_PERF: FAILED - ${duration.inMilliseconds}ms - $e');
      rethrow;
    }
  }

  // Get attractions by city
  Future<List<Attraction>> getAttractions(String city) async {
    try {
      final response = await _dio.get(
        'attractions',
        queryParameters: {'city': city},
      );

      final List<dynamic> data = response.data;
      return data.map((json) => Attraction.fromJson(json)).toList();
    } catch (e) {
      debugPrint('Error fetching attractions: $e');
      rethrow;
    }
  }
}