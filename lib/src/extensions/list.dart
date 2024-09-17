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

  /// Sorts the list by the given date of each item.
  void sortByDate(DateTime Function(T item) getter, [bool asc = true]) {
    if (asc) {
      sort((a, b) => getter(a).compareTo(getter(b)));
    } else {
      sort((a, b) => getter(b).compareTo(getter(a)));
    }
  }

  /// Sorts the list by the given number of each item.
  void sortByNum(num Function(T item) getter, [bool asc = true]) {
    if (asc) {
      sort((a, b) => getter(a).compareTo(getter(b)));
    } else {
      sort((a, b) => getter(b).compareTo(getter(a)));
    }
  }

  /// Sorts the list assuming the extracted string is a number.
  ///
  /// If [appendNonNumbersAtEnd] is `true`, then the items that are not a valid
  /// number are appended at the end of the numberic items. Otherwise, they
  /// are inserted at the begining of the list.
  void sortByNumericString(
    String Function(T item) getter, {
    bool asc = true,
    bool appendNonNumbersAtEnd = true,
  }) {
    List<(num, T)> numericTuple = [];
    List<T> nonNumericItems = [];

    for (var item in this) {
      String sortValue = getter(item);
      num? numValue = num.tryParse(sortValue);
      if (numValue != null) {
        numericTuple.add((numValue, item));
      } else {
        nonNumericItems.add(item);
      }
    }

    numericTuple.sortByNum((item) => item.$1, asc);
    nonNumericItems.sortByString(getter, asc);

    var numericItems = numericTuple.map((x) => x.$2);

    List<T> generateFinalList() {
      if (appendNonNumbersAtEnd) {
        return [
          ...numericItems,
          ...nonNumericItems,
        ];
      } else {
        return [
          ...nonNumericItems,
          ...numericItems,
        ];
      }
    }

    clear();
    addAll(generateFinalList());
  }

  /// Sorts the list by the given string of each item.
  void sortByString(String Function(T item) getter, [bool asc = true]) {
    if (asc) {
      sort((a, b) => getter(a).compareTo(getter(b)));
    } else {
      sort((a, b) => getter(b).compareTo(getter(a)));
    }
  }
}
