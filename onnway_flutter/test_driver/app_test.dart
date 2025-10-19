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
    const int zoomDurationSec = 30;

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
      await _log(logFile, 'Zoom Duration: ${zoomDurationSec}s per cycle');
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

      // CYCLE 1: İlk cycle için setup yap
      await _selectRouteParameters(driver, logFile, 1);

      for (int cycle = 1; cycle <= totalCycles; cycle++) {
        await _log(logFile, '');
        await _log(logFile, '========== CYCLE $cycle/$totalCycles ==========');
        final cycleStartTime = DateTime.now();

        try {
          // Step 1: Create route
          await _createRoute(driver, logFile, cycle);

          // Step 2: Wait for animation to complete
          await _waitForAnimation(driver, logFile, cycle);

          // Step 3: Scroll test (30 seconds) - Route Steps bölgesinde
          await _scrollTest(driver, logFile, cycle, scrollDurationSec);

          // Step 4: Map zoom test (30 seconds) - Harita butonlarıyla
          await _mapZoomTest(driver, logFile, cycle, zoomDurationSec);

          // Step 5: Prepare next cycle (sadece son cycle değilse)
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
    await _log(logFile, '[$cycle]   ✓ Tallinn selected');

    // Select Social Media Spots
    await driver.scrollUntilVisible(
      find.byType('SingleChildScrollView'),
      find.text('Social Media Spots'),
      dyScroll: -300.0,
      timeout: const Duration(seconds: 10),
    );
    await driver.tap(find.text('Social Media Spots'));
    await Future.delayed(const Duration(milliseconds: 500));
    await _log(logFile, '[$cycle]   ✓ Social Media Spots selected');

    // Select Mid Range
    await driver.scrollUntilVisible(
      find.byType('SingleChildScrollView'),
      find.text('Mid Range'),
      dyScroll: -300.0,
      timeout: const Duration(seconds: 10),
    );
    await driver.tap(find.text('Mid Range'));
    await Future.delayed(const Duration(milliseconds: 500));
    await _log(logFile, '[$cycle]   ✓ Mid Range selected');

    // Select Medium (1 day)
    await driver.scrollUntilVisible(
      find.byType('SingleChildScrollView'),
      find.text('Medium (1 day)'),
      dyScroll: -300.0,
      timeout: const Duration(seconds: 10),
    );
    await driver.tap(find.text('Medium (1 day)'));
    await Future.delayed(const Duration(milliseconds: 500));
    await _log(logFile, '[$cycle]   ✓ Medium (1 day) selected');

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
  await _log(logFile, '[$cycle] Waiting for animation to complete...');

  final animationStartTime = DateTime.now();
  const maxWaitTime = Duration(seconds: 120);

  // 1. Loading text'in kaybolmasını bekle
  bool loadingFinished = false;

  while (DateTime.now().difference(animationStartTime) < maxWaitTime && !loadingFinished) {
    try {
      await driver.waitFor(
        find.text('Teaching the map to dance too...'),
        timeout: const Duration(seconds: 1),
      );
      // Hala loading var, bekle
      await Future.delayed(const Duration(seconds: 2));
    } catch (e) {
      // Loading text bulunamadı = kayboldu
      loadingFinished = true;
      await _log(logFile, '[$cycle]   Loading animation finished');
    }
  }

  if (!loadingFinished) {
    await _log(logFile, '[$cycle] ✗ Animation timeout after ${maxWaitTime.inSeconds}s');
    throw Exception('Animation timeout');
  }

  // 2. Route Map'in göründüğünü CONFIRM et
  try {
    await driver.waitFor(
      find.text('📍 Route Map'),
      timeout: const Duration(seconds: 10),
    );
    await _log(logFile, '[$cycle]   ✓ Route Map visible');
  } catch (e) {
    await _log(logFile, '[$cycle]   Warning: Route Map not found: $e');
  }

  // 3. Summary Card'ın göründüğünü CONFIRM et
  try {
    await driver.waitFor(
      find.text('Total Distance'),
      timeout: const Duration(seconds: 10),
    );
    await _log(logFile, '[$cycle]   ✓ Summary Card visible');
  } catch (e) {
    await _log(logFile, '[$cycle]   Warning: Summary Card not found: $e');
  }

  final animationDuration = DateTime.now().difference(animationStartTime);
  await _log(logFile, '[$cycle] ✓ Animation completed in ${animationDuration.inSeconds}s');

  // 4. Extra stability wait
  await Future.delayed(const Duration(seconds: 5));
  await _log(logFile, '[$cycle]   ✓ Stability wait completed');
}

Future<void> _scrollTest(FlutterDriver driver, File logFile, int cycle, int durationSec) async {
  await _log(logFile, '[$cycle] Starting scroll test (${durationSec}s)...');

  // ✅ STRATEJİ: Summary Card'dan (haritanın ÜZERİNDEN) BÜYÜK scroll
  // Haritayı hızla geç, Route Steps bölgesine in

  try {
    await _log(logFile, '[$cycle]   Jumping over map from Summary Card...');

    // 1 KEZ BÜYÜK SCROLL - Haritayı atla
    await driver.scroll(
      find.text('Total Distance'),  // ← Summary Card (haritanın ÜZERİNDE)
      0,
      -800,  // ← BÜYÜK scroll (haritayı geç)
      const Duration(milliseconds: 300),
    );

    await Future.delayed(const Duration(milliseconds: 500));
    await _log(logFile, '[$cycle]   ✓ Jumped over map, now in Route Steps zone');

  } catch (e) {
    await _log(logFile, '[$cycle]   Warning: Could not jump over map: $e');
  }

  final scrollStartTime = DateTime.now();
  final scrollEndTime = scrollStartTime.add(Duration(seconds: durationSec));
  int scrollCount = 0;

  // Start performance timeline tracking
  final timeline = await driver.traceAction(() async {
    while (DateTime.now().isBefore(scrollEndTime)) {
      try {
        // KÜÇÜK SCROLL'LAR - Route Steps bölgesinde kal (haritadan uzak)
        // AŞAĞI
        await driver.scroll(
          find.byType('ListView'),
          0,
          -200,
          const Duration(milliseconds: 100),
        );
        await Future.delayed(const Duration(milliseconds: 150));
        scrollCount++;

        // YUKARI
        await driver.scroll(
          find.byType('ListView'),
          0,
          200,
          const Duration(milliseconds: 100),
        );
        await Future.delayed(const Duration(milliseconds: 150));
        scrollCount++;

        // Progress update every 20 scrolls
        if (scrollCount % 20 == 0) {
          final elapsed = DateTime.now().difference(scrollStartTime).inSeconds;
          await _log(logFile, '[$cycle]   Scroll progress: ${elapsed}s / ${durationSec}s (${scrollCount} scrolls)');
        }
      } catch (e) {
        await _log(logFile, '[$cycle]   Warning: Scroll failed: $e');
        await Future.delayed(const Duration(milliseconds: 200));
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

Future<void> _mapZoomTest(FlutterDriver driver, File logFile, int cycle, int durationSec) async {
  await _log(logFile, '[$cycle] Starting map zoom test (${durationSec}s)...');

  try {
    await _log(logFile, '[$cycle]   Scrolling back up to map...');

    // ✅ Generic ListView ile YUKARI scroll
    // Route Steps bölgesinden haritaya dön
    for (int i = 0; i < 2; i++) {
      await driver.scroll(
        find.byType('ListView'),
        0,
        800,  // YUKARI
        const Duration(milliseconds: 300),
      );
      await Future.delayed(const Duration(milliseconds: 300));
    }

    await _log(logFile, '[$cycle]   ✓ Back at map');

  } catch (e) {
    await _log(logFile, '[$cycle]   Warning: Could not scroll to map: $e');
  }

  final zoomStartTime = DateTime.now();
  final zoomEndTime = zoomStartTime.add(Duration(seconds: durationSec));
  int zoomCount = 0;

  // Start performance timeline tracking
  final timeline = await driver.traceAction(() async {
    while (DateTime.now().isBefore(zoomEndTime)) {
      try {
        // ZOOM IN - Native gibi buton ile
        await driver.tap(find.byValueKey('zoom_in_button'));
        await Future.delayed(const Duration(milliseconds: 300));
        zoomCount++;

        // ZOOM OUT - Native gibi buton ile
        await driver.tap(find.byValueKey('zoom_out_button'));
        await Future.delayed(const Duration(milliseconds: 300));
        zoomCount++;

        // Progress update every 10 zooms
        if (zoomCount % 10 == 0) {
          final elapsed = DateTime.now().difference(zoomStartTime).inSeconds;
          await _log(logFile, '[$cycle]   Zoom progress: ${elapsed}s / ${durationSec}s (${zoomCount} zooms)');
        }
      } catch (e) {
        await _log(logFile, '[$cycle]   Warning: Zoom button not found: $e');
        await Future.delayed(const Duration(milliseconds: 500));
      }
    }
  });

  // Write timeline to file
  await _saveTimeline(timeline, 'test_results/flutter_zoom_timeline_cycle_$cycle.json', logFile, cycle);

  // Calculate metrics
  final frameStats = _calculateFrameStats(timeline);

  await _log(logFile, '[$cycle] ✓ Map zoom test completed');
  await _log(logFile, '[$cycle]   • Total zoom operations: $zoomCount');
  await _log(logFile, '[$cycle]   • Duration: ${durationSec}s');
  await _log(logFile, '[$cycle]   • Average FPS: ${frameStats['averageFps'].toStringAsFixed(2)}');
  await _log(logFile, '[$cycle]   • Frame count: ${frameStats['totalFrames']}');
  await _log(logFile, '[$cycle]   • Dropped frames: ${frameStats['droppedFrames']}');
  await _log(logFile, '[$cycle]   • Jank percentage: ${frameStats['jankPercentage'].toStringAsFixed(2)}%');
}

Future<void> _prepareNextCycle(FlutterDriver driver, File logFile, int cycle) async {
  await _log(logFile, '[$cycle] Preparing for next cycle...');

  try {
    // ✅ 2 AŞAMALI STRATEJİ
    // AŞAMA 1: BÜYÜK JUMP - Haritayı atla (6x800)
    // AŞAMA 2: LOOP ile Create New Route bul (manuel scroll)

    // AŞAMA 1: 6 JUMP - Haritayı atla
    await _log(logFile, '[$cycle]   STAGE 1: Jumping over map (6x800 from Total Distance)...');

    for (int i = 0; i < 6; i++) {
      await driver.scroll(
        find.text('Total Distance'),  // ← Summary Card (haritanın ÜZERİNDE)
        0,
        -800,  // ← BÜYÜK scroll
        const Duration(milliseconds: 300),
      );
      await Future.delayed(const Duration(milliseconds: 200));
    }

    await _log(logFile, '[$cycle]   ✓ Escaped map zone (4800 pixels)');

    // AŞAMA 2: LOOP ile Create New Route BUL
    await _log(logFile, '[$cycle]   STAGE 2: Searching for Create New Route button...');

    bool found = false;
    int scrollAttempts = 0;
    const maxScrollAttempts = 10;

    while (!found && scrollAttempts < maxScrollAttempts) {
      try {
        // Create New Route var mı kontrol et
        await driver.waitFor(
          find.text('Create New Route'),
          timeout: const Duration(milliseconds: 500),
        );
        found = true;
        await _log(logFile, '[$cycle]   ✓ Create New Route found after $scrollAttempts additional scrolls');
      } catch (e) {
        // Yok, scroll et
        await driver.scroll(
          find.byType('ListView'),
          0,
          -500,
          const Duration(milliseconds: 200),
        );
        scrollAttempts++;
        await Future.delayed(const Duration(milliseconds: 100));
      }
    }

    if (!found) {
      throw Exception('Create New Route not found after $maxScrollAttempts scroll attempts');
    }

    // AŞAMA 3: Tıkla
    await driver.tap(find.text('Create New Route'));
    await Future.delayed(const Duration(seconds: 4));
    await _log(logFile, '[$cycle]   ✓ Create New Route tapped');

    // Re-select parameters (Native gibi)
    await _log(logFile, '[$cycle] Re-selecting parameters...');

    // Tallinn
    final tallinnFinder = find.text('🇪🇪 Tallinn');
    await driver.waitFor(tallinnFinder, timeout: const Duration(seconds: 10));
    await driver.tap(tallinnFinder);
    await Future.delayed(const Duration(seconds: 2));

    // Social Media Spots
    await driver.scrollUntilVisible(
      find.byType('SingleChildScrollView'),
      find.text('Social Media Spots'),
      dyScroll: -300.0,
    );
    await driver.tap(find.text('Social Media Spots'));
    await Future.delayed(const Duration(seconds: 2));

    // Mid Range
    await driver.scrollUntilVisible(
      find.byType('SingleChildScrollView'),
      find.text('Mid Range'),
      dyScroll: -300.0,
    );
    await driver.tap(find.text('Mid Range'));
    await Future.delayed(const Duration(seconds: 2));

    // Medium
    await driver.scrollUntilVisible(
      find.byType('SingleChildScrollView'),
      find.text('Medium (1 day)'),
      dyScroll: -300.0,
    );
    await driver.tap(find.text('Medium (1 day)'));
    await Future.delayed(const Duration(seconds: 2));

    await _log(logFile, '[$cycle] ✓ Parameters re-selected, ready for next cycle');
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
        'duration': event.duration?.inMicroseconds,
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