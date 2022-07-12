import 'package:drainit_flutter/app/modules/homepage/models/timeline_model.dart';
import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:get/get_connect/connect.dart';

class HomepageAnonProvider extends GetConnect {
  Future<List<Timeline>> loadAllimeline() async {
    final response = await get(
      '${Routes.BASEURL_SYSTEM}pengaduan',
    ).timeout(const Duration(seconds: 10));

    if (response.status.hasError) {
      print(response.bodyString.toString());
      return Future.error(response.statusText.toString());
    } else {
      final dataRaw = (response.body as List)
          .map(
            (e) => Timeline.fromJson(e as Map<String, dynamic>),
          )
          .toList();
      return dataRaw;
    }
  }
}
