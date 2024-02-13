# VIT dart extensions

A Dart package providing a wide range of extension methods for various data types including int, String, DateTime, and Map. The package is designed to offer practical, easy-to-use enhancements that seamlessly integrate with your existing Dart code, facilitating more concise and readable syntax.

## Extensions

### DateTime

#### formartAsReadable

```dart
String formatAsReadable([bool showTime = true]);
```

```dart
final dt = DateTime(2023, 1, 30, 13, 22);
String dateAndTime = dt.formatAsReadable(); // "30/01/2023 13:22"
String dateOnly = dt.formatAsReadable(false); // "30/01/2023"
```

### Directory

#### listDirectoryFiles

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

### double

#### toStringAsFixedRounded

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

### File

#### getName

```dart
String getName([bool includeExtension = false]);
```

Returns the name of the file, without any directory in the string.

```dart
var file = File('/root/directory/file.mp3');
file.getName(); // 'file'
file.getName(true); // 'file.mp3'
```

### int

#### readableByteSize

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

### List

#### prettyJSON

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

### Map<String, dynamic>

#### getMaybeDateTime

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

#### getDateTime

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

#### prettyJSON

```dart
String get prettyJSON
```

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

### num

#### formatToBrazilian

```dart
String formatToBrazilian();
```

Converts a number into a string in Brazilian compatible format, optionally with a thousand separator.

```dart
num a = 1234.789;
a.formatToBrazilian(); // '1234,789'
a.formatToBrazilian(useThousandSeparator: true); // '1.234,789'
```