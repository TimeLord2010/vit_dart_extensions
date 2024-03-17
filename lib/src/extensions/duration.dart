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
  /// Duration(seconds: 5, milliseconds: 101).toReadable(); // '5.101s'
  /// Duration(milliseconds: 101).toReadable(); // '0.101s'
  /// Duration.zero.toReadable(); // '0s'
  /// ```
  String toReadable() {
    var duration = this;
    String formattedString = '';
    if (duration.inDays > 0) {
      formattedString += '${duration.inDays}d ';
      int hours = duration.inHours % 24;
      if (hours > 0) {
        formattedString += '${hours}h';
      }
    } else if (duration.inHours > 0) {
      formattedString += '${duration.inHours}h ';
      int minutes = duration.inMinutes % 60;
      if (minutes > 0) {
        formattedString += '${minutes}min';
      }
    } else if (duration.inMinutes > 0) {
      formattedString += '${duration.inMinutes}min ';
      int seconds = duration.inSeconds % 60;
      if (seconds > 0) {
        formattedString += '${seconds}s';
      }
    } else if (duration.inSeconds > 0 || duration.inMilliseconds > 0) {
      formattedString += _formatSecondsAndMilliseconds(duration);
    } else {
      formattedString = '0s';
    }

    return formattedString.trim();
  }
}

String _formatSecondsAndMilliseconds(Duration duration) {
  int seconds = duration.inSeconds % 60;
  int milliseconds = duration.inMilliseconds % 1000;
  if (milliseconds > 0) {
    return '$seconds.${milliseconds.toString().padLeft(3, '0')}s';
  } else {
    return '${seconds}s';
  }
}
