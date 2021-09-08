import 'package:get/get.dart';

import '../models/flood_model.dart';

class FloodModelProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return FloodModel.fromJson(map);
      if (map is List)
        return map.map((item) => FloodModel.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future loadFloodPoint() async {
    final response = await get(
      "https://gis-drainase.pocari.id/api/titik_banjir",
    );
    if (response.status.hasError) {
      return Future.error(response.statusText.toString());
    } else {
      print(response.body);
      var dataRaw = (response.body as List)
          .map(
            (e) => FloodModel.fromJson(e),
          )
          .toList();
      return dataRaw;
    }
  }
}
