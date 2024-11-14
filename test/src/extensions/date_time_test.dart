import 'package:test/test.dart';
import 'package:vit_dart_extensions/vit_dart_extensions.dart';

void main() {
  test('pickRandom', () {
    expect(DateTimeExt.pickRandom().isBefore(DateTime.now()), true);
    var withBegin = DateTimeExt.pickRandom(DateTime(2020));
    expect(
      withBegin.isBefore(DateTime.now()),
      true,
      reason: 'Show be a date before current date when giving 2020',
    );
  });

  group('addMonth', () {
    test('Simple addition', () {
      expect(DateTime(2020, 1, 1).addMonths(1), DateTime(2020, 2, 1));
      expect(DateTime(2020, 1, 1).addMonths(2), DateTime(2020, 3, 1));
      expect(DateTime(2020, 12, 1).addMonths(1), DateTime(2021, 1, 1));
      expect(DateTime(2024, 11, 14).addMonths(1), DateTime(2024, 12, 14));
      expect(DateTime(2024, 11, 14).addMonths(2), DateTime(2025, 1, 14));
    });
    test('to month with non existent day of the original', () {
      expect(DateTime(2020, 1, 31).addMonths(1), DateTime(2020, 2, 29));
      expect(
          DateTime(2020, 1, 31).addMonths(
            1,
            preserveMonth: false,
          ),
          DateTime(2020, 3, 2));
    });
    test('negative month', () {
      expect(DateTime(2020, 1, 1).addMonths(-1), DateTime(2019, 12, 1));
    });
  });
}
