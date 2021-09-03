import 'package:equal_cash/api/repository.dart';
import 'package:equal_cash/models/api/notifications.dart';
import 'package:equal_cash/pref.dart';
import 'package:get/get.dart';

class AlertController extends GetxController {

  var notifications = NotificationResponse().obs;

  AlertController(String userId) {
    getNotifications(userId);
  }

  getNotifications(String userId) async {
    var list = await ApiRepository().getUserNotifications(userId);
    if (list != null) {
      notifications.value = list;
      update();
    } else {
      notifications.value = NotificationResponse(response: ResponseBean(status:0,message: "",data: []));
    }
  }
}
