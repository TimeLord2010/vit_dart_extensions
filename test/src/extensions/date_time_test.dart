import 'package:test/test.dart';
import 'package:vit_dart_extensions/vit_dart_extensions.dart';

void main() {
  group('date time', () {
    test('pickRandom', () {
      expect(DateTimeExt.pickRandom().isBefore(DateTime.now()), true);
      var withBegin = DateTimeExt.pickRandom(DateTime(2020));
      expect(
        withBegin.isBefore(DateTime.now()),
        true,
        reason: 'Show be a date before current date when giving 2020',
      );
    });
  });
}
