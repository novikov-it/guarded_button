import 'package:guarded_button/src/guard.dart';
import 'package:test/test.dart';

void main() {
  group('Guard', () {
    test('Default Guard minProcessing time should be 300ms', () {
      expect(Guard().minProcessingTime.inMilliseconds, 300);
    });

    test('Guard should not be processing when initialized', () {
      expect(Guard().isProcessing, false);
    });

    test('Guard should be processing when process is ran', () {
      final Guard guard = Guard(minProcessingTime: Duration(seconds: 1));
      guard.process(() {});
      expect(guard.isProcessing, true);
    });

    late Guard guard;

    setUp(() {
      guard = Guard();
    });

    test('Guard should process request for the minProcessing time minimum',
        () async {
      guard.process(() {});

      expect(guard.isProcessing, true);

      await Future.delayed(const Duration(milliseconds: 300));

      expect(guard.isProcessing, false);
    });

    test('Guard should process request with maximum time', () async {
      guard.process(() async {
        await Future.delayed(const Duration(seconds: 1));
      });

      expect(guard.isProcessing, true);

      await Future.delayed(const Duration(milliseconds: 500));

      expect(guard.isProcessing, true);

      await Future.delayed(const Duration(milliseconds: 500));

      expect(guard.isProcessing, false);
    });

    test('Guard should not process request if it is already processing',
        () async {
      guard.process(() async {
        await Future.delayed(const Duration(seconds: 1));
      });

      expect(guard.isProcessing, true);

      guard.process(() async {
        await Future.delayed(const Duration(seconds: 5));
      });

      expect(guard.isProcessing, true);

      await Future.delayed(const Duration(milliseconds: 500));

      expect(guard.isProcessing, true);

      await Future.delayed(const Duration(milliseconds: 500));

      expect(guard.isProcessing, false);
    });

    test('Guard should notify external listeners on processing events',
        () async {
      int counter = 0;
      guard.addListener(() {
        counter++;
      });

      guard.process(() {});

      expect(counter, 1);

      await Future.delayed(const Duration(milliseconds: 150));

      expect(counter, 1);

      await Future.delayed(const Duration(milliseconds: 150));

      expect(counter, 2);
    });
  });
}
