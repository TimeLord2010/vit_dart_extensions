import 'double.dart';

extension IntExtension on int {
  /// Converts the int (assumed to be the number of bytes), to a readable
  /// string form.
  ///
  /// ```dart
  /// 500.readableByteSize(); // 500 B
  /// 1024.readableByteSize(); // 1 KB
  /// 2148.readableByteSize(); // 2.1 KB
  /// 1048576.readableByteSize(); // 1 MB
  /// 1073741824.readableByteSize(); // 1 GB
  /// ```
  String readableByteSize([int decimalPlaces = 1]) {
    if (this < 0) {
      throw const FormatException('Negative numbers are not a valid byte size.');
    }
    if (this < 1024) return '$this B';
    double kilo = this / 1024;
    if (kilo < 1024) return '${kilo.toStringAsFixedRounded(1)} KB';
    double mega = kilo / 1024;
    if (mega < 1024) return '${mega.toStringAsFixedRounded(1)} MB';
    double giga = mega / 1024;
    return '${giga.toStringAsFixedRounded(1)} GB';
  }
}
