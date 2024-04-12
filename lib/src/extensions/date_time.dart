import 'dart:math';

extension DateTimeExt on DateTime {
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

  /// Picks a random DateTime between two optional DateTime parameters.
  /// If no parameters are provided, it defaults to the Unix epoch
  /// (January 1, 1970) for the start and the current DateTime for the end.
  ///
  /// Example:
  /// ```dart
  /// var randomDt = DateTimeExt.pickRandom();
  /// ```
  static DateTime pickRandom([DateTime? begin, DateTime? end]) {
    begin ??= DateTime(1970);
    end ??= DateTime.now();
    var beginEpoch = begin.millisecondsSinceEpoch;
    var endEpoch = end.millisecondsSinceEpoch;

    // Dividing to 1000 to prevent nextInt 32 bit limitations.
    int diff = (endEpoch - beginEpoch) ~/ 1000;

    assert(diff >= 0, '"begin" must come before "end"');

    var randomEpoch = (beginEpoch ~/ 1000) + Random().nextInt(diff);

    // Multiplying to 1000 to fix the value.
    return DateTime.fromMillisecondsSinceEpoch(randomEpoch * 1000);
  }
}
