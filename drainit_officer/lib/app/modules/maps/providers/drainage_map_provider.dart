import 'package:drainit_petugas/app/modules/maps/models/iot_model.dart';
import 'package:drainit_petugas/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../models/drainage_map.dart';

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
      final dataRaw = (response.body as List)
          .map(
            (e) => DrainageMap.fromJson(e as Map<String, dynamic>),
          )
          .toList();
      return dataRaw;
    }
  }

  Future loadIOT() async {
    final response = await get(
      '${Routes.BASEURL_SIPANSE}api',
    );
    if (response.status.hasError) {
      return Future.error(response.statusText.toString());
    } else {
      final dataRaw = IOT.fromJson(response.body as Map<String, dynamic>);
      return dataRaw;
    }
  }
}
