import 'package:test/test.dart';
import 'package:vit_dart_extensions/vit_dart_extensions.dart';

void main() {
  group('num', () {
    test('formatToBrazillian', () {
      num a = 1234.789;
      expect(a.formatToBrazilian(), '1234,789');
      expect(a.formatToBrazilian(useThousandSeparator: true), '1.234,789');
    });
  });
}
