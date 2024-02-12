import 'package:test/test.dart';
import 'package:vit_dart_extensions/vit_dart_extensions.dart';

void main() {
  group('double', () {
    test('toStringAsFixedRounded', () {
      const input = 3.1415;
      expect(input.toStringAsFixedRounded(4), '3.1415');
      expect(input.toStringAsFixedRounded(5), '3.1415');
      expect(input.toStringAsFixedRounded(3), '3.142');
      expect(input.toStringAsFixedRounded(2), '3.14');
      expect((3.0).toStringAsFixedRounded(2), '3');
    });
  });
}