import 'dart:io';

extension DirectoryExtension on Directory {
  Stream<File> listDirectoryFiles({
    void Function(Directory directory, Object e)? onDirectoryReadError,
  }) async* {
    yield* _listDirectoryFiles(
      this,
      onDirectoryReadError: onDirectoryReadError,
    );
  }
}

Stream<File> _listDirectoryFiles(
  Directory dir, {
  void Function(Directory directory, Object e)? onDirectoryReadError,
}) async* {
  try {
    var entities = dir.listSync();
    for (var fse in entities) {
      if (fse is File) {
        yield fse;
      } else if (fse is Directory) {
        yield* _listDirectoryFiles(
          fse,
          onDirectoryReadError: onDirectoryReadError,
        );
      }
    }
  } catch (e) {
    onDirectoryReadError?.call(dir, e);
  }
}
