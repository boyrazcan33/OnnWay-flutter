// lib/data/repository/route_repository.dart
import 'package:flutter/foundation.dart';
import '../api/api_service.dart';
import '../models/route_request.dart';
import '../models/route_response.dart';
import '../models/attraction.dart';

class RouteRepository {
  final ApiService _apiService;

  RouteRepository({ApiService? apiService})
      : _apiService = apiService ?? ApiService();

  // Create route with error handling
  Future<RouteResponse> createRoute(RouteRequest request) async {
    try {
      return await _apiService.createRoute(request);
    } catch (e) {
      debugPrint('RouteRepository Error: $e');
      throw Exception('Failed to create route: $e');
    }
  }

  // Get all attractions (Tallinn + Istanbul)
  Future<List<Attraction>> getAllAttractions() async {
    try {
      final tallinnAttractions = await _apiService.getAttractions('TALLINN');
      final istanbulAttractions = await _apiService.getAttractions('ISTANBUL');
      return [...tallinnAttractions, ...istanbulAttractions];
    } catch (e) {
      debugPrint('RouteRepository Error: $e');
      throw Exception('Failed to fetch attractions: $e');
    }
  }
}