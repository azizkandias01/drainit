import 'package:get/get.dart';

import '../models/drainage_model.dart';

class DrainageProvider extends GetConnect {
  Future loadDrainagePoint() async {
    final response = await get(
      'https://gis-drainase.pocari.id/api/titik_tersumbat',
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
