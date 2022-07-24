import 'package:drainit_petugas/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../models/login_model.dart';

class LoginProvider extends GetConnect {
  Future<Login> loginPetugas(Map data) async {
    final response = await post(Routes.BASEURL_USER + 'login/petugas', data);
    if (response.status.hasError) {
      return Future.error(response.statusCode.toString());
    } else {
      return Login.fromJson(response.body as Map<String, dynamic>);
    }
  }
}
