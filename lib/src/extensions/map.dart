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
  /// DateTime? dt = json.tryGetDateTime('timestamp')
  /// ```
  DateTime? tryGetDateTime(String key) {
    dynamic v = this[key];
    if (v == null) return null;
    if (v is DateTime) return v;
    if (v is String && v.isNotEmpty) {
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
  /// DateTime dt = json.getDateTime('timestamp')
  /// ```
  DateTime getDateTime(String key) {
    dynamic v = this[key];
    if (v is String) return DateTime.parse(v);
    if (v is DateTime) return v;
    throw FormatException('Unable to cast value in $key to DateTime', v);
  }

  /// Tries to retrieve a value from the map by the provided [key] and convert
  /// it to a double.
  ///
  /// The method checks the type of the value associated with the [key] in the
  /// following order:
  /// - If the value is already a double, it is returned as is.
  /// - If the value is an int, it is converted to double and returned.
  /// - If the value is a String, the method tries to parse it as a double.
  ///
  /// If the value cannot be converted to double, the method returns `null`.
  ///
  /// Example:
  /// ```dart
  /// var map = {'a': 1, 'b': '2.5', 'c': 'three'};
  /// print(map.tryGetDouble('a')); // 1.0
  /// print(map.tryGetDouble('b')); // 2.5
  /// print(map.tryGetDouble('c')); // null
  /// ```
  double? tryGetDouble(String key) {
    var v = this[key];
    if (v is double) {
      return v;
    }
    if (v is int) {
      return v.toDouble();
    }
    if (v is String) {
      var d = double.tryParse(v);
      if (d != null) return d;
      var i = int.tryParse(v);
      if (i != null) return i.toDouble();
    }
    return null;
  }

  /// Retrieves a value from the map by the provided [key] and converts it to
  /// a double.
  ///
  /// This method uses [tryGetDouble] to attempt conversion. If the conversion
  /// fails and the value is `null`, it throws a [FormatException].
  ///
  /// Example:
  /// ```dart
  /// var map = {'a': 1, 'b': '2.5', 'c': 'three'};
  /// print(map.getDouble('a')); // 1.0
  /// print(map.getDouble('b')); // 2.5
  /// print(map.getDouble('c')); // throws FormatException
  /// ```
  double getDouble(String key) {
    var value = tryGetDouble(key);
    if (value == null) {
      var message = 'Unable to cast value in $key to double';
      throw FormatException(message, this[key]);
    }
    return value;
  }

  /// Tries to retrieve a value from the map by the provided [key] and convert
  /// it to a list of type [T].
  ///
  /// The method expects the value associated with the [key] to be a list. It
  /// uses the provided [parser] function to convert each item in the list to
  /// type [T].
  ///
  /// If the value is not a list, the method returns a empty list.
  ///
  /// Example:
  /// ```dart
  /// var map = {
  ///   'ints': [1, 2, 3],
  ///   'strings': ['a', 'b', 'c'],
  ///   'mixed': [null, '2', 3.0],
  ///   'notArray': 12,
  /// };
  /// print(map.getList<int>('ints', (x) => x as int?)); // [1, 2, 3]
  /// print(map.getList<String>('strings', (x) => x as String?)); // ['a', 'b', 'c']
  /// print(map.getList<double>('mixed', (x) => double.tryParse(x.toString()))); // [2.0, 3.0]
  /// print(map.getList<String>('notArray', (x) => x as String)); // []
  /// ```
  List<T> getList<T>(String key, T? Function(dynamic item) parser) {
    var rawValue = this[key];
    if (rawValue == null) {
      return [];
    }
    if (rawValue is! List) {
      return [];
    }
    List rawList = rawValue;
    return rawList.map((x) => parser(x)).whereType<T>().toList();
  }

  /// Generates a idented JSON string.
  String get prettyJSON {
    var encoder = const JsonEncoder.withIndent("    ");
    return encoder.convert(this);
  }
}
