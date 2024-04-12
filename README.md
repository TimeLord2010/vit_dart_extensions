A Dart package providing a wide range of extension methods for various data types including int, String, DateTime, and Map. The package is designed to offer practical, easy-to-use enhancements that seamlessly integrate with your existing Dart code, facilitating more concise and readable syntax.

# Summary

1. [Extensions](#extensions)
    - [DateTime](#datetime)
    - [Directory](#directory)
    - [Duration](#duration)
    - [double](#double)
    - [File](#file)
    - [int](#int)
    - [Iterable](#iterable)
    - [List](#file)
    - [Map](#mapstring-dynamic)
    - [String](#string)

# Extensions

## DateTime

### formartAsReadable

```dart
String formatAsReadable([bool showTime = true]);
```

```dart
final dt = DateTime(2023, 1, 30, 13, 22);
String dateAndTime = dt.formatAsReadable(); // "30/01/2023 13:22"
String dateOnly = dt.formatAsReadable(false); // "30/01/2023"
```

### pickRandom

```dart
static DateTime pickRandom([DateTime? begin, DateTime? end]);
```

Picks a random DateTime between two optional DateTime parameters.
If no parameters are provided, it defaults to the Unix epoch
(January 1, 1970) for the start and the current DateTime for the end.

Example:
```dart
var randomDt = DateTimeExt.pickRandom();
```

## Directory

### listDirectoryFiles

```dart
Stream<File> listDirectoryFiles({
    void Function(Directory directory, Object e)? onDirectoryReadError,
});
```

This method is equivalent to `dir.listSync(recursive: true).whereType<File>();`, however, this code will fail if some directory cannot be read due to lack of permissions. This method on the other hand, won't.

```dart
var dir = Directory('some/path');
Stream<File> files = dir.listDirectoryFiles(
    onDirectoryReadError: (Directory directory, Object error) {
        // Handle directory read errors.
    },
);
```

## Duration

### toReadable

```dart
String toReadable({
    bool millisecondsAsDecimal = false,
});
```

Converts the duration to a readable string format.

The output is the representation of the closest greatest unit of time
in the duration along with the second greatest unit.

Examples:
```dart
Duration(days: 1, hours: 3, minutes: 23, seconds: 5, milliseconds: 101).toReadable(); // '1d 3h'
Duration(hours: 3, minutes: 23, seconds: 5, milliseconds: 101).toReadable(); // '3h 23min'
Duration(minutes: 23, seconds: 5, milliseconds: 101).toReadable(); // '23min 5s'
Duration(seconds: 5).toReadable(); // '5s'
Duration(seconds: 5, milliseconds: 101).toReadable(); // '5s 101ms'
Duration(milliseconds: 101).toReadable(); // '101ms'
Duration.zero.toReadable(); // '0s'
```

## double

### toStringAsFixedRounded

```dart
String toStringAsFixedRounded(int places);
```

When we use `.toStringAsFixed(2)`, its possible that the resulting string has only zero in the decimal places ("3.00" for example).

This method fixes by transforming the string "3.00" in "3".

```dart
double a = 4.0;
a.toStringAsFixedRounded(2) // "4"
double b = 3.14150;
b.toStringAsFixedRounded(5); // "3.1415"
```

## File

### getName

```dart
String getName([bool includeExtension = false]);
```

Returns the name of the file, without any directory in the string.

```dart
var file = File('/root/directory/file.mp3');
file.getName(); // 'file'
file.getName(true); // 'file.mp3'
```

## int

### readableByteSize

```dart
String readableByteSize([int decimalPlaces = 1]);
```

Converts the int (assumed to be the number of bytes), to a readable string form.

```dart
500.readableByteSize(); // 500 B
1024.readableByteSize(); // 1 KB
2148.readableByteSize(); // 2.1 KB
1048576.readableByteSize(); // 1 MB
1073741824.readableByteSize(); // 1 GB
```

## Iterable

### chunk

```dart
List<Iterable<T>> chunck(int size);
```

Divides the iterable into a list of iterables each with a maximum length of [size].
If the original iterable's length is less than or equal to [size],
a single chunk containing all elements will be returned.

The method throws a [ArgumentError] if [size] is less than or equal to 0.

Example:
```dart
final numbers = [1, 2, 3, 4, 5, 6];
final chunks = numbers.chunck(2);
print(chunks); // ([1, 2], [3, 4], [5, 6])
```

### firstWhereOrNull

```dart
T? firstWhereOrNull(bool Function(T item) filter);
```

Finds the first element in the list that satisfies the given [filter] function.

Iterates through each element of the list, applying [filter] to each element.
Returns the first element for which [filter] returns true. If no element satisfies
the [filter], returns `null`.

- Parameters:
    - [filter]: A function that takes an item of type [T] as an argument and
      returns a [bool]. It should return `true` for an item that matches the
      criteria and `false` otherwise.

- Returns: The first element of type [T] that satisfies the provided [filter]
    function. Returns `null` if no element satisfies the [filter] function.

Example:
```dart
List<String> names = ['Bob', 'Alice', 'Tom'];
String? firstNameStartingWithA = names.firstWhereOrNull((name) => name.startsWith('A'));
print(firstNameStartingWithA); // Output: Alice
// If no name starts with 'A', null will be printed instead.
```

### separatedBy

```dart
List<T> separatedBy(T separator);
```

Creates a new list from the iterable by interspersing a given [separator] between each element.
If the iterable contains less than two elements, the original iterable is returned as a list.

Example:
```dart
final letters = ['a', 'b', 'c'];
final spacedLetters = letters.separatedBy('-');
print(spacedLetters); // ['a', '-', 'b', '-', 'c']
```

### pickRandom

```dart
T pickRandom();
```

Picks an item at a random index.

Example:
```dart
Iterable<String> names = ['Bob', 'Alice', 'Tom', 'Fiona'];
names.pickRandom(); // 'Bob' or 'Alice' or 'Tom' or 'Fiona'
```

### removeIndices

```dart
List<T> removeIndices(Set<int> indices);
```

Removes the items in the given indexes.

This function creates a new list and does not change the original
iterable.

Example:
```dart
Iterable<String> names = ['Bob', 'Alice', 'Tom', 'Fiona'];
Iterable<String> filtered = names.removeIndices({1,3}); // ('Bob', 'Tom')
```

## List

### prettyJSON

```dart
String get prettyJSON
```

Converts the list to a indented JSON string.

This method uses a [JsonEncoder] with an indentation of four spaces to format
the JSON string for readability.

Returns:
A string representing the JSON-encoded version of the list, formatted with indentation for easier reading.

Example:
```dart
final list = [{'name': 'John Doe', 'age': 30}, {'name': 'Jane Doe', 'age': 27}];
print(list.prettyJSON);
/*
[
    {
        "name": "John Doe",
        "age": 30
    },
    {
        "name": "Jane Doe",
        "age": 27
    }
]
*/
```

## Map<String, dynamic>

### getMaybeDateTime

```dart
DateTime? getMaybeDateTime(String key);
```

Reads a value from the Map and returns it as a DateTime, if possible.
- If the value is a DateTime, then this value is returned;
- If the value is a String, then it tries to parse it;
- If none of the criteria before is meet, null is returned.

This method is meant to simplify this code:

```dart
Map<String, dynamic> json = { ... };
String? isoString = json['timestamp'];
DateTime? dt = null;
if (isoString != null) {
  dt = DateTime.tryParse(isoString);
}
```

Which becomes more simpler:
```dart
Map<String, dynamic> json = { ... };
DateTime? dt = json.getMaybeDateTime('timestamp')
```

### getDateTime

```dart
DateTime getDateTime(String key);
```

Reads the value from the given key, and process it to returns a DateTime.
- If the value is a DateTime, then this value is returned;
- If the value is a String, then it tries to parse it;
- If none of the criteria before is meet, a FormatException is thrown.

This method is meant to simplify this code:

```dart
Map<String, dynamic> json = { ... };
dynamic isoString = json['timestamp'];
DateTime dt = iso is String ? DateTime.parse(isoString) : isoString;
```

Which becomes more simpler:

```dart
Map<String, dynamic> json = { ... };
DateTime dt = json.getMaybeDateTime('timestamp')
```

### prettyJSON

```dart
String get prettyJSON
```

Returns a string in JSON format with identation.

```dart
Map<String, dynamic> map = {
    'name': 'Vinícius',
    'enabled': true,
};
map.prettyJSON
// "{
//   "name": "Vinícius",
//   "enabled": true
// }"

```



### formatToBrazilian

```dart
String formatToBrazilian();
```

Converts a number into a string in Brazilian compatible format, optionally with a thousand separator.

```dart
num a = 1234.789;
a.formatToBrazilian(); // '1234,789'
a.formatToBrazilian(useThousandSeparator: true); // '1.234,789'
```

## String

### toMaybeDate

```dart
DateTime? toMaybeDate();
```

Converts strings in ISO-8601 or DD/MM/(YYYY|YY)[ HH:mm] formats to a DateTime object.
The returned DateTime object does not take hours, minutes, or seconds into account.

Returns `null` if the string cannot be parsed into a valid date.
```dart
String isoDateString = "2022-01-01";
String brDateString = "01/01/2022";
print(isoDateString.toMaybeDate()); // Outputs: 2022-01-01 00:00:00.000
print(brDateString.toMaybeDate()); // Outputs: 2022-01-01 00:00:00.000
```

### insertAt

```dart
String insertAt(int i, String value);
```

Inserts a given string [value] into the current string at the specified index [i].

Returns a new string with the value inserted.

```dart
String originalString = "HelloWorld";
print(originalString.insertAt(5, " ")); // Outputs: "Hello World"
```

### isEmail

```dart
bool get isEmail;
```

Checks if the current string is a valid email address.


Returns `true` if the string matches the email pattern, otherwise `false`.


```dart
String email = "example@example.com";
String nonEmail = "notAnEmail";
print(email.isEmail); // Outputs: true
print(nonEmail.isEmail); // Outputs: false
```

### hasUpperCase

```dart
bool get hasUpperCase;
```

Checks if the string contains at least one uppercase letter.

This getter considers not only English uppercase letters but also
uppercase accented letters commonly used in the Brazilian Portuguese
language, such as Á, À, Â, Ã, É, Ê, Í, Ó, Ô, Õ, Ú, and Ç.

Example:
```dart
String text1 = 'Hello world';
print(text1.hasUpperCase); // Output: true

String text2 = 'hello world';
print(text2.hasUpperCase); // Output: false
```

### hasLowerCase

```dart
bool get hasLowerCase;
```

Checks if the string contains at least one lowercase letter.

This getter considers not only English lowercase letters but also
lowercase accented letters commonly used in the Brazilian Portuguese
language, such as á, à, â, ã, é, ê, í, ó, ô, õ, ú, and ç.

Example:
```dart
String text1 = 'Hello world';
print(text1.hasLowerCase); // Output: true
///
String text2 = 'HELLO WORLD';
print(text2.hasLowerCase); // Output: false
```

### hasNumber

```dart
bool get hasNumber;
```

Checks if the string contains at least one digit.

Example:
```dart
String text1 = 'Hello123';
print(text1.hasNumber); // Output: true

String text2 = 'Hello';
print(text2.hasNumber); // Output: false
```

### hasSymbol

```dart
bool get hasSymbol;
```

Checks if the string contains at least one special symbol.

This getter looks for common special symbols such as !, @, #, $, %, ^,
&, *, (, ), ,, ., ?, ", :, {, }, |, <, and >.

Example:
```dart
String text1 = 'Hello@World';
print(text1.hasSymbol); // Output: true

String text2 = 'HelloWorld';
print(text2.hasSymbol); // Output: false
```

### hasLengthBetween

```dart
bool hasLengthBetween(int min, int max)
```

Checks if the length of the string is between the specified minimum and
maximum values, inclusive.

Parameters:
- `min`: The minimum length of the string.
- `max`: The maximum length of the string.

Returns `true` if the length of the string is within the specified range,
otherwise returns `false`.

Example:
```dart
String text = 'Hello';
print(text.hasLengthBetween(3, 6)); // Output: true

print(text.hasLengthBetween(6, 10)); // Output: false
```

### getInitials

```dart
String getInitials({
    int initialsCount = 2,
    String joinString = '',
});
```

Returns the initials of each word of a string.


This function takes a string and returns its initials, up to a specified
number of initials. By default, it returns the first two initials without
any separator.


Examples:
```dart
var name = 'John Doe';
print(name.getInitials()); // 'JD'
print(name.getInitials(initialsCount: 1)); // 'J'
print(name.getInitials(joinString: '.')); // 'J.D'
```

Parameters:
- `initialsCount` (int): The maximum number of initials to return.
    Defaults to 2.
- `joinString` (String): The string to use to join the initials.
    Defaults to '' (no separator).


Returns:
A string containing the initials.

### tryParseFromBrazillianFormat

```dart
double? tryParseFromBrazillianFormat();
```

Attempts to parse the current string as a double, assuming Brazilian number format (comma for decimal separator).


Returns the parsed double if successful, otherwise `null`.


```dart
String brNumber = "1.234,56";
print(brNumber.tryParseFromBrazillianFormat()); // Outputs: 1234.56
```