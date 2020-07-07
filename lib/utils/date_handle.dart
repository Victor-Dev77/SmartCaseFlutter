import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:jiffy/jiffy.dart';

class DateHandle extends GetxController {
  static DateHandle get to => Get.find();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _initLocale();
  }

  _initLocale() async {
    await Jiffy.locale("fr");
  }

  String parseDateTime(DateTime date, String regex) {
    return Jiffy(date).format(regex);
  }

  DateTime parseDateString(String date, String regex) {
    return Jiffy(date, regex).dateTime; //.utc();
  }

  String parseUnix(int unix, String regex) {
    return Jiffy.unix(unix).format(regex);
  }

  int differenceBWDateString(String date1, String date2, String regex) {
    return Jiffy(date1, regex).diff(Jiffy(date2, regex));
  }
}
