import 'package:test/test.dart';
import 'package:vit_dart_extensions/src/extensions/iterable.dart';

void main() {
  group('iterable', () {
    test('removeIndices', () {
      List<String> names = ['Bob', 'Alice', 'Tom', 'Fiona'];
      List<String> filtered = names.removeIndices({1, 3});
      expect(names.length, 4);
      expect(filtered.length, 2);
      expect(filtered, ['Bob', 'Tom']);
    });
  });
}
