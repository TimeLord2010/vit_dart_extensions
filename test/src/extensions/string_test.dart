import 'package:test/test.dart';
import 'package:vit_dart_extensions/src/extensions/string.dart';

void main() {
  group('string', () {
    test('hasLengthBetween', () {
      expect('abcd'.hasLengthBetween(0, 1), false);
      expect('abcd'.hasLengthBetween(3, 4), true);
      expect('abcd'.hasLengthBetween(3, 5), true);
      expect('abcd'.hasLengthBetween(4, 5), true);
      expect('abcd'.hasLengthBetween(5, 9), false);
      expect(() => 'abcd'.hasLengthBetween(-1, 5), throwsA(isA<RangeError>()));
      expect(() => 'abcd'.hasLengthBetween(4, 2), throwsA(isA<RangeError>()));
    });
    test('toTitleCase', () {
      expect('hello world'.toTitleCase(), 'Hello World');
      expect('hora de sair'.toTitleCase((x) => x == 'de'), 'Hora de Sair');
    });
  });
}
