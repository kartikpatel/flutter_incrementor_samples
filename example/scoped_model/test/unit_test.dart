import 'package:test/test.dart';
import 'package:incrementor/main.dart';

void main() {
  test('my first unit test', () {
    var answer = 42;
    expect(answer, 42);
  });

  test('when increment then counter is updated', () {
    CounterModel testObject = CounterModel();

    testObject.increment();

    expect(testObject.counter, 1);
  });
}