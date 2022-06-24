import 'package:drainit_petugas/app/modules/done_reports/models/report_model.dart';
import 'package:drainit_petugas/app/modules/done_reports/providers/done_reports_provider.dart';
import 'package:get/get.dart';

class ProcessedReportsController extends GetxController with StateMixin {
  late List<Report> list;

  @override
  void onInit() {
    super.onInit();
    list = [];
    change(null, status: RxStatus.empty());
    reportProcessed();
  }

  ///load the history from api
  Future<void> reportProcessed() async {
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
}
