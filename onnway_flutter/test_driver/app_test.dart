// test_driver/app_test.dart
import 'dart:io';
import 'dart:convert';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('OnnWay Flutter Animation Fluidity Stress Test', () {
    late FlutterDriver driver;
    late File logFile;

    // Test Configuration - Native ile AYNI
    const int totalCycles = 5;
    const int scrollDurationSec = 30;
    const int mapInteractionDurationSec = 30;

    setUpAll(() async {
      driver = await FlutterDriver.connect();

      // Log dosyası oluştur
      final timestamp = DateTime.now().toIso8601String().replaceAll(':', '-').split('.')[0];
      logFile = File('test_results/flutter_stress_test_$timestamp.log');
      await logFile.create(recursive: true);

      await _log(logFile, '========================================');
      await _log(logFile, 'FLUTTER ANIMATION FLUIDITY TEST STARTED');
      await _log(logFile, 'Total Cycles: $totalCycles');
      await _log(logFile, 'Scroll Duration: ${scrollDurationSec}s per cycle');
      await _log(logFile, 'Map Interaction Duration: ${mapInteractionDurationSec}s per cycle');
      await _log(logFile, 'Device: ${Platform.operatingSystem}');
      await _log(logFile, '========================================');
    });

    tearDownAll(() async {
      await _log(logFile, '');
      await _log(logFile, '========================================');
      await _log(logFile, 'TEST COMPLETED');
      await _log(logFile, '========================================');
      await driver.close();
    });

    test('Animation Fluidity Under Stress', () async {
      final testStartTime = DateTime.now();

      for (int cycle = 1; cycle <= totalCycles; cycle++) {
        await _log(logFile, '');
        await _log(logFile, '========== CYCLE $cycle/$totalCycles ==========');
        final cycleStartTime = DateTime.now();

        try {
          // Step 1: Select route parameters
          await _selectRouteParameters(driver, logFile, cycle);

          // Step 2: Create route
          await _createRoute(driver, logFile, cycle);

          // Step 3: Wait for animation to complete
          await _waitForAnimation(driver, logFile, cycle);

          // Step 4: Scroll test (30 seconds)
          await _scrollTest(driver, logFile, cycle, scrollDurationSec);

          // Step 5: Map interaction test (30 seconds)
          await _mapInteractionTest(driver, logFile, cycle, mapInteractionDurationSec);

          // Step 6: Prepare next cycle
          if (cycle < totalCycles) {
            await _prepareNextCycle(driver, logFile, cycle);
          }

          final cycleDuration = DateTime.now().difference(cycleStartTime);
          await _log(logFile, '[$cycle] ✓ Cycle completed in ${cycleDuration.inSeconds}s');
        } catch (e, stackTrace) {
          await _log(logFile, '[$cycle] ✗ Cycle failed: $e');
          await _log(logFile, '[$cycle] Stack trace: $stackTrace');
        }
      }

      final totalDuration = DateTime.now().difference(testStartTime);
      await _log(logFile, '');
      await _log(logFile, '========================================');
      await _log(logFile, 'TOTAL TEST TIME: ${totalDuration.inMinutes} minutes ${totalDuration.inSeconds % 60} seconds');
      await _log(logFile, '========================================');
    },
      timeout: const Timeout(Duration(minutes: 15)),
    );
  });
}

// ============================================================================
// HELPER FUNCTIONS
// ============================================================================

Future<void> _log(File logFile, String message) async {
  print(message);
  await logFile.writeAsString('$message\n', mode: FileMode.append);
}

