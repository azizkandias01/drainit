import 'package:drainit_petugas/app/modules/processed_reports/models/processed_report_model.dart';
import 'package:drainit_petugas/app/routes/app_pages.dart';
import 'package:get/get.dart';

class ProcessedProvider extends GetConnect {
  Future<List<ProcessedReport>> reportList() async {
    final response = await get(Routes.BASEURL + 'pengaduan');
    if (response.status.hasError) {
      return Future.error(response.statusCode.toString());
    } else {
      final dataRaw = (response.body as List)
          .map(
            (e) => ProcessedReport.fromJson(e as Map<String, dynamic>),
          )
          .toList();
      return dataRaw;
    }
  }
}
