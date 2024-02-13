import 'package:vit_dart_extensions/vit_dart_extensions.dart';

void main() async {
  // Date extensions
  final dt = DateTime(2022, 1, 30);
  final timeOnly = dt.formatAsReadable(false);
  print('Time: $timeOnly');
}
