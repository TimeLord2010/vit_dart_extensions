# VIT dart extensions

A Dart package providing a wide range of extension methods for various data types including int, String, DateTime, and Map. The package is designed to offer practical, easy-to-use enhancements that seamlessly integrate with your existing Dart code, facilitating more concise and readable syntax.

## Extensions

### DateTime

#### formartAsReadable

```dart
final dt = DateTime(2023, 1, 30, 13, 22);
String dateAndTime = dt.formatAsReadable(); // "30/01/2023 13:22"
String dateOnly = dt.formatAsReadable(false); // "30/01/2023"
```

### Directory

#### listDirectoryFiles

This method is equivalent to `dir.listSync(recursive: true).whereType<File>();`, however, this code will fail if some directory cannot be read due to lack of permissions. This method on the other hand won't fail.

```dart
var dir = Directory('some/path');
Stream<File> files = dir.listDirectoryFiles();
```