import 'package:equal_cash/api/repository.dart';
import 'package:equal_cash/models/api/notifications.dart';
import 'package:equal_cash/pref.dart';
import 'package:get/get.dart';

class AlertController extends GetxController {
  var notifications = Map<String, List<DataBean>>().obs;

  AlertController(String userId) {
    getNotifications(userId);
  }

  getNotifications(String userId) async {
    var list = await ApiRepository().getUserNotifications(userId);
    notifications.value = list;
  }
}
