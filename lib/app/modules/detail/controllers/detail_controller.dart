import 'package:drainit_flutter/app/modules/detail/models/detail_model.dart';
import 'package:drainit_flutter/app/modules/detail/providers/detail_provider.dart';
import 'package:get/get.dart';

class DetailController extends GetxController with StateMixin {
  late Detail detail;
  @override
  void onInit() {
    super.onInit();
    detail = Detail();
    change(null, status: RxStatus.empty());
    getDetail();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void getDetail() {
    change(null, status: RxStatus.loading());

    DetailProvider().getDetail(Get.arguments.toString()).then(
      (value) => {
        change(value, status: RxStatus.success()),
        detail = value!,
      },
      onError: (err) {
        change(err, status: RxStatus.error());
      },
    );
  }

  @override
  void onClose() {}
}
