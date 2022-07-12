import 'package:drainit_flutter/app/modules/detail/models/update_report_model.dart';
import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:get/get.dart';

class UpdateReportProvider extends GetConnect {
  Future<List<UpdateReport>> getUpdateReport(String id, String bearer) async {
    final headers = {
      'Authorization': 'Bearer $bearer',
    };
    final response = await get(
      '${Routes.BASEURL_SYSTEM}pembaruan_pengaduan/$id',
      headers: headers,
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

  Future<String> masyarakatFeedback(
    Map data,
    String bearer,
    String idPengaduan,
  ) async {
    final headers = {
      'Authorization': 'Bearer $bearer',
    };
    final response = await put(
      '${Routes.BASEURL_SYSTEM}pengaduan/feedback/$idPengaduan',
      data,
      headers: headers,
    ).timeout(const Duration(seconds: 10));

    if (response.status.hasError) {
      print(response.bodyString.toString());
      return Future.error(response.statusText.toString());
    } else {
      print(response.bodyString.toString());
      return Future.value(response.body.toString());
    }
  }
}
