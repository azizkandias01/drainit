import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../models/flood_model.dart';

class FloodModelProvider extends GetConnect {
  Future loadFloodPoint() async {
    final response = await get(
      '${Routes.BASEURL}titik_banjir',
    );
    if (response.status.hasError) {
      return Future.error(response.statusText.toString());
    } else {
      //print(response.body);
      final dataRaw = (response.body as List)
          .map(
            (e) => FloodModel.fromJson(e as Map<String, dynamic>),
          )
          .toList();
      return dataRaw;
    }
  }
}
