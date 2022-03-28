import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:drainit_flutter/app/modules/detail/models/detail_model.dart';
import 'package:drainit_flutter/app/modules/detail/providers/detail_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class DetailController extends GetxController with StateMixin {
  late Detail detail;
  @override
  void onInit() {
    super.onInit();
    detail = Detail();
    change(null, status: RxStatus.empty());
    getDetail();
    BackButtonInterceptor.add(myInterceptor);
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
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    Get.offNamedUntil(
      Routes.HOME,
      ModalRoute.withName(Routes.DETAIL),
    );
    return false;
  }
}
