import 'package:intl/intl.dart';

class DateTimeHelper {
  static String toDDMMYY(int time) {
    DateTime dt = DateTime.fromMillisecondsSinceEpoch(time);

    DateFormat df = DateFormat('dd MMM yy');

    return df.format(dt);
  }

 static String toMMMDDHHMM(int time) {
    DateTime dt = DateTime.fromMillisecondsSinceEpoch(time);

    DateFormat df = DateFormat('MMM dd, hh:mm a');

    return df.format(dt);
  }
}
