import 'package:test/test.dart';
import 'package:vit_dart_extensions/vit_dart_extensions.dart';

void main() {
  group('date', () {
    test('formatAsReadable', () {
      final dt = DateTime(2022, 1, 30, 13, 22);
      final dateOnly = dt.formatAsReadable(false);
      expect(dateOnly, '30/01/2022');
      final dateAndTime = dt.formatAsReadable();
      expect(dateAndTime, '30/01/2022 13:22');
    });
  });
}