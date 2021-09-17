import 'package:drainit_flutter/app/modules/timeline/models/timeline_model.dart';
import 'package:drainit_flutter/app/modules/timeline/providers/timeline_provider.dart';
import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TimelineController extends GetxController with StateMixin {
  final count = 0.obs;
  late GetStorage box;
  late List<TimelineModel> timeline;
  late List<TimelineModelAnonymouse> timelineAnonymouse;

  @override
  void onInit() {
    super.onInit();
    box = GetStorage();
    timeline = [];
    change(null, status: RxStatus.empty());
  }

  Future loadTimeline(String type) async {
    change(null, status: RxStatus.loading());
    if (type == 'anonymouse') {
      await TimelineProvider().loadTimelineAnonymouse().then(
        (value) => {
          timelineAnonymouse = value,
          change(value, status: RxStatus.success()),
        },
        onError: (err) {
          change(err, status: RxStatus.error());
        },
      );
    } else {
      await TimelineProvider()
          .loadTimeline(
        box.read(Routes.TOKEN) as String,
      )
          .then(
        (value) => {
          timeline = value as List<TimelineModel>,
          change(value, status: RxStatus.success()),
        },
        onError: (err) {
          change(err, status: RxStatus.error());
        },
      );
    }
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
