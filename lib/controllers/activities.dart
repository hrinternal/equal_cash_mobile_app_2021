
import 'package:equal_cash/api/repository.dart';
import 'package:equal_cash/models/api/user_activities.dart';
import 'package:get/get.dart';

class ActivityController extends GetxController {
  late UserActivities activities = UserActivities();

  ActivityController(String userId, {bool? limit}) {
    print("user id controller is $userId");

    if (limit == null || limit)
      getUserActivitiesLimit(userId);
    else
      getUserActivities(userId);
  }

  void getUserActivitiesLimit(String userId) async {
    var userActivities = await ApiRepository().getUserActivitiesLimit(userId);
    if (userActivities != null) {
      activities = userActivities;
      update();
    } else {
      activities = UserActivities(
          response: ActResponseBean(status: 0, message: "", data: []));
    }
  }

  void getUserActivities(String userId) async {
    var userActivities = await ApiRepository().getUserActivities(userId);
    if (userActivities != null) {
      activities = userActivities;
      update();
    } else {
      activities = UserActivities(
          response: ActResponseBean(status: 0, message: "", data: []));
    }
  }
}

class Activity2Controller extends GetxController {
  late Rx<UserActivities> activities = UserActivities().obs;

  Activity2Controller(String userId) {
    print("user id controller is $userId");

    getUserActivities(userId);
  }

  void getUserActivities(String userId) async {
    var userActivities = await ApiRepository().getUserActivities(userId);
    if (userActivities != null) {
      activities.value = userActivities;
      update();
    } else {
      activities.value = UserActivities(
          response: ActResponseBean(status: 0, message: "", data: []));
    }
  }
}