Future<void> _selectRouteParameters(FlutterDriver driver, File logFile, int cycle) async {
  await _log(logFile, '[$cycle] Selecting route parameters...');

  try {
    // Select Tallinn
    final tallinnFinder = find.text('🇪🇪 Tallinn');
    await driver.waitFor(tallinnFinder, timeout: const Duration(seconds: 10));
    await driver.tap(tallinnFinder);
    await Future.delayed(const Duration(seconds: 2));
    await _log(logFile, '[$cycle]   • Tallinn selected');

    // Select Social Media Spots
    await driver.scrollUntilVisible(
      find.byType('SingleChildScrollView'),
      find.text('Social Media Spots'),
      dyScroll: -300.0,
      timeout: const Duration(seconds: 10),
    );
    await driver.tap(find.text('Social Media Spots'));
    await Future.delayed(const Duration(seconds: 1));
    await _log(logFile, '[$cycle]   • Social Media Spots selected');

    // Select Mid Range
    await driver.scrollUntilVisible(
      find.byType('SingleChildScrollView'),
      find.text('Mid Range'),
      dyScroll: -300.0,
      timeout: const Duration(seconds: 10),
    );
    await driver.tap(find.text('Mid Range'));
    await Future.delayed(const Duration(seconds: 1));
    await _log(logFile, '[$cycle]   • Mid Range selected');

    // Select Medium
    await driver.scrollUntilVisible(
      find.byType('SingleChildScrollView'),
      find.text('Medium (1 day)'),
      dyScroll: -300.0,
      timeout: const Duration(seconds: 10),
    );
    await driver.tap(find.text('Medium (1 day)'));
    await Future.delayed(const Duration(seconds: 1));
    await _log(logFile, '[$cycle]   • Medium (1 day) selected');

    await _log(logFile, '[$cycle] ✓ Parameters selected');
  } catch (e) {
    await _log(logFile, '[$cycle] ✗ Parameter selection failed: $e');
    rethrow;
  }
}

Future<void> _createRoute(FlutterDriver driver, File logFile, int cycle) async {
  await _log(logFile, '[$cycle] Creating route...');

  try {
    // Scroll to CREATE MY ROUTE button
    await driver.scrollUntilVisible(
      find.byType('SingleChildScrollView'),
      find.text('CREATE MY ROUTE'),
      dyScroll: -300.0,
      timeout: const Duration(seconds: 10),
    );

    await driver.tap(find.text('CREATE MY ROUTE'));
    await Future.delayed(const Duration(seconds: 2));

    await _log(logFile, '[$cycle] ✓ Route creation started');
  } catch (e) {
    await _log(logFile, '[$cycle] ✗ Route creation failed: $e');
    rethrow;
  }
}

Future<void> _waitForAnimation(FlutterDriver driver, File logFile, int cycle) async {
  await _log(logFile, '[$cycle] Waiting for loading animation to complete...');

  final animationStartTime = DateTime.now();
  const maxWaitTime = Duration(seconds: 120);

  // Wait for loading to disappear
  while (DateTime.now().difference(animationStartTime) < maxWaitTime) {
    try {
      // Check if loading text exists
      await driver.waitFor(
        find.text('Teaching the map to dance too...'),
        timeout: const Duration(seconds: 1),
      );
      // Still loading, wait a bit
      await Future.delayed(const Duration(milliseconds: 500));
    } catch (e) {
      // Loading finished
      final animationDuration = DateTime.now().difference(animationStartTime);
      await _log(logFile, '[$cycle] ✓ Animation completed in ${animationDuration.inSeconds}s');
      await Future.delayed(const Duration(seconds: 3)); // Stability wait
      return;
    }
  }

  await _log(logFile, '[$cycle] ✗ Animation timeout after ${maxWaitTime.inSeconds}s');
}

