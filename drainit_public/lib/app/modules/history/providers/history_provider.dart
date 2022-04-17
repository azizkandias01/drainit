import 'package:drainit_flutter/app/modules/history/models/history_model.dart';
import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:get/get.dart';

class HistoryProvider extends GetConnect {
  Future<List<HistoryModel>> loadHistory(String token) async {
    final header = {'Authorization': 'Bearer $token'};

    final response = await get(
      '${Routes.BASEURL}pengaduan',
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
