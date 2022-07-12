import 'package:drainit_flutter/app/modules/reports/report_model.dart';
import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:get/get.dart';

class ReportsProvider extends GetConnect {
  Future<Report> createFloodReport(Map data, String auth) async {
    final response = await post(
      '${Routes.BASEURL_SYSTEM}pengaduan/banjir',
      data,
      headers: {
        'Authorization': 'Bearer $auth',
      },
    ).timeout(const Duration(seconds: 10));
    if (response.status.hasError) {
      return Future.error(response.bodyString!);
    } else {
      print("ok laporan banjir");
      return Report.fromJson(response.body as Map<String, dynamic>);
    }
  }

  Future<Report> createBrokenDrainageReport(Map data, String auth) async {
    final response = await post(
      '${Routes.BASEURL_SYSTEM}pengaduan/drainase_rusak',
      data,
      headers: {
        'Authorization': 'Bearer $auth',
      },
    ).timeout(const Duration(seconds: 10));
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return Report.fromJson(response.body as Map<String, dynamic>);
    }
  }
}
