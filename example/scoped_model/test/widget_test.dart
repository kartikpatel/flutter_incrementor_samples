// This is a basic Flutter widget test.
// To perform an interaction with a widget in your test, use the WidgetTester utility that Flutter
// provides. For example, you can send tap and scroll gestures. You can also use WidgetTester to
// find child widgets in the widget tree, read text, and verify that the values of widget properties
// are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:incrementor/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(new MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('Widgets update when the model notifies the listeners', (WidgetTester tester) async {
    final testObject = new CounterModel();
    final widget = new TestWidget(testObject);

    await tester.pumpWidget(widget);

    testObject.increment();

    // Rebuild the widget
    await tester.pumpWidget(widget);

    expect(testObject.listenerCount, 1);
    expect((tester.firstWidget(find.byKey(testKey)) as Text).data, '1');
  });
}

final testKey = new UniqueKey();

class TestWidget extends StatelessWidget {
  final CounterModel model;
  final bool rebuildOnChange;

  TestWidget(this.model, [this.rebuildOnChange = true]);

  factory TestWidget.noRebuild(CounterModel model) => new TestWidget(model, false);

  @override
  Widget build(BuildContext context) {
    return new ScopedModel<CounterModel>(
      model: model,
      // Extra nesting to ensure the model is sent down the tree.
      child: new Container(
        child: new Container(
          child: new ScopedModelDescendant<CounterModel>(
            rebuildOnChange: rebuildOnChange,
            builder: (context, child, model) => new Text(
              model.counter.toString(),
              key: testKey,
              textDirection: TextDirection.ltr,
            ),
          ),
        ),
      ),
    );
  }
}
