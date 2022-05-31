import 'package:drainit_flutter/app/modules/flood_drainage_list/models/drainage_map.dart';
import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:get/get.dart';

class DrainageMapProvider extends GetConnect {
  @override
  void onInit() {
    super.onInit();
    httpClient.timeout = const Duration(minutes: 1);
    httpClient.maxAuthRetries = 3;
  }

  Future loadMapDrainage() async {
    final response = await get(
      '${Routes.BASEURL}drainase',
    );
    if (response.status.hasError) {
      return Future.error(response.statusText.toString());
    } else {
      // print(response.body);
      final dataRaw = (response.body as List)
          .map(
            (e) => DrainageMap.fromJson(e as Map<String, dynamic>),
          )
          .toList();
      return dataRaw;
    }
  }
}
