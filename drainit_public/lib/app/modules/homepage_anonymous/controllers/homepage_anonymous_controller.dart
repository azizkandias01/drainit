import 'package:drainit_flutter/app/components/constant.dart';
import 'package:drainit_flutter/app/modules/flood_drainage_list/controllers/flood_drainage_list_controller.dart';
import 'package:drainit_flutter/app/modules/homepage/controllers/homepage_controller.dart';
import 'package:drainit_flutter/app/modules/homepage/models/timeline_model.dart';
import 'package:drainit_flutter/app/modules/homepage_anonymous/providers/homepage_anonymous_provider.dart';
import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:drainit_flutter/app/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomepageAnonymousController extends GetxController with StateMixin {
  GetStorage box = GetStorage();
  List<Timeline> allTimelineList = <Timeline>[].obs;
  final floodListC = Get.find<FloodDrainageListController>();

  //TODO : load timeline from server for anonymous user error
  final dataButton = [
    HomeButtonCustom(
      Routes.REPORTS,
      Icons.file_copy_rounded,
      text: "Buat laporan",
      color: [const Color(0xFFFFCA03), primary],
    ),
    HomeButtonCustom(
      Routes.FLOOD_DRAINAGE_LIST,
      Icons.map_rounded,
      text: "Peta titik",
      color: [primaryVariant, primary],
    ),
  ];
  @override
  Future<void> onInit() async {
    super.onInit();
    //remove the splash screen
    change(null, status: RxStatus.empty());
    loadAllTimeline();
    getPosition();
  }

  Future<void> loadAllTimeline() async {
    change(null, status: RxStatus.loading());
    await HomepageAnonProvider().loadAllimeline().then(
      (value) => {
        allTimelineList = value,
        allTimelineList.sort((a, b) => b.upvote!.compareTo(a.upvote!)),
        change(null, status: RxStatus.success()),
      },
      onError: (err) {
        change(err, status: RxStatus.error());
      },
    );
  }
}
