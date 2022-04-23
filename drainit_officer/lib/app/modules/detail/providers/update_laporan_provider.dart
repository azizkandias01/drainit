import 'package:drainit_petugas/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../models/update_laporan_model.dart';

class UpdateLaporanProvider extends GetConnect {
  Future<List<UpdateLaporan>> listUpdate(String id) async {
    final response = await get(Routes.BASEURL + 'pembaruan_pengaduan/$id');
    if (response.status.hasError) {
      return Future.error(response.statusCode.toString());
    } else {
      final dataRaw = (response.body as List)
          .map(
            (e) => UpdateLaporan.fromJson(e as Map<String, dynamic>),
          )
          .toList();
      return dataRaw;
    }
  }

  Future<String> updateLaporan(Map data, String auth) async {
    final response = await post(
      '${Routes.BASEURL}pembaruan_pengaduan',
      data,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    ).timeout(const Duration(seconds: 10));
    if (response.status.hasError) {
      return Future.error(response.statusCode.toString());
    } else {
      return 'Berhasil';
    }
  }

  Future<String> notificationUpdate(Map data, String auth) async {
    final response = await post(
      'https://onesignal.com/api/v1/notifications',
      data,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Basic $auth',
      },
    ).timeout(const Duration(seconds: 10));
    if (response.status.hasError) {
      return Future.error(response.statusCode.toString());
    } else {
      print(response.body);
      return 'Berhasil';
    }
  }
}
