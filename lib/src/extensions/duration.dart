import 'package:vit_dart_extensions/src/data/enums/time_unit.dart';

extension DurationExt on Duration {
  /// Converts the duration to a readable string format.
  ///
  /// The output is the representation of the closest greatest unit of time
  /// in the duration along with the second greatest unit.
  ///
  /// Examples:
  /// ```dart
  /// Duration(days: 1, hours: 3, minutes: 23, seconds: 5, milliseconds: 101).toReadable(); // '1d 3h'
  /// Duration(hours: 3, minutes: 23, seconds: 5, milliseconds: 101).toReadable(); // '3h 23min'
  /// Duration(minutes: 23, seconds: 5, milliseconds: 101).toReadable(); // '23min 5s'
  /// Duration(seconds: 5).toReadable(); // '5s'
  /// Duration(seconds: 5, milliseconds: 101).toReadable(); // '5s 101ms'
  /// Duration(milliseconds: 101).toReadable(); // '101ms'
  /// Duration.zero.toReadable(); // '0s'
  /// ```
  String toReadable({
    bool millisecondsAsDecimal = false,
    int? maxUnits = 2,
    Map<TimeUnit, String>? unitNames,
  }) {
    var duration = this;
    var units = <String>[];

    void addUnit(dynamic value, String unit) {
      assert(value is int || value is String);
      if (unitNames == null) {
        units.add('$value$unit');
        return;
      }
      var realUnit = unitNames[TimeUnit.fromString(unit)] ?? unit;
      units.add('$value$realUnit');
    }

    // Days
    if (duration.inDays > 0) {
      addUnit(duration.inDays, 'd');
      if (maxUnits != null && units.length >= maxUnits) return units.join(' ');
      duration -= Duration(days: duration.inDays);
    }

    // Hours
    if (duration.inHours > 0) {
      addUnit(duration.inHours, 'h');
      if (maxUnits != null && units.length >= maxUnits) return units.join(' ');
      duration -= Duration(hours: duration.inHours);
    }

    // Minutes
    if (duration.inMinutes > 0) {
      addUnit(duration.inMinutes, 'min');
      if (maxUnits != null && units.length >= maxUnits) return units.join(' ');
      duration -= Duration(minutes: duration.inMinutes);
    }

    // Seconds
    if (duration.inSeconds > 0) {
      if (millisecondsAsDecimal) {
        addUnit(_formatSecAndMilli(duration), 's');
        return units.join(' ');
      } else {
        addUnit(duration.inSeconds, 's');
        if (maxUnits != null && units.length >= maxUnits) {
          return units.join(' ');
        }
        duration -= Duration(seconds: duration.inSeconds);
      }
    }

    if (duration.inMilliseconds > 0) {
      int milliseconds = duration.inMilliseconds % 1000;
      var milliStr = milliseconds.toString().padLeft(3, '0');
      if (millisecondsAsDecimal) {
        addUnit('0.$milliStr', 's');
        if (maxUnits != null && units.length >= maxUnits) {
          return units.join(' ');
        }
      } else {
        addUnit(milliStr, 'ms');
        if (maxUnits != null && units.length >= maxUnits) {
          return units.join(' ');
        }
      }
    } else {
      if (units.isEmpty) {
        addUnit(0, 's');
      }
    }

    return units.join(' ');
  }
}

/// Considers the milliseconds of a duration and format it as a decimal
/// with the unit being second.
///
/// Example:
/// ```dart
/// _formatSecAndMilli(Duration(seconds: 5, milliseconds: 101)); // '5.101'
/// ```
///
/// Example:
/// ```dart
/// _formatSecAndMilli(Duration(seconds: 5, milliseconds: 0)); // '5'
/// ```
String _formatSecAndMilli(Duration duration) {
  int seconds = duration.inSeconds % 60;
  int milliseconds = duration.inMilliseconds % 1000;
  if (milliseconds > 0) {
    return '$seconds.${milliseconds.toString().padLeft(3, '0')}';
  } else {
    return '$seconds';
  }
}
