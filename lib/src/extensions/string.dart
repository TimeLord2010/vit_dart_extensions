import 'package:intl/intl.dart';

extension StringExtension on String {
  /// Converts strings in ISO-8601 or DD/MM/(YYYY|YY)[ HH:mm] formats to a DateTime object.
  /// The returned DateTime object does not take hours, minutes, or seconds into account.
  ///
  /// Returns `null` if the string cannot be parsed into a valid date.
  ///
  /// ```dart
  /// String isoDateString = "2022-01-01";
  /// String brDateString = "01/01/2022";
  /// print(isoDateString.toMaybeDate()); // Outputs: 2022-01-01 00:00:00.000
  /// print(brDateString.toMaybeDate()); // Outputs: 2022-01-01 00:00:00.000
  /// ```
  DateTime? toMaybeDate() {
    // Splits the string by 'T' or whitespace, then takes the date part
    var dateStr = split(RegExp(r'T|\s')).elementAt(0);
    // Splits the date into parts and tries to parse each part into an integer
    var parts = dateStr.split(RegExp(r'/|-')).map((x) {
      return int.tryParse(x, radix: 10);
    });
    if (parts.length != 3) return null;

    int? year, month, day;

    // Determines if the format is ISO-8601 (YYYY-MM-DD)
    if (contains(RegExp(r'^\d{4}-'))) {
      year = parts.elementAt(0);
      month = parts.elementAt(1);
      day = parts.elementAt(2);
    } else {
      // Assumes the format is DD/MM/(YY|YYYY)
      day = parts.elementAt(0);
      month = parts.elementAt(1);
      year = parts.elementAt(2);
    }

    // Validates the date components
    if (year == null || month == null || day == null || month > 12 || day > 31) return null;
    // Adjusts for two-digit years
    if (year < 100) year += 2000;

    // Creates the DateTime object from the parts
    var dt = DateTime(year, month, day);
    return dt;
  }

  /// Inserts a given string [value] into the current string at the specified index [i].
  ///
  /// Returns a new string with the value inserted.
  ///
  /// ```dart
  /// String originalString = "HelloWorld";
  /// print(originalString.insertAt(5, " ")); // Outputs: "Hello World"
  /// ```
  String insertAt(int i, String value) {
    final start = substring(0, i);
    final end = substring(i);
    return start + value + end;
  }

  /// Checks if the current string is a valid email address.
  ///
  /// Returns `true` if the string matches the email pattern, otherwise `false`.
  ///
  /// ```dart
  /// String email = "example@example.com";
  /// String nonEmail = "notAnEmail";
  /// print(email.isEmail); // Outputs: true
  /// print(nonEmail.isEmail); // Outputs: false
  /// ```
  bool get isEmail {
    final pattern = RegExp(r'^.+@.*\.[a-zA-Z]+$');
    return pattern.hasMatch(this);
  }

  /// Returns the initials of each word of a string.
  ///
  /// This function takes a string and returns its initials, up to a specified
  /// number of initials. By default, it returns the first two initials without
  /// any separator.
  ///
  /// Examples:
  /// ```dart
  /// var name = 'John Doe';
  /// print(name.getInitials()); // 'JD'
  ///
  /// print(name.getInitials(initialsCount: 1)); // 'J'
  ///
  /// print(name.getInitials(joinString: '.')); // 'J.D'
  /// ```
  ///
  /// Parameters:
  /// - `initialsCount` (int): The maximum number of initials to return.
  ///   Defaults to 2.
  /// - `joinString` (String): The string to use to join the initials.
  ///   Defaults to '' (no separator).
  ///
  /// Returns:
  /// A string containing the initials.
  String getInitials({
    int initialsCount = 2,
    String joinString = '',
  }) {
    var words = split(' ').where((x) => x.isNotEmpty);
    var initials = words.map((x) => x.substring(0, 1).toUpperCase());
    return initials.take(initialsCount).join(joinString);
  }
}

extension StringBRExtension on String {
  /// Attempts to parse the current string as a double, assuming Brazilian number format (comma for decimal separator).
  ///
  /// Returns the parsed double if successful, otherwise `null`.
  ///
  /// ```dart
  /// String brNumber = "1.234,56";
  /// print(brNumber.tryParseFromBrazillianFormat()); // Outputs: 1234.56
  /// ```
  double? tryParseFromBrazillianFormat() {
    try {
      return NumberFormat('0.0', 'pt_BR').parse(this).toDouble();
    } catch (e) {
      // Returns null if parsing fails
      return null;
    }
  }
}
