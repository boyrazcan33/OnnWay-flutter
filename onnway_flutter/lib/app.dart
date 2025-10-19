// lib/app.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'data/models/route_request.dart';
import 'providers/route_provider.dart';
import 'providers/location_provider.dart';
import 'providers/form_provider.dart';
import 'ui/screens/city_selection_screen.dart';
import 'ui/screens/route_display_screen.dart';
import 'ui/theme/colors.dart';

class OnnWayApp extends ConsumerWidget {
  const OnnWayApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationState = ref.watch(locationProvider);
    final routeState = ref.watch(routeProvider);
    final attractionsState = ref.watch(attractionsProvider);

    final selectedCity = ref.watch(selectedCityProvider);
    final selectedActivity = ref.watch(selectedActivityProvider);
    final selectedBudget = ref.watch(selectedBudgetProvider);
    final selectedDuration = ref.watch(selectedDurationProvider);

    return Column(
      children: [
        // Header
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [gradientStart, gradientEnd],
            ),
          ),
          padding: const EdgeInsets.all(24),
          child: const Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '🇪🇪 Tere!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: whiteColor,
                    ),
                  ),
                  Text(
                    '🗺️ OnnWay',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: whiteColor,
                    ),
                  ),
                  Text(
                    'Merhaba! 🇹🇷',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: whiteColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'Create optimized tourism routes for Istanbul and Tallinn',
                style: TextStyle(
                  fontSize: 16,
                  color: whiteColor,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),

        // Content
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [gradientStart, gradientEnd],
              ),
            ),
            child: locationState.when(
              data: (userLocation) {
                if (userLocation == null) {
                  return const Center(
                    child: Text(
                      'Location not available',
                      style: TextStyle(color: whiteColor),
                    ),
                  );
                }

                // Show route if created
                return routeState.when(
                  data: (route) {
                    if (route != null) {
                      return attractionsState.when(
                        data: (attractions) => RouteDisplayScreen(
                          route: route,
                          attractions: attractions,
                          userLocation: userLocation,
                          onCreateNew: () {
                            ref.read(routeProvider.notifier).reset();
                            ref.read(selectedCityProvider.notifier).state = null;
                            ref.read(selectedActivityProvider.notifier).state = null;
                            ref.read(selectedBudgetProvider.notifier).state = null;
                            ref.read(selectedDurationProvider.notifier).state = null;
                          },
                        ),
                        loading: () => const Center(
                          child: CircularProgressIndicator(
                            color: whiteColor,
                          ),
                        ),
                        error: (error, stack) => Center(
                          child: Text(
                            'Error loading attractions: $error',
                            style: const TextStyle(color: whiteColor),
                          ),
                        ),
                      );
                    }

                    // Show city selection
                    return CitySelectionScreen(
                      onApply: () {
                        if (selectedCity != null &&
                            selectedActivity != null &&
                            selectedBudget != null &&
                            selectedDuration != null) {
                          final request = RouteRequest(
                            startLat: userLocation.latitude,
                            startLon: userLocation.longitude,
                            city: selectedCity,
                            activity: selectedActivity,
                            budget: selectedBudget,
                            duration: selectedDuration,
                          );

                          ref.read(routeProvider.notifier).createRoute(request);
                        }
                      },
                      isLoading: false,
                    );
                  },
                  loading: () => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/mj_moonwalk.png',
                          width: 200,
                          height: 200,
                          errorBuilder: (context, error, stackTrace) {
                            return const CircularProgressIndicator(
                              color: whiteColor,
                            );
                          },
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Creating your route...',
                          style: TextStyle(
                            color: whiteColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Teaching the map to dance too...',
                          style: TextStyle(
                            color: whiteColor,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  error: (error, stack) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          size: 64,
                          color: whiteColor,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Error: $error',
                          style: const TextStyle(color: whiteColor),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            ref.read(routeProvider.notifier).reset();
                          },
                          child: const Text('Try Again'),
                        ),
                      ],
                    ),
                  ),
                );
              },
              loading: () => const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(color: whiteColor),
                    SizedBox(height: 16),
                    Text(
                      'Getting your location...',
                      style: TextStyle(
                        color: whiteColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              error: (error, stack) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.location_off,
                      size: 64,
                      color: whiteColor,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Location Required',
                      style: TextStyle(
                        color: whiteColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      error.toString(),
                      style: const TextStyle(color: whiteColor),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // Footer
        Container(
          width: double.infinity,
          color: darkGrayColor,
          padding: const EdgeInsets.all(16),
          child: const Text(
            'Built with Flutter and Dart',
            style: TextStyle(
              fontSize: 14,
              color: whiteColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}