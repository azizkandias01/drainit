import 'package:drainit_petugas/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../models/detail_model.dart';

class DetailProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Detail.fromJson(map);
      if (map is List) return map.map((item) => Detail.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Detail?> getDetail(String id) async {
    final response = await get(Routes.BASEURL + 'pengaduan/$id');
    if (response.status.hasError) {
      return Future.error(response.statusCode.toString());
    } else {
      return Detail.fromJson(response.body);
    }
  }
}
