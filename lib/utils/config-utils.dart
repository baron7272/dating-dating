import 'package:intl/intl.dart';

class ConfigUtils {
  // static String getAPI({bool domain = true}) {
    static String getAPI({bool domain = false}) {
    bool debugMode = false;
    assert(debugMode = true);

    // String developmentURL1 =  'http://192.168.8.149:8000';
    // String developmentURL1 ='https://dashboard.addyfx.com/api/v1';

    String productionURL = 'https://dashboard.addyfx.com/api/v1';

    // print('debug mode: $debugMode');
    String url ='http://192.168.8.163:8000';
    //  debugMode ? developmentURL1 : productionURL;

    if (domain) {
      return url;
    }

    return '$url/api/v1';
  }

    static String getImage({bool domain = false}) {

    // String developmentURL1 = 'http://192.241.153.127';

    // String url = developmentURL1;
    String url ='http://192.168.8.163:8000';

    if (domain) {
      return '$url/user-images';
    }

    return '$url/user-images';
  }


  static String getSocketAPI() {
    bool debugMode = false;
    assert(debugMode = true);

    String developmentURL = 'http://localhost:3000';

    String productionURL = 'https://socket.thisoks.com';

    // print('debug mode: $debugMode');
    return debugMode ? developmentURL : productionURL;
  }

  static String formatCurrency(var number) {
    if (number == null) return '0.00';
    var f = new NumberFormat("#,##0.00", "en_US");
    return 'N${f.format(double.tryParse('$number'))}';
  }
   static String formatCurrency2(var number) {
    if (number == null) return '0.00';
    var f = new NumberFormat("#,##0", "en_US");
    return 'N${f.format(double.tryParse('$number'))}';
  }

   static String formatAmount(var number) {
    if (number == null) return '0.00';
    var f = new NumberFormat("#,##0.00", "en_US");
    return '${f.format(double.tryParse('$number'))}';
  }
  static String formatAmount2(var number) {
    if (number == null) return '0.00';
    var f = new NumberFormat("#,##0.00", "en_US");
    return '${f.format(double.tryParse('$number'))}';
  }
  static String formatAmount3(var number) {
    if (number == null) return '0.00';
    var f = new NumberFormat("#,##0", "en_US");
    return '${f.format(double.tryParse('$number'))}';
  }

  static final RegExp regex =
      new RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');

  static String parseDate(String date) {
    var _b = date.split(" ")[0].split('-');
    var _date = new DateTime(
        int.tryParse(_b[0]), int.tryParse(_b[1]), int.tryParse(_b[2]));
    var formatter = new DateFormat('dd MMM, yyyy');
    return formatter.format(_date);
  }
}
