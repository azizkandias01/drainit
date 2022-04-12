import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:get/get.dart';

class RegisterProvider extends GetConnect {
  Future<String> registerUser(Map data) async {
    final response = await post(
      '${Routes.BASEURL}register/masyarakat',
      data,
    );
    if (response.status.hasError) {
      return Future.error(response.statusText.toString());
    } else {
      return 'success register';
    }
  }
}
