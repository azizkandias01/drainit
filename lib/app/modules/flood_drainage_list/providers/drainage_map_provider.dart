import 'package:get/get.dart';

import '../models/drainage_map.dart';

class DrainageMapProvider extends GetConnect {
  Future loadMapDrainage() async {
    final response = await get(
      "https://gis-drainase.pocari.id/api/drainase",
    );
    if (response.status.hasError) {
      return Future.error(response.statusText.toString());
    } else {
      // print(response.body);
      var dataRaw = (response.body as List)
          .map(
            (e) => DrainageMap.fromJson(e),
          )
          .toList();
      return dataRaw;
    }
  }
}
