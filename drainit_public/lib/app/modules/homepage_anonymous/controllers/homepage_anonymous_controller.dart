import 'package:drainit_flutter/app/components/constant.dart';
import 'package:drainit_flutter/app/modules/homepage/controllers/homepage_controller.dart';
import 'package:drainit_flutter/app/modules/homepage/models/timeline_model.dart';
import 'package:drainit_flutter/app/modules/homepage/providers/timeline_provider.dart';
import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:drainit_flutter/app/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomepageAnonymousController extends GetxController with StateMixin {
  GetStorage box = GetStorage();
  List<Timeline> timelineList = <Timeline>[].obs;
  List<Timeline> allTimelineList = <Timeline>[].obs;

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
    loadTimeline();
    loadAllTimeline();
    getPosition();
  }

  Future<void> loadTimeline() async {
    change(null, status: RxStatus.loading());
    await TimelineProvider()
        .loadTimeline(box.read(Routes.TOKEN) as String)
        .then(
      (value) => {
        timelineList = value,
        change(null, status: RxStatus.success()),
      },
      onError: (err) {
        change(err, status: RxStatus.error());
      },
    );
  }

  Future<void> loadAllTimeline() async {
    change(null, status: RxStatus.loading());
    await TimelineProvider()
        .loadAllimeline(
      box.read(Routes.TOKEN) as String,
      box.read(Routes.USER_ID) as String,
    )
        .then(
      (value) => {
        allTimelineList = value,
        change(null, status: RxStatus.success()),
      },
      onError: (err) {
        change(err, status: RxStatus.error());
      },
    );
  }
}
