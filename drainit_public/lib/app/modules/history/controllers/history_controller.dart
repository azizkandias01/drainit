import 'package:drainit_flutter/app/modules/history/models/history_model.dart';
import 'package:drainit_flutter/app/modules/history/providers/history_provider.dart';
import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

///controller for handling history
class HistoryController extends GetxController
    with StateMixin, GetSingleTickerProviderStateMixin {
  ///list of history that user has reported to system
  late List<HistoryModel> historyList;
  late List<HistoryModel> list;
  late GetStorage box;
  late Animation<double> animation;
  late AnimationController animationController;

  @override
  void onInit() {
    super.onInit();
    box = GetStorage();
    historyList = [];
    list = [];
    change(null, status: RxStatus.empty());
    loadHistory();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );
    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: animationController);
    animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
  }

  ///load the history from api
  Future<void> loadHistory() async {
    change(null, status: RxStatus.loading());
    await HistoryProvider().loadHistory(box.read(Routes.TOKEN) as String).then(
      (value) => {
        list = value,
        change(value, status: RxStatus.success()),
      },
      onError: (err) {
        change(err, status: RxStatus.error());
      },
    );
  }
}
