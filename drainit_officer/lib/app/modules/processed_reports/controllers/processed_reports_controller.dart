import 'package:drainit_petugas/app/modules/done_reports/controllers/done_reports_controller.dart';
import 'package:get/get.dart';

class ProcessedReportsController extends GetxController {
  final doneC = Get.find<DoneReportsController>();
  get reportProcessed => doneC.list
      .where((element) => element.statusPengaduan == 'ON_PROGRESS')
      .toList();
}
