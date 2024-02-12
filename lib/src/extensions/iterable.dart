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
}
