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

  /// Parses a string in European date format (DD/MM/YYYY).
  static DateTime fromEuropean(String value) {
    var parts = value.split('/');
    if (parts.length != 3) {
      throw FormatException('Invalid date format');
    }
    int day = int.parse(parts[0]);
    int month = int.parse(parts[1]);
    int year = int.parse(parts[2]);
    return DateTime(year, month, day);
  }

  /// Adds or subtracts a specified number of months to/from the current date.
  ///
  /// [months] is the number of months to adjust. Positive values add months,
  /// while negative values subtract months.
  ///
  /// If [preserveMonth] is set to `true`, the method ensures that the resulting
  /// date remains within the expected month after the adjustment. If the original
  /// day does not exist in the resulting month, the date is adjusted to the last
  /// valid day of that month.
  ///
  /// If [preserveMonth] is set to `false`, the day overflow will continue into
  /// the next month. For example, adding 1 month to January 31 will result in
  /// March 3 (assuming it's not a leap year, because February has 28 days).
  ///
  /// Examples:
  /// ```dart
  /// DateTime(2020, 1, 31).addMonths(1)
  /// // Returns: DateTime(2020, 2, 29) - Adjusts to the last valid day of February in a leap year.
  ///
  /// DateTime(2020, 1, 31).addMonths(1, preserveMonth: false)
  /// // Returns: DateTime(2020, 3, 2) - Allows day overflow into March.
  ///
  /// DateTime(2020, 1, 31).addMonths(-1)
  /// // Returns: DateTime(2019, 12, 31) - Adjusts to December 31.
  ///
  /// DateTime(2020, 1, 31).addMonths(-1, preserveMonth: false)
  /// // Returns: DateTime(2019, 12, 31) - Since December has 31 days, no overflow occurs. ///
  /// ```
  /// Returns a [DateTime] object representing the adjusted date.
  DateTime addMonths(
    int months, {
    bool preserveMonth = true,
  }) {
    int totalMonths = month + months;
    int newYear = year + (totalMonths ~/ 12);
    int newMonth = totalMonths % 12;

    if (newMonth <= 0) {
      newMonth += 12;
      newYear -= 1;
    }

    int newDay = day;
    while (true) {
      var result = DateTime(newYear, newMonth, newDay);

      if (preserveMonth && newMonth != result.month) {
        newDay -= 1;
      } else {
        return result;
      }
    }
  }
}
