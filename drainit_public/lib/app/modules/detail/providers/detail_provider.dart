import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../models/detail_model.dart';

class DetailProvider extends GetConnect {
  Future<Detail?> getDetail(String id) async {
    final response = await get(
      '${Routes.BASEURL}pengaduan/$id',
    );
    if (response.status.hasError) {
      return Future.error(response);
    } else {
      return Detail.fromJson(response.body as Map<String, dynamic>);
    }
  }
}
