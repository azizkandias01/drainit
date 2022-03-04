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
      'https://gis-drainase.pocari.id/api/drainase',
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
