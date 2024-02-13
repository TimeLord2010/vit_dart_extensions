import 'dart:convert';

extension MapStringDynamicExtension on Map<String, dynamic> {
  /// Reads a value from the Map and returns it as a DateTime, if possible.
  /// - If the value is a DateTime, then this value is returned;
  /// - If the value is a String, then it tries to parse it;
  /// - If none of the criteria before is meet, null is returned.
  ///
  /// This method is meant to simplify this code:
  /// ```dart
  /// Map<String, dynamic> json = { ... };
  /// String? isoString = json['timestamp'];
  /// DateTime? dt = null;
  /// if (isoString != null) {
  ///   dt = DateTime.tryParse(isoString);
  /// }
  /// ```
  /// Which becomes more simpler:
  /// ```dart
  /// Map<String, dynamic> json = { ... };
  /// DateTime? dt = json.getMaybeDateTime('timestamp')
  /// ```
  DateTime? getMaybeDateTime(String key) {
    dynamic v = this[key];
    if (v == null) return null;
    if (v is DateTime) return v;
    if (v is String) {
      return DateTime.tryParse(v);
    }
    return null;
  }

  /// Reads the value from the given key, and process it to returns a DateTime.
  /// - If the value is a DateTime, then this value is returned;
  /// - If the value is a String, then it tries to parse it;
  /// - If none of the criteria before is meet, a FormatException is thrown.
  ///
  /// This method is meant to simplify this code:
  /// ```dart
  /// Map<String, dynamic> json = { ... };
  /// dynamic isoString = json['timestamp'];
  /// DateTime dt = iso is String ? DateTime.parse(isoString) : isoString;
  /// ```
  /// Which becomes more simpler:
  /// ```dart
  /// Map<String, dynamic> json = { ... };
  /// DateTime dt = json.getMaybeDateTime('timestamp')
  /// ```
  DateTime getDateTime(String key) {
    dynamic v = this[key];
    if (v is String) return DateTime.parse(v);
    if (v is DateTime) return v;
    throw FormatException('Unable to cast value in $key to DateTime', v);
  }

  /// Generates a idented JSON string.
  String get prettyJSON {
    var encoder = const JsonEncoder.withIndent("    ");
    return encoder.convert(this);
  }
}
