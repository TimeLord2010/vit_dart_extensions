import 'dart:io';

extension FileExtension on File {
  /// Returns the name of the file, without any directory in the string.
  /// 
  /// ```dart
  /// var file = File('/root/directory/file.mp3');
  /// file.getName(); // 'file'
  /// file.getName(true); // 'file.mp3'
  /// ```
  String getName([bool includeExtension = false]) {
    var separator = Platform.pathSeparator;
    var fileNameWithExtension = path.split(separator).last;
    if (includeExtension) {
      return fileNameWithExtension;
    }
    var parts = fileNameWithExtension.split('.');
    parts.removeLast();
    return parts.join('.');
  }

  String? get fileExtension {
    if (!path.contains('.')) {
      return null;
    }
    var ext = path.split('.').last;
    return ext;
  }
}
