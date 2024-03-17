import 'package:test/test.dart';
import 'package:vit_dart_extensions/src/extensions/duration.dart';

void main() {
  group('duration', () {
    test('toReadable', () {
      expect(
        Duration(
          days: 1,
          hours: 3,
          minutes: 23,
          seconds: 5,
          milliseconds: 101,
        ).toReadable(),
        '1d 3h',
      );
      expect(
        Duration(
          hours: 3,
          minutes: 23,
          seconds: 5,
          milliseconds: 101,
        ).toReadable(),
        '3h 23min',
      );
      expect(
        Duration(
          minutes: 23,
          seconds: 5,
          milliseconds: 101,
        ).toReadable(),
        '23min 5s',
      );
      expect(
        Duration(
          seconds: 5,
        ).toReadable(),
        '5s',
      );
      expect(
        Duration(
          seconds: 5,
          milliseconds: 101,
        ).toReadable(),
        '5.101s',
      );
      expect(
        Duration(
          milliseconds: 101,
        ).toReadable(),
        '0.101s',
      );
      expect(Duration.zero.toReadable(), '0s');
    });
  });
}
