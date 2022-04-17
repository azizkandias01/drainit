import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ReportsProvider extends GetConnect {
  GetStorage box = GetStorage();

  Future<String> createReport(Map data, String auth) async {
    final response = await post(
      '${Routes.BASEURL}pengaduan',
      data,
      headers: {
        'Accept': 'application/geo+json',
        'Authorization': 'Bearer $auth',
      },
    ).timeout(const Duration(seconds: 10));
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return 'success report';
    }
  }
}
