import 'package:intl/intl.dart';

// Updated to allow dynamic pattern selection
extension NumBRExtension on num {
  /// Converts a number into a string in Brazilian compatible format,
  /// optionally with a thousand separator.
  String formatToBrazilian({bool useThousandSeparator = false}) {
    var pattern = useThousandSeparator ? '#,##0.###' : '0.###';
    final format = NumberFormat(pattern, 'pt_BR');
    return format.format(this);
  }
}
