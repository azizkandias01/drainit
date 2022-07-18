import 'package:drainit_petugas/app/modules/done_reports/models/report_model.dart';
import 'package:drainit_petugas/app/modules/done_reports/providers/done_reports_provider.dart';
import 'package:drainit_petugas/app/modules/homepage/models/report_model.dart';
import 'package:drainit_petugas/app/modules/homepage/providers/report_provider.dart';
import 'package:drainit_petugas/app/routes/app_pages.dart';
import 'package:drainit_petugas/app/utils/constant.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DoneReportsController extends GetxController with StateMixin {
  List<ReportModel> list = [];
  GetStorage box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    change(null, status: RxStatus.empty());
    loadReports();
  }

  ///load the history from api
  Future<void> loadReports() async {
    change(null, status: RxStatus.loading());
    await HomepageProvider().getLaporan(box.read(Routes.TOKEN)).then(
      (value) => {
        list = value,
        list = list.where((element) => element.status == done).toList(),
        change(value, status: RxStatus.success()),
      },
      onError: (err) {
        change(err, status: RxStatus.error());
      },
    );
  }

  Future<List<Report>> getDoneReports() async {
    return await ReportProvider().reportList();
  }
}