Future<void> _scrollTest(FlutterDriver driver, File logFile, int cycle, int durationSec) async {
  await _log(logFile, '[$cycle] Starting scroll test (${durationSec}s)...');

  final scrollStartTime = DateTime.now();
  final scrollEndTime = scrollStartTime.add(Duration(seconds: durationSec));
  int scrollCount = 0;

  // İlk pozisyon: Route Steps'e scroll et (haritanın altına git)
  try {
    await driver.scrollUntilVisible(
      find.byType('ListView'),
      find.text('Route Steps'),
      dyScroll: -300.0,
      timeout: const Duration(seconds: 5),
    );
    await _log(logFile, '[$cycle]   Positioned at Route Steps (below map)');
  } catch (e) {
    await _log(logFile, '[$cycle]   Warning: Could not find Route Steps: $e');
  }

  // Start performance timeline tracking
  final timeline = await driver.traceAction(() async {
    while (DateTime.now().isBefore(scrollEndTime)) {
      try {
        // ✅ SCROLL DOWN: Route Steps bölgesinden Create New Route'a
        await driver.scroll(
          find.text('Route Steps'),
          0,
          -200,
          const Duration(milliseconds: 100),
        );
        await Future.delayed(const Duration(milliseconds: 50));
        scrollCount++;

        // ✅ SCROLL UP: Create New Route'tan Route Steps'e geri
        await driver.scroll(
          find.text('Create New Route'),
          0,
          200,
          const Duration(milliseconds: 100),
        );
        await Future.delayed(const Duration(milliseconds: 50));
        scrollCount++;

        // Progress update every 10 seconds
        if (scrollCount % 100 == 0) {
          final elapsed = DateTime.now().difference(scrollStartTime).inSeconds;
          await _log(logFile, '[$cycle]   Scroll progress: ${elapsed}s / ${durationSec}s (${scrollCount} scrolls)');
        }
      } catch (e) {
        // Element bulunamazsa, fallback scroll
        try {
          await driver.scroll(
            find.byType('ListView'),
            0,
            -200,
            const Duration(milliseconds: 100),
          );
          scrollCount++;
          await driver.scroll(
            find.byType('ListView'),
            0,
            200,
            const Duration(milliseconds: 100),
          );
          scrollCount++;
        } catch (fallbackError) {
          await Future.delayed(const Duration(milliseconds: 200));
        }
      }
    }
  });

  // Write timeline to file
  await _saveTimeline(timeline, 'test_results/flutter_scroll_timeline_cycle_$cycle.json', logFile, cycle);

  // Calculate metrics
  final frameStats = _calculateFrameStats(timeline);

  await _log(logFile, '[$cycle] ✓ Scroll test completed');
  await _log(logFile, '[$cycle]   • Total scrolls: $scrollCount');
  await _log(logFile, '[$cycle]   • Duration: ${durationSec}s');
  await _log(logFile, '[$cycle]   • Average FPS: ${frameStats['averageFps'].toStringAsFixed(2)}');
  await _log(logFile, '[$cycle]   • Frame count: ${frameStats['totalFrames']}');
  await _log(logFile, '[$cycle]   • Dropped frames: ${frameStats['droppedFrames']}');
  await _log(logFile, '[$cycle]   • Jank percentage: ${frameStats['jankPercentage'].toStringAsFixed(2)}%');
}

Future<void> _mapInteractionTest(FlutterDriver driver, File logFile, int cycle, int durationSec) async {
  await _log(logFile, '[$cycle] Starting map interaction test (${durationSec}s)...');

  final mapStartTime = DateTime.now();
  final mapEndTime = mapStartTime.add(Duration(seconds: durationSec));
  int interactionCount = 0;

  // Önce en üste çık (haritanın üstüne - summary card'a)
  try {
    await driver.scrollUntilVisible(
      find.byType('ListView'),
      find.text('🗺️ Your Optimized Route'),
      dyScroll: 300.0,
      timeout: const Duration(seconds: 5),
    );
    await _log(logFile, '[$cycle]   Positioned at top (Summary Card)');
  } catch (e) {
    await _log(logFile, '[$cycle]   Warning: Could not scroll to top: $e');
  }

  // Start performance timeline tracking
  final timeline = await driver.traceAction(() async {
    while (DateTime.now().isBefore(mapEndTime)) {
      try {
        // ✅ MAP INTERACTION: Haritaya dokunmadan, butonlara tıkla
        // "Open in Maps" butonunu bul ve tıkla
        try {
          final openMapsButton = find.text('Open in Maps');
          await driver.waitFor(openMapsButton, timeout: const Duration(milliseconds: 500));
          await driver.tap(openMapsButton);
          await Future.delayed(const Duration(milliseconds: 300));

          // Browser açılır, geri dön
          await driver.tap(find.pageBack());
          await Future.delayed(const Duration(milliseconds: 300));

          interactionCount++;
        } catch (e) {
          // Button bulunamazsa, sadece summary card'a tıkla (map'e DOKUNMA)
          await driver.tap(find.text('Total Distance'));
          await Future.delayed(const Duration(milliseconds: 300));
          interactionCount++;
        }

        // Progress update every 10 seconds
        if (interactionCount % 30 == 0) {
          final elapsed = DateTime.now().difference(mapStartTime).inSeconds;
          await _log(logFile, '[$cycle]   Map progress: ${elapsed}s / ${durationSec}s (${interactionCount} interactions)');
        }

      } catch (e) {
        // Interaction fail, just wait
        await Future.delayed(const Duration(milliseconds: 500));
      }
    }
  });

  // Write timeline to file
  await _saveTimeline(timeline, 'test_results/flutter_map_timeline_cycle_$cycle.json', logFile, cycle);

  // Calculate metrics
  final frameStats = _calculateFrameStats(timeline);

  await _log(logFile, '[$cycle] ✓ Map interaction test completed');
  await _log(logFile, '[$cycle]   • Total interactions: $interactionCount');
  await _log(logFile, '[$cycle]   • Duration: ${durationSec}s');
  await _log(logFile, '[$cycle]   • Average FPS: ${frameStats['averageFps'].toStringAsFixed(2)}');
  await _log(logFile, '[$cycle]   • Frame count: ${frameStats['totalFrames']}');
  await _log(logFile, '[$cycle]   • Dropped frames: ${frameStats['droppedFrames']}');
  await _log(logFile, '[$cycle]   • Jank percentage: ${frameStats['jankPercentage'].toStringAsFixed(2)}%');
}

