import 'package:drainit_flutter/app/modules/flood_drainage_list/models/drainage_model.dart';
import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:get/get.dart';

class DrainageProvider extends GetConnect {
  Future loadDrainagePoint() async {
    final response = await get(
      '${Routes.BASEURL_SYSTEM}titik_tersumbat',
    );
    if (response.status.hasError) {
      return Future.error(response.statusText.toString());
    } else {
      // print(response.body);
      final dataRaw = (response.body as List)
          .map(
            (e) => Drainage.fromJson(e as Map<String, dynamic>),
          )
          .toList();
      return dataRaw;
    }
  }
}
