import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import 'isolates_workaround.dart';

void main() {
  FlutterDriver driver;
  IsolatesWorkaround workaround;
  // Connect to the Flutter driver before running any tests.
  setUpAll(() async {
    driver = await setupAndGetDriver();
    workaround = IsolatesWorkaround(driver);
    await workaround.resumeIsolates();
  });

  // Close the connection to the driver after the tests have completed.
  tearDownAll(() async {
    if (driver != null) {
      await driver.close();
      await workaround.tearDown();
    }
  });

  test('parsing json', () async {
    final refreshFinder = find.byValueKey('refresh');
    final itemFinder = find.byValueKey('item_0');

    Health health = await driver.checkHealth();
    print(health.status);

    await driver.clearTimeline();
    final timeline = await driver.traceAction(() async {
      await driver.tap(refreshFinder);
      await driver.waitFor(itemFinder);
    });

    final summary = new TimelineSummary.summarize(timeline);
    await summary.writeSummaryToFile('parsing_summary', pretty: true);
    await summary.writeTimelineToFile('parsing_timeline', pretty: true);
  });
}

Future<FlutterDriver> setupAndGetDriver() async {
  var driver = await FlutterDriver.connect();
  var connected = false;
  while (!connected) {
    try {
      await driver.waitUntilFirstFrameRasterized();
      connected = true;
    } catch (error) {}
  }
  return driver;
}