Future<void> _prepareNextCycle(FlutterDriver driver, File logFile, int cycle) async {
  await _log(logFile, '[$cycle] Preparing for next cycle...');

  try {
    // Scroll to Create New Route button (EN AŞAĞIDA)
    await driver.scrollUntilVisible(
      find.byType('ListView'),
      find.text('Create New Route'),
      dyScroll: -500.0,
      timeout: const Duration(seconds: 10),
    );

    await driver.tap(find.text('Create New Route'));
    await Future.delayed(const Duration(seconds: 4)); // Native gibi 4 saniye bekle

    await _log(logFile, '[$cycle] ✓ Ready for next cycle');
  } catch (e) {
    await _log(logFile, '[$cycle] ✗ Prepare next cycle failed: $e');
    rethrow;
  }
}

// ============================================================================
// TIMELINE SAVE
// ============================================================================

Future<void> _saveTimeline(Timeline timeline, String filepath, File logFile, int cycle) async {
  try {
    final timelineFile = File(filepath);

    // Convert timeline events to JSON manually
    final eventsJson = timeline.events?.map((event) {
      return {
        'name': event.name,
        'category': event.category,
        'phase': event.phase,
        'timestampMicros': event.timestampMicros,
        'duration': event.duration,
        'arguments': event.arguments,
      };
    }).toList() ?? [];

    final timelineData = {
      'traceEvents': eventsJson,
    };

    await timelineFile.writeAsString(jsonEncode(timelineData));
  } catch (e) {
    await _log(logFile, '[$cycle]   Warning: Could not write timeline file: $e');
  }
}

// ============================================================================
// PERFORMANCE CALCULATION
// ============================================================================

Map<String, dynamic> _calculateFrameStats(Timeline timeline) {
  final frames = timeline.events
      ?.where((e) => e.name == 'Frame')
      .toList() ?? [];

  if (frames.isEmpty) {
    return {
      'totalFrames': 0,
      'droppedFrames': 0,
      'jankPercentage': 0.0,
      'averageFps': 0.0,
    };
  }

  // Calculate FPS
  final totalDuration = frames.last.timestampMicros! - frames.first.timestampMicros!;
  final durationSeconds = totalDuration / 1000000.0;
  final averageFps = frames.length / durationSeconds;

  // Calculate dropped frames (> 16.67ms = 60 FPS threshold)
  int droppedFrames = 0;
  const targetFrameTime = 16667; // microseconds

  for (int i = 1; i < frames.length; i++) {
    final frameDuration = frames[i].timestampMicros! - frames[i - 1].timestampMicros!;
    if (frameDuration > targetFrameTime) {
      droppedFrames++;
    }
  }

  final jankPercentage = (droppedFrames / frames.length) * 100;

  return {
    'totalFrames': frames.length,
    'droppedFrames': droppedFrames,
    'jankPercentage': jankPercentage,
    'averageFps': averageFps,
  };
}