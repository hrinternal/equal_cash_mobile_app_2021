import 'package:equal_cash/api/repository.dart';
import 'package:equal_cash/models/api/request.dart';
import 'package:get/get.dart';

class RequestController extends GetxController {
  var requests = UserRequestResponse().obs;

  RequestController(String userId) {
    getRequest(userId);
  }

  getRequest(String userId) async {
    var list = await ApiRepository().getUserRequest(userId);
    if (list != null) {
      requests.value = list;
      update();
    } else {
      requests.value = UserRequestResponse(
          response: UserRequestResponseBean(status: 0, message: "", data: []));
    }
  }
}
