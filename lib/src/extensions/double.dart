extension DoubleExtension on double {
  /// Works the same as `toStringAsFixed`, but if the resulting string has only
  /// zero in the decimal place, it removes the decimal part.
  ///
  /// `(10.12)toStringAsFixed(1) // 10.1`
  ///
  /// `(10.0).toStringAsFixed(1) // 10`
  String toStringAsFixedRounded(int places) {
    String str = toStringAsFixed(places);
    while (str.endsWith('0')) {
      str = str.substring(0, str.length - 1);
    }
    if (str.endsWith('.')) {
      str = str.substring(0, str.length - 1);
    }
    return str;
  }
}
