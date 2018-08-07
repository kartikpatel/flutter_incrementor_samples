// Imports the Flutter Driver API
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('incrementor performance test', () {
    FlutterDriver driver;

    setUpAll(() async {
      // Connects to the app
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        // Closes the connection
        driver.close();
      }
    });

    test('measure', () async {
      // Record the performance timeline of things that happen inside the closure
      Timeline timeline = await driver.traceAction(() async {
        //SerializableFinder userList = find.byValueKey('Increment');
        //SerializableFinder button = find.text('+');
        SerializableFinder button = find.byTooltip('Increment');

        await driver.waitFor(button);
        await driver.tap(button);

        SerializableFinder text = find.text('1');
        String counterText = await driver.getText(text);

        expect(counterText, '1');
      });

      // The `timeline` object contains all the performance data recorded during
      // the scrolling session. It can be digested into a handful of useful
      // aggregate numbers, such as "average frame build time".
      TimelineSummary summary = new TimelineSummary.summarize(timeline);

      // The following line saves the timeline summary to a JSON file.
      summary.writeSummaryToFile('incrementor_performance', pretty: true);

      // The following line saves the raw timeline data as JSON.
      summary.writeTimelineToFile('incrementor_performance', pretty: true);
    });
  });
}
