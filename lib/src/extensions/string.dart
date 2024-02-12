import 'num.dart';

extension StringExtension on String {
  /// Converts strings in ISO-8601 and DD/MM/(YYYY|YY)[ HH:mm] formarts in DateTime.
  /// The returned object does does contain the hours, minutes of seconds into account.
  DateTime? toMaybeDate() {
    var dateStr = split(RegExp(r'T|\s')).elementAt(0);
    var parts = dateStr.split(RegExp(r'/|-')).map((x) {
      return int.tryParse(x, radix: 10);
    });
    if (parts.length != 3) return null;
    int? year, month, day;

    // Check if it's in the format of an ISO 8601 string (YYYY-MM-DD)
    if (contains(RegExp(r'^\d{4}-'))) {
      year = parts.elementAt(0);
      month = parts.elementAt(1);
      day = parts.elementAt(2);
    } else {
      // Assume it's in DD/MM/(YY|YYYY) format
      day = parts.elementAt(0);
      month = parts.elementAt(1);
      year = parts.elementAt(2);
    }
    if (year == null || month == null || day == null) return null;
    if (month > 12) return null;
    if (day > 31) return null;
    if (year < 100) year += 2000;
    var dt = DateTime(year, month, day);
    return dt;
  }

  String insertAt(int i, String value) {
    final start = substring(0, i);
    final end = substring(i);
    return start + value + end;
  }

  // /// FNV-1a 64bit hash algorithm optimized for Dart Strings
  // int fastHash() {
  //   var hash = 0xcbf29ce484222325;

  //   var i = 0;
  //   while (i < length) {
  //     final codeUnit = codeUnitAt(i++);
  //     hash ^= codeUnit >> 8;
  //     hash *= 0x100000001b3;
  //     hash ^= codeUnit & 0xFF;
  //     hash *= 0x100000001b3;
  //   }

  //   return hash;
  // }

  bool get isEmail {
    final pattern = RegExp(r'^.+@.*\.[a-zA-Z]+$');
    return pattern.hasMatch(this);
  }
}

extension StringBRExtension on String {
  double? tryParseFromBrazillianFormat() {
    try {
      return brNumberFormat.parse(this).toDouble();
    } catch (e) {
      return null;
    }
  }
}
