import 'package:drainit_petugas/app/modules/homepage/models/report_model.dart';
import 'package:drainit_petugas/app/modules/homepage/providers/report_provider.dart';
import 'package:drainit_petugas/app/routes/app_pages.dart';
import 'package:drainit_petugas/app/utils/constant.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProcessedReportsController extends GetxController with StateMixin {
  List<ReportModel> list = <ReportModel>[];
  GetStorage box = GetStorage();
  @override
  void onInit() async {
    super.onInit();
    change(null, status: RxStatus.empty());
    await reportProcessed();
  }

  ///load the history from api
  Future<void> reportProcessed() async {
    change(null, status: RxStatus.loading());
    await HomepageProvider().getLaporan(box.read(Routes.TOKEN)).then(
      (value) => {
        list = value,
        list = list.where((element) => element.status == onProgress).toList(),
        change(value, status: RxStatus.success()),
      },
      onError: (err) {
        change(err, status: RxStatus.error());
      },
    );
  }
}
