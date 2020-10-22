import 'package:intl/intl.dart';

class DateUtil {
  static String printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  static String formatPadraoDate(int milliseconds) {
    DateFormat formatterData = new DateFormat.yMd(Intl.defaultLocale);
    DateFormat formatterHora = new DateFormat.Hms(Intl.defaultLocale);

    return DateUtil.formatDate(milliseconds, formatterData, formatterHora);
  }

  static String formatDate(
    int milliseconds,
    DateFormat formatterData,
    DateFormat formatterHora,
  ) {
    // final DateFormat formatter = DateFormat(padrao);
    return formatterData
            .format(DateTime.fromMillisecondsSinceEpoch(milliseconds)) +
        ' ' +
        formatterHora.format(DateTime.fromMillisecondsSinceEpoch(milliseconds));
  }
}
