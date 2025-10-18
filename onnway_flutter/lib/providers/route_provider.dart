// lib/providers/route_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/repository/route_repository.dart';
import '../data/models/route_response.dart';
import '../data/models/route_request.dart';
import '../data/models/attraction.dart';

// Repository provider
final routeRepositoryProvider = Provider<RouteRepository>((ref) {
  return RouteRepository();
});

// Route state provider
final routeProvider = StateNotifierProvider<RouteNotifier, AsyncValue<RouteResponse?>>((ref) {
  final repository = ref.watch(routeRepositoryProvider);
  return RouteNotifier(repository);
});

// Attractions provider
final attractionsProvider = FutureProvider<List<Attraction>>((ref) async {
  final repository = ref.watch(routeRepositoryProvider);
  return repository.getAllAttractions();
});

class RouteNotifier extends StateNotifier<AsyncValue<RouteResponse?>> {
  final RouteRepository _repository;

  RouteNotifier(this._repository) : super(const AsyncValue.data(null));

  Future<void> createRoute(RouteRequest request) async {
    state = const AsyncValue.loading();

    try {
      final route = await _repository.createRoute(request);
      state = AsyncValue.data(route);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  void reset() {
    state = const AsyncValue.data(null);
  }
}