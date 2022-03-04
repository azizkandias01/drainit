import 'package:get/get.dart';

import '../models/detail_model.dart';

class DetailProvider extends GetConnect {
  Future<Detail?> getDetail(String id) async {
    final response = await get(
      'https://gis-drainase.pocari.id/api/pengaduan/$id',
    );
    return Detail.fromJson(response.body as Map<String, dynamic>);
  }
}
