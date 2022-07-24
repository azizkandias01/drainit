import 'package:drainit_petugas/app/modules/homepage/models/add_device_model.dart';
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

  Future<addDeviceResponse> addDevice(Map data, String bearer) async {
    final headers = {'Authorization': 'Bearer $bearer'};
    final response = await post(
      '${Routes.BASEURL}add-device/petugas',
      data,
      headers: headers,
    ).timeout(const Duration(seconds: 10));

    if (response.hasError) {
      return Future.error(response.bodyString.toString());
    } else {
      return addDeviceResponse.fromJson(response.body);
    }
  }

  Future<String> deleteDevice(String id, String bearer) async {
    final headers = {'Authorization': 'Bearer $bearer'};
    final response = await delete(
      '${Routes.BASEURL}delete-device/$id',
      headers: headers,
    ).timeout(const Duration(seconds: 10));

    if (response.hasError) {
      return Future.error(response.bodyString.toString());
    } else {
      print(response.bodyString);
      return "success";
    }
  }
}
