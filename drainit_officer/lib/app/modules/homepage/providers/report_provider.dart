import 'package:drainit_petugas/app/modules/homepage/models/report_model.dart';
import 'package:drainit_petugas/app/routes/app_pages.dart';
import 'package:get/get.dart';

class HomepageProvider extends GetConnect {
  Future<List<ReportModel>> getLaporan(String bearer) async {
    final response = await get(Routes.BASEURL + 'pengaduan_by_petugas',
        headers: {'Authorization': 'Bearer $bearer'});
    if (response.status.hasError) {
      return Future.error(response.statusCode.toString());
    } else {
      final dataRaw = (response.body as List)
          .map(
            (e) => ReportModel.fromJson(e as Map<String, dynamic>),
          )
          .toList();
      return dataRaw;
    }
  }
}
