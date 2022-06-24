import 'package:drainit_petugas/app/modules/done_reports/models/report_model.dart';
import 'package:drainit_petugas/app/modules/done_reports/providers/done_reports_provider.dart';
import 'package:get/get.dart';

class DoneReportsController extends GetxController with StateMixin {
  List<Report> list = [];

  @override
  void onInit() {
    super.onInit();
    change(null, status: RxStatus.empty());
    loadReports();
  }

  ///load the history from api
  Future<void> loadReports() async {
    change(null, status: RxStatus.loading());
    await ReportProvider().reportList().then(
      (value) => {
        list = value,
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
