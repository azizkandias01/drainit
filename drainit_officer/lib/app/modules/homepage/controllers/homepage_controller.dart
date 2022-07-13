import 'package:drainit_petugas/app/modules/homepage/models/report_model.dart';
import 'package:drainit_petugas/app/modules/homepage/providers/report_provider.dart';
import 'package:drainit_petugas/app/modules/maps/controllers/maps_controller.dart';
import 'package:drainit_petugas/app/modules/profile/controllers/profile_controller.dart';
import 'package:drainit_petugas/app/routes/app_pages.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomepageController extends GetxController with StateMixin {
  GetStorage box = GetStorage();
  List<ReportModel> allTimelineList = <ReportModel>[];
  final mapC = Get.put(MapsController());
  final profileC = Get.put(ProfileController());

  @override
  void onInit() async {
    super.onInit();
    FlutterNativeSplash.remove();
    change(null, status: RxStatus.empty());
    await loadAllTimeline();
  }

  Future<void> loadAllTimeline() async {
    change(null, status: RxStatus.loading());
    await HomepageProvider().getLaporan(box.read(Routes.TOKEN)).then(
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
