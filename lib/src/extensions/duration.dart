import '../data/enums/time_unit.dart';

extension DurationExt on Duration {
  /// Converts the duration to a readable string format.
  ///
  /// The output is the representation of the closest greatest unit of time
  /// in the duration along with the second greatest unit.
  ///
  /// Examples:
  /// ```dart
  /// Duration(days: 1).toReadable(); // '1d'.
  /// Duration(hours: 3, minutes: 23, seconds: 5).toReadable(); // '3h 23min'.
  /// Duration(minutes: 23, seconds: 5, milliseconds: 101).toReadable(maxUnits: 3); // '23min 5s 101ms'.
  /// Duration(seconds: 5, milliseconds: 101).toReadable(millisecondsAsDecimal: true); // '5.101s'.
  /// ```
  String toReadable({
    bool millisecondsAsDecimal = false,
    int? maxUnits = 2,
    Map<TimeUnit, String>? unitNames,
  }) {
    var duration = this;
    var units = <(String, TimeUnit)>[];

    void addUnit(dynamic value, TimeUnit unit) {
      assert(value is int || value is String);
      if (units.isNotEmpty) {
        var (_, lastUnit) = units.last;
        if (!lastUnit.isAdjacent(unit)) {
          return;
        }
      }
      units.add(('$value', unit));
    }

    String generateResult() {
      var parts = units.map((item) {
        var (value, unit) = item;
        if (unitNames == null) {
          return '$value${unit.toShortString()}';
        }
        var realUnit = unitNames[unit] ?? unit.toShortString();
        return '$value$realUnit';
      });
      return parts.join(' ');
    }

    // Days
    if (duration.inDays > 0) {
      addUnit(duration.inDays, TimeUnit.day);
      if (maxUnits != null && units.length >= maxUnits) return generateResult();
      duration -= Duration(days: duration.inDays);
    }

    // Hours
    if (duration.inHours > 0) {
      addUnit(duration.inHours, TimeUnit.hour);
      if (maxUnits != null && units.length >= maxUnits) return generateResult();
      duration -= Duration(hours: duration.inHours);
    }

    // Minutes
    if (duration.inMinutes > 0) {
      addUnit(duration.inMinutes, TimeUnit.minute);
      if (maxUnits != null && units.length >= maxUnits) return generateResult();
      duration -= Duration(minutes: duration.inMinutes);
    }

    // Seconds
    if (duration.inSeconds > 0) {
      if (millisecondsAsDecimal) {
        addUnit(_formatSecAndMilli(duration), TimeUnit.second);
        return generateResult();
      } else {
        addUnit(duration.inSeconds, TimeUnit.second);
        if (maxUnits != null && units.length >= maxUnits) {
          return generateResult();
        }
        duration -= Duration(seconds: duration.inSeconds);
      }
    }

    if (duration.inMilliseconds > 0) {
      int milliseconds = duration.inMilliseconds % 1000;
      var milliStr = milliseconds.toString().padLeft(3, '0');
      if (millisecondsAsDecimal) {
        addUnit('0.$milliStr', TimeUnit.second);
        if (maxUnits != null && units.length >= maxUnits) {
          return generateResult();
        }
      } else {
        addUnit(milliStr, TimeUnit.millisecond);
        if (maxUnits != null && units.length >= maxUnits) {
          return generateResult();
        }
      }
    } else {
      if (units.isEmpty) {
        addUnit(0, TimeUnit.second);
      }
    }

    return generateResult();
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
