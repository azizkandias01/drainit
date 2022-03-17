import 'package:drainit_flutter/app/modules/history/models/history_model.dart';
import 'package:get/get.dart';

class HistoryProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<List<HistoryModel>> loadHistory(String token) async {
    final header = {'Authorization': 'Bearer $token'};

    final response = await get(
      'https://gis-drainase.pocari.id/api/pengaduan_by_masyarakat',
      headers: header,
    ).timeout(const Duration(seconds: 10));

    if (response.status.hasError) {
      return Future.error(response.statusText.toString());
    } else {
      // print(response.body);
      final dataRaw = (response.body as List)
          .map(
            (e) => HistoryModel.fromJson(e as Map<String, dynamic>),
          )
          .toList();
      return dataRaw;
    }
  }
}
