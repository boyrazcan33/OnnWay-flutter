// lib/ui/screens/route_display_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import '../../data/models/route_response.dart';
import '../../data/models/attraction.dart';
import '../../providers/route_provider.dart';
import '../components/route_map.dart';
import '../components/attraction_details.dart';
import '../theme/colors.dart';

class RouteDisplayScreen extends ConsumerStatefulWidget {
  final RouteResponse route;
  final List<Attraction> attractions;
  final LatLng userLocation;
  final VoidCallback onCreateNew;

  const RouteDisplayScreen({
    super.key,
    required this.route,
    required this.attractions,
    required this.userLocation,
    required this.onCreateNew,
  });

  @override
  ConsumerState<RouteDisplayScreen> createState() => _RouteDisplayScreenState();
}

class _RouteDisplayScreenState extends ConsumerState<RouteDisplayScreen> {
  Attraction? _selectedAttraction;

  void _showAttractionDetails(RouteStop stop) {
    setState(() {
      _selectedAttraction = widget.attractions.firstWhere(
            (a) => a.name == stop.name,
        orElse: () => widget.attractions.first,
      );
    });

    showDialog(
      context: context,
      builder: (context) => AttractionDetails(
        stop: stop,
        attraction: _selectedAttraction,
        onDismiss: () {
          Navigator.of(context).pop();
          setState(() {
            _selectedAttraction = null;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Route Summary
        Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Text(
                  '🗺️ Your Optimized Route',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _SummaryItem(
                      label: 'Total Distance',
                      value: widget.route.totalDistance,
                    ),
                    _SummaryItem(
                      label: 'Total Duration',
                      value: widget.route.totalDuration,
                    ),
                    _SummaryItem(
                      label: 'Total Cost',
                      value: '€${widget.route.totalCost}',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 16),

        // Route Map
        RouteMap(
          route: widget.route.optimizedRoute,
          attractions: widget.attractions,
          userLocation: widget.userLocation,
          onAttractionClick: _showAttractionDetails,
        ),

        const SizedBox(height: 16),

        // Route Steps Header
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            'Route Steps',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),

        // Route Steps
        ...widget.route.optimizedRoute.map((stop) => Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _RouteStepCard(
            stop: stop,
            onTap: () => _showAttractionDetails(stop),
          ),
        )),

        // Create New Route Button
        SizedBox(
          height: 56,
          child: ElevatedButton(
            onPressed: widget.onCreateNew,
            style: ElevatedButton.styleFrom(
              backgroundColor: secondaryColor,
            ),
            child: const Text(
              'Create New Route',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        const SizedBox(height: 80),
      ],
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String label;
  final String value;

  const _SummaryItem({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: grayColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
      ],
    );
  }
}

class _RouteStepCard extends StatelessWidget {
  final RouteStop stop;
  final VoidCallback onTap;

  const _RouteStepCard({
    required this.stop,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Step Number
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text(
                  '${stop.order}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),

              const SizedBox(width: 16),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            stop.name,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            _TagChip(
                              text: '🚶 ${stop.walkingTime}',
                              color: primaryColor,
                            ),
                            const SizedBox(height: 4),
                            _TagChip(
                              text: '💰 €${stop.cost}',
                              color: successColor,
                            ),
                            const SizedBox(height: 4),
                            _TagChip(
                              text: '⏱️ ${stop.estimatedDuration} min',
                              color: warningColor,
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    Text(
                      '📍 ${stop.address}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontStyle: FontStyle.italic,
                        color: grayColor,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      stop.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 12),

                    TextButton(
                      onPressed: onTap,
                      child: const Text('View Details →'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  final String text;
  final Color color;

  const _TagChip({
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}