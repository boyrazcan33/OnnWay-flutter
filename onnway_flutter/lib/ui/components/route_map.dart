// lib/ui/components/route_map.dart
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/models/route_response.dart';
import '../../data/models/attraction.dart';

class RouteMap extends StatefulWidget {
  final List<RouteStop> route;
  final List<Attraction> attractions;
  final LatLng userLocation;
  final Function(RouteStop)? onAttractionClick;

  const RouteMap({
    super.key,
    required this.route,
    required this.attractions,
    required this.userLocation,
    this.onAttractionClick,
  });

  @override
  State<RouteMap> createState() => _RouteMapState();
}

class _RouteMapState extends State<RouteMap> {
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fitBounds();
    });
  }

  void _fitBounds() {
    final points = [
      widget.userLocation,
      ...widget.route.map((stop) {
        final attraction = widget.attractions.firstWhere(
              (a) => a.name == stop.name,
          orElse: () => widget.attractions.first,
        );
        return LatLng(attraction.latitude, attraction.longitude);
      }),
    ];

    if (points.isEmpty) return;

    final bounds = LatLngBounds.fromPoints(points);
    _mapController.fitCamera(
      CameraFit.bounds(
        bounds: bounds,
        padding: const EdgeInsets.all(50),
      ),
    );
  }

  Future<void> _openInMaps() async {
    final coordinates = [
      '${widget.userLocation.latitude},${widget.userLocation.longitude}',
      ...widget.route.map((stop) {
        final attraction = widget.attractions.firstWhere(
              (a) => a.name == stop.name,
          orElse: () => widget.attractions.first,
        );
        return '${attraction.latitude},${attraction.longitude}';
      }),
    ].join(';');

    final url = Uri.parse(
      'https://www.openstreetmap.org/directions?engine=fossgis_osrm_foot&route=$coordinates',
    );

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Build route points
    final routePoints = [
      widget.userLocation,
      ...widget.route.map((stop) {
        final attraction = widget.attractions.firstWhere(
              (a) => a.name == stop.name,
          orElse: () => widget.attractions.first,
        );
        return LatLng(attraction.latitude, attraction.longitude);
      }),
    ];

    return Column(
        children: [
    // Header
    Padding(
    padding: const EdgeInsets.all(16),
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Text(
    '📍 Route Map',
    style: Theme.of(context).textTheme.headlineMedium,
    ),
    ElevatedButton(
    onPressed: _openInMaps,
    child: const Text('Open in Maps'),
    ),
    ],
    ),
    ),

    // Map
    Card(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    elevation: 4,
    child: SizedBox(
    height: 400,
    child: ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: FlutterMap(
    mapController: _mapController,
    options: MapOptions(
    initialCenter: widget.userLocation,
    initialZoom: 13,
    ),
    children: [
    // OSM Tile Layer
    TileLayer(
    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
    userAgentPackageName: 'com.onnway.flutter',
    ),

    // Polyline (route)
    PolylineLayer(
    polylines: [
    Polyline(
    points: routePoints,
    color: Colors.blue,
    strokeWidth: 4,
    ),
    ],
    ),

    // Markers
    MarkerLayer(
    markers: [
    // User location
    Marker(
    point: widget.userLocation,
      width: 40,
      height: 40,
      child: const Icon(
        Icons.person_pin_circle,
        color: Colors.red,
        size: 40,
      ),
    ),

      // Route stops
      ...widget.route.map((stop) {
        final attraction = widget.attractions.firstWhere(
              (a) => a.name == stop.name,
          orElse: () => widget.attractions.first,
        );

        return Marker(
          point: LatLng(attraction.latitude, attraction.longitude),
          width: 40,
          height: 40,
          child: GestureDetector(
            onTap: () => widget.onAttractionClick?.call(stop),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                      width: 2,
                    ),
                  ),
                  child: Text(
                    '${stop.order}',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    ],
    ),
    ],
    ),
    ),
    ),
    ),
        ],
    );
  }
}