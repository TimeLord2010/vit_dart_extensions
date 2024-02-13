import 'dart:convert';

extension ListExtension<T> on List<T> {
  /// Converts the list to a indented JSON string.
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

  /// Finds the first element in the list that satisfies the given [filter] function.
  ///
  /// Iterates through each element of the list, applying [filter] to each element.
  /// Returns the first element for which [filter] returns true. If no element satisfies
  /// the [filter], returns `null`.
  ///
  /// - Parameters:
  ///   - [filter]: A function that takes an item of type [T] as an argument and
  ///     returns a [bool]. It should return `true` for an item that matches the
  ///     criteria and `false` otherwise.
  ///
  /// - Returns: The first element of type [T] that satisfies the provided [filter]
  ///   function. Returns `null` if no element satisfies the [filter] function.
  ///
  /// Example:
  /// ```dart
  ///   List<String> names = ['Bob', 'Alice', 'Tom'];
  ///   String? firstNameStartingWithA = names.firstWhereOrNull((name) => name.startsWith('A'));
  ///   print(firstNameStartingWithA); // Output: Alice
  ///   // If no name starts with 'A', null will be printed instead.
  /// ```
  ///
  /// This method extends `List<T>` to provide a convenient way of finding an element
  /// that matches certain criteria without throwing an exception if no such element is found.
  T? firstWhereOrNull(bool Function(T item) filter) {
    for (final item in this) {
      var passed = filter(item);
      if (passed) {
        return item;
      }
    }
    return null;
  }
}
