import 'package:drainit_flutter/app/modules/detail/models/update_report_model.dart';
import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:get/get.dart';

class UpdateReportProvider extends GetConnect {
  Future<List<UpdateReport>> getUpdateReport(String id) async {
    final response = await get(
      '${Routes.BASEURL}pembaruan_pengaduan/$id',
    ).timeout(const Duration(seconds: 10));

    if (response.status.hasError) {
      return Future.error(response.statusText.toString());
    } else {
      final dataRaw = (response.body as List)
          .map(
            (e) => UpdateReport.fromJson(e as Map<String, dynamic>),
          )
          .toList();
      return dataRaw;
    }
  }
}
