import 'package:drainit_petugas/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../models/report_model.dart';

class ReportProvider extends GetConnect {

  static const String url = Routes.BASEURL;

  Future<List<Report>> reportList() async {
    final response = await get(url+'pengaduan');
    if (response.status.hasError) {
      return Future.error(response.statusCode.toString());
    } else {
      final dataRaw = (response.body as List)
          .map(
            (e) => Report.fromJson(e as Map<String, dynamic>),
      )
          .toList();
      return dataRaw;
    }
  }
}
