import 'package:intl/intl.dart';

class DateUtil {
  static String printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  static String formatPadraoDate(int milliseconds) {
    return DateUtil.formatDate(milliseconds, 'dd/MM/yyyy HH:mm:ss');
  }

  static String formatDate(int milliseconds, String padrao) {
    final DateFormat formatter = DateFormat(padrao);
    return formatter.format(DateTime.fromMillisecondsSinceEpoch(milliseconds));
  }
}
