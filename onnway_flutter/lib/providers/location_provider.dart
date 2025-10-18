// lib/providers/location_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

final locationProvider = StateNotifierProvider<LocationNotifier, AsyncValue<LatLng?>>((ref) {
  return LocationNotifier();
});

class LocationNotifier extends StateNotifier<AsyncValue<LatLng?>> {
  LocationNotifier() : super(const AsyncValue.loading()) {
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      // Check permissions
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Use fake location for testing (Tallinn)
        state = AsyncValue.data(LatLng(59.4370, 24.7536));
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Use fake location
          state = AsyncValue.data(LatLng(59.4370, 24.7536));
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Use fake location
        state = AsyncValue.data(LatLng(59.4370, 24.7536));
        return;
      }

      // Get actual location
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      state = AsyncValue.data(LatLng(position.latitude, position.longitude));
    } catch (e) {
      // Fallback to fake location
      state = AsyncValue.data(LatLng(59.4370, 24.7536));
    }
  }

  void retry() {
    state = const AsyncValue.loading();
    _getCurrentLocation();
  }
}