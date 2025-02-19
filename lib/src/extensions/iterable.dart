import 'dart:math';

extension IterableExtension<T> on Iterable<T> {
  /// Divides the iterable into a list of iterables each with a maximum length of [size].
  /// If the original iterable's length is less than or equal to [size],
  /// a single chunk containing all elements will be returned.
  ///
  /// The method throws a [ArgumentError] if [size] is less than or equal to 0.
  ///
  /// Example:
  /// ```dart
  /// final numbers = [1, 2, 3, 4, 5, 6];
  /// final chunks = numbers.chunck(2);
  /// print(chunks); // ([1, 2], [3, 4], [5, 6])
  /// ```
  List<Iterable<T>> chunck(int size) {
    if (size <= 0) throw ArgumentError('size must be greater than 0');
    if (length <= size) {
      return [this];
    }
    return [
      take(size),
      ...skip(size).chunck(size),
    ];
  }

  /// Creates a new list from the iterable by interspersing a given [separator] between each element.
  /// If the iterable contains less than two elements, the original iterable is returned as a list.
  ///
  /// Example:
  /// ```dart
  /// final letters = ['a', 'b', 'c'];
  /// final spacedLetters = letters.separatedBy('-');
  /// print(spacedLetters); // ['a', '-', 'b', '-', 'c']
  /// ```
  List<T> separatedBy(T separator) {
    if (length < 2) return toList();
    return [first, separator, ...skip(1).separatedBy(separator)];
  }

  /// Finds the first element in the iterable that satisfies the given [filter]
  /// function.
  ///
  /// Iterates through each element of the iterable, applying [filter] to each
  /// element.
  /// Returns the first element for which [filter] returns true. If no element
  /// satisfies
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
  ///   Iterable<String> names = ['Bob', 'Alice', 'Tom'];
  ///   String? firstNameStartingWithA = names.firstWhereOrNull((name) => name.startsWith('A'));
  ///   print(firstNameStartingWithA); // Output: Alice
  ///   // If no name starts with 'A', null will be printed instead.
  /// ```
  T? firstWhereOrNull(bool Function(T item) filter) {
    for (final item in this) {
      var passed = filter(item);
      if (passed) {
        return item;
      }
    }
    return null;
  }

  /// Picks an item at a random index.
  ///
  /// If [exclude] is provided, it will exclude items that satisfy the given.
  ///
  /// If [excludeItems] is provided, it will exclude the items in the list.
  ///
  /// Throws an [ArgumentError] if all items are excluded.
  T pickRandom({
    bool Function(T item)? exclude,
    Iterable<T>? excludeItems,
  }) {
    if (exclude != null) {
      var filtered = where((item) => !exclude(item)).toList();
      if (filtered.isEmpty) {
        throw ArgumentError('All items are excluded');
      }
      return filtered.pickRandom(
        excludeItems: excludeItems,
      );
    }

    if (excludeItems != null) {
      var filtered = where((item) => !excludeItems.contains(item)).toList();
      if (filtered.isEmpty) {
        throw ArgumentError('All items are excluded');
      }
      return filtered.pickRandom();
    }

    var index = Random().nextInt(length);
    return elementAt(index);
  }

  List<T> pickNRandom(int count) {
    var selected = <T>[];
    for (int i = 0; i < count; i++) {
      try {
        var item = pickRandom(excludeItems: selected);
        selected.add(item);
      } on ArgumentError {
        // When all items are excluded, we break the loop.
        break;
      }
    }
    return selected;
  }

  /// Removes the items in the given indexes.
  ///
  /// This function creates a new list and does not change the original
  /// iterable.
  ///
  /// Example:
  /// ```dart
  /// Iterable<String> names = ['Bob', 'Alice', 'Tom', 'Fiona'];
  /// Iterable<String> filtered = names.removeIndices({1,3}); // ('Bob', 'Tom')
  /// ```
  List<T> removeIndices(Set<int> indices) {
    var newList = <T>[];
    for (int i = 0; i < length; i++) {
      if (indices.contains(i)) {
        continue;
      }
      newList.add(elementAt(i));
    }
    return newList;
  }

  int count(bool Function(T x) filter) => where(filter).length;
}

extension IterableNumExtension<T extends num> on Iterable<T> {
  T get sum {
    T acc;
    if (T == double) {
      acc = 0.0 as T;
    } else {
      acc = 0 as T;
    }

    for (var value in this) {
      acc = acc + value as T;
    }
    return acc;
  }

  /// Computes the average of all elements in the iterable.
  ///
  /// If the iterable is empty, the average is 0. Otherwise, it is calculated as the
  /// sum of the elements divided by the number of elements.
  double get avg {
    if (isEmpty) return 0;
    return sum / length;
  }
}
