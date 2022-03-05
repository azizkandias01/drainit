import 'package:drainit_flutter/app/modules/history/models/history_model.dart';
import 'package:drainit_flutter/app/modules/history/providers/history_provider.dart';
import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

///controller for handling history
class HistoryController extends GetxController with StateMixin {
  ///list of history that user has reported to system
  late List<HistoryModel> historyList;
  late GetStorage box;

  @override
  void onInit() {
    super.onInit();
    box = GetStorage();
    historyList = [];
    change(null, status: RxStatus.empty());
    loadHistory();
  }

  ///load the history from api
  Future<void> loadHistory() async {
    change(null, status: RxStatus.loading());
    await HistoryProvider().loadHistory(box.read(Routes.TOKEN) as String).then(
      (value) => {
        historyList = value,
        change(value, status: RxStatus.success()),
      },
      onError: (err) {
        change(err, status: RxStatus.error());
      },
    );
  }
}
