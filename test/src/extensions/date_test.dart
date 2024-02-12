import 'package:test/test.dart';
import 'package:vit_dart_extensions/vit_dart_extensions.dart';

void main() {
  group('date', () {
    test('formatAsReadable', () {
      final dt = DateTime(2022, 1, 30, 13, 22);
      final timeOnly = dt.formatAsReadable(false);
      expect(timeOnly, '30/01/2022');
    });
  });
}