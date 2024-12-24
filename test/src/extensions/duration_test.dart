import 'package:test/test.dart';
import 'package:vit_dart_extensions/src/data/enums/time_unit.dart';
import 'package:vit_dart_extensions/src/extensions/duration.dart';

void main() {
  group('duration', () {
    group('toReadable', () {
      test('Day', () {
        expect(Duration(days: 1).toReadable(), '1d');
        expect(Duration(days: 1).toReadable(maxUnits: 2), '1d');
        expect(Duration(days: 1).toReadable(maxUnits: 3), '1d');
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
        expect(
          Duration(
            days: 1,
            hours: 3,
            minutes: 23,
            seconds: 5,
            milliseconds: 101,
          ).toReadable(
            maxUnits: 1,
          ),
          '1d',
        );
        expect(
          Duration(
            days: 1,
            hours: 3,
            minutes: 23,
            seconds: 5,
            milliseconds: 101,
          ).toReadable(
            maxUnits: 3,
          ),
          '1d 3h 23min',
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
        expect(
          Duration(
            hours: 3,
            minutes: 23,
            seconds: 5,
            milliseconds: 101,
          ).toReadable(
            maxUnits: 1,
          ),
          '3h',
        );
        expect(
          Duration(
            hours: 3,
            minutes: 23,
            seconds: 5,
            milliseconds: 101,
          ).toReadable(
            maxUnits: 3,
          ),
          '3h 23min 5s',
        );
        expect(
          Duration(
            hours: 1,
            minutes: 32,
          ).toReadable(),
          '1h 32min',
        );
      });
      test('Minute', () {
        expect(Duration(minutes: 23).toReadable(), '23min');
      });
      group('Minute and second', () {
        test('Max units 1', () {
          expect(
            Duration(
              minutes: 23,
              seconds: 5,
              milliseconds: 101,
            ).toReadable(
              maxUnits: 1,
            ),
            '23min',
          );
        });
        test('Max units 2', () {
          expect(
            Duration(
              minutes: 23,
              seconds: 5,
              milliseconds: 101,
            ).toReadable(
              maxUnits: 2,
            ),
            '23min 5s',
          );
        });
        test('Max units 3', () {
          expect(
            Duration(
              minutes: 23,
              seconds: 5,
              milliseconds: 101,
            ).toReadable(
              maxUnits: 3,
            ),
            '23min 5s 101ms',
          );
          expect(
            Duration(
              minutes: 23,
              seconds: 5,
              milliseconds: 101,
            ).toReadable(
              maxUnits: 3,
              unitNames: {
                TimeUnit.minute: 'minutes',
                TimeUnit.second: 'sec',
                TimeUnit.millisecond: 'milli',
              },
            ),
            '23minutes 5sec 101milli',
          );
        });
      });
      test('Second', () {
        expect(Duration(seconds: 5).toReadable(), '5s');
        expect(
            Duration(seconds: 5).toReadable(
              unitNames: {
                TimeUnit.second: 'sec',
              },
            ),
            '5sec');
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
