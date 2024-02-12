import 'package:intl/intl.dart';

final brNumberFormat = NumberFormat('0.0', 'pt_BR');

extension DoubleBRExtension on num {

  String formatToBrazillian() {
    return brNumberFormat.format(this);
  }
}
