import 'package:drainit_petugas/app/modules/homepage/models/report_model.dart';
import 'package:drainit_petugas/app/modules/homepage/providers/report_provider.dart';
import 'package:drainit_petugas/app/modules/login/providers/login_provider.dart';
import 'package:drainit_petugas/app/modules/maps/controllers/maps_controller.dart';
import 'package:drainit_petugas/app/modules/profile/controllers/profile_controller.dart';
import 'package:drainit_petugas/app/routes/app_pages.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
    await refreshToken(box.read(Routes.EMAIL), box.read(Routes.PASSWORD));
    await loadAllTimeline();
    final regId = await FirebaseMessaging.instance.getToken();
    await addDevice(regId ?? "");
    print(box.read("deviceID"));
  }

  Future<void> addDevice(String deviceId) async {
    await HomepageProvider().addDevice(
      {
        "registration_id": deviceId,
      },
      box.read(Routes.TOKEN) as String,
    ).then((value) => box.write("deviceID", value.data?.id));
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

  Future<void> refreshToken(String email, String password) async {
    final dataLogin = {
      'email': email,
      'password': password,
    };
    change(null, status: RxStatus.loading());
    LoginProvider().loginPetugas(dataLogin).then(
          (resp) => {
            //if the result is ok then change the status to success and move the page to home page
            change(resp, status: RxStatus.success()),
            box.remove(Routes.TOKEN),
            box.write(Routes.TOKEN, resp.token),
            box.remove(Routes.EMAIL),
            box.write(Routes.EMAIL, email),
            box.remove(Routes.PASSWORD),
            box.write(Routes.PASSWORD, password)
          },
        );
  }
}
