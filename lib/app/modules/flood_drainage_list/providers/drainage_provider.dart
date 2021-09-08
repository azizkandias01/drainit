import 'package:get/get.dart';

import '../models/drainage_model.dart';

class DrainageProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Drainage.fromJson(map);
      if (map is List)
        return map.map((item) => Drainage.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future loadDrainagePoint() async {
    final response = await get(
      "https://gis-drainase.pocari.id/api/titik_tersumbat",
    );
    if (response.status.hasError) {
      return Future.error(response.statusText.toString());
    } else {
      print(response.body);
      var dataRaw = (response.body as List)
          .map(
            (e) => Drainage.fromJson(e),
          )
          .toList();
      return dataRaw;
    }
  }
}
