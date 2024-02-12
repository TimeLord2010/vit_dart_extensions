import 'dart:convert';

extension ListExtension<T> on List<T> {
  /// Converts the list to a pretty-printed JSON string.
  /// 
  /// This method uses a [JsonEncoder] with an indentation of four spaces to format
  /// the JSON string for readability.
  /// 
  /// Returns:
  /// A string representing the JSON-encoded version of the list, formatted with
  /// indentation for easier reading.
  /// 
  /// Example:
  /// ```dart
  /// final list = [{'name': 'John Doe', 'age': 30}, {'name': 'Jane Doe', 'age': 27}];
  /// print(list.prettyJSON);
  /// /*
  /// [
  ///     {
  ///         "name": "John Doe",
  ///         "age": 30
  ///     },
  ///     {
  ///         "name": "Jane Doe",
  ///         "age": 27
  ///     }
  /// ]
  /// */
  /// ```
  String get prettyJSON {
    var encoder = const JsonEncoder.withIndent("    ");
    return encoder.convert(this);
  }
}
