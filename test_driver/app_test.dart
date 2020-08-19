import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  FlutterDriver driver;

  // Connect to the Flutter driver before running any tests.
  setUpAll(() async {
    driver = await setupAndGetDriver();
  });

  // Close the connection to the driver after the tests have completed.
  tearDownAll(() async {
    if (driver != null) {
      driver.close();
    }
  });

  test('parsing json', () async {
    final listFinder = find.byValueKey('long_list');
    final itemFinder = find.byValueKey('item_50_text');

    final timeline = await driver.traceAction(() async {
      await driver.scrollUntilVisible(
        listFinder,
        itemFinder,
        dyScroll: -300.0,
      );

      expect(await driver.getText(itemFinder), 'Item 50');
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
