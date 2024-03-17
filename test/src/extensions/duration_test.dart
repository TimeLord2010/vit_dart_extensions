import 'package:test/test.dart';
import 'package:vit_dart_extensions/src/extensions/duration.dart';

void main() {
  group('duration', () {
    group('toReadable', () {
      test('Day', () {
        expect(Duration(days: 1).toReadable(), '1d');
      });
      test('Day and hour', () {
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
      });
      test('Hour', () {
        expect(Duration(hours: 3).toReadable(), '3h');
      });
      test('Hour and minute', () {
        expect(
          Duration(
            hours: 3,
            minutes: 23,
            seconds: 5,
            milliseconds: 101,
          ).toReadable(),
          '3h 23min',
        );
      });
      test('Minute', () {
        expect(Duration(minutes: 23).toReadable(), '23min');
      });
      test('Minute and second', () {
        expect(
          Duration(
            minutes: 23,
            seconds: 5,
            milliseconds: 101,
          ).toReadable(),
          '23min 5s',
        );
      });
      test('Second', () {
        expect(Duration(seconds: 5).toReadable(), '5s');
      });
      group('Second and millisecond', () {
        test('Millisecond as decimal', () {
          expect(
            Duration(
              seconds: 5,
              milliseconds: 101,
            ).toReadable(
              millisecondsAsDecimal: true,
            ),
            '5.101s',
          );
        });
        test('Millisecond as separate unit', () {
          expect(
            Duration(
              seconds: 5,
              milliseconds: 101,
            ).toReadable(),
            '5s 101ms',
          );
        });
      });
      group('Millisecond', () {
        test('Millisecond as decimal', () {
          expect(
            Duration(milliseconds: 101).toReadable(
              millisecondsAsDecimal: true,
            ),
            '0.101s',
          );
        });
        test('Millisecond as separate unit', () {
          expect(Duration(milliseconds: 101).toReadable(), '101ms');
        });
      });
      test('Zero duration', () {
        expect(Duration.zero.toReadable(), '0s');
      });
    });
  });
}
