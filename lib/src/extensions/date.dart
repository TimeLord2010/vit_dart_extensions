extension DateTimeExtension on DateTime {
  /// Creates a string with one of the following formarts:
  /// - DD/MM/YYYY
  /// - DD/MM/YYYY hh:mm (24 hour format)
  String formatAsReadable([bool showTime = true]) {
    final dt = this;
    final day = dt.day.toString().padLeft(2, '0');
    final month = dt.month.toString().padLeft(2, '0');
    final year = dt.year.toString();
    final hour = dt.hour.toString().padLeft(2, '0');
    final minute = dt.minute.toString().padLeft(2, '0');
    if (showTime) {
      return '$day/$month/$year $hour:$minute';
    }
    return '$day/$month/$year';
  }
}
