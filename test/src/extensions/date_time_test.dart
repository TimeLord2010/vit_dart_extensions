import 'package:test/test.dart';
import 'package:vit_dart_extensions/vit_dart_extensions.dart';

void main() {
  group('date time', () {
    test('pickRandom', () {
      var random = DateTimeExt.pickRandom();
      expect(random != DateTime.now(), true);
    });
  });
}
