import 'package:equal_cash/api/repository.dart';
import 'package:equal_cash/models/api/request.dart';
import 'package:equal_cash/models/api/transaction.dart';
import 'package:get/get.dart';

class PendingTransController extends GetxController {
  var pendingRequests = OngoingTransResponse().obs;

  PendingTransController(String userId) {
    getPendingTransaction(userId);
  }
 getPendingTransaction(String userId) async {
    var list = await ApiRepository().getPendingTransaction(userId);
    if (list != null) {
      pendingRequests.value = list;
      update();
    } else {
      pendingRequests.value = OngoingTransResponse(
          response: OngoingResponseBean(status: 0, message: "", data: []));
    }
  }
}

class CompletedTransactionController extends GetxController {
  var completedRequests = OngoingTransResponse().obs;

  CompletedTransactionController(String userId) {
    getCompletedTransaction(userId);
  }

  getCompletedTransaction(String userId) async {
    var list = await ApiRepository().getCompletedTransaction(userId);
    if (list != null) {
      completedRequests.value = list;
      update();
    } else {
      completedRequests.value = OngoingTransResponse(
          response: OngoingResponseBean(status: 0, message: "", data: []));
    }
  }
}
