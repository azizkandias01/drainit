import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:get/get_connect/connect.dart';

class EditPasswordProvider extends GetConnect {
  Future<String> editPassword(Map data, String bearer) async {
    final headers = {'Authorization': "Bearer $bearer"};
    final response = await put(
      '${Routes.BASEURL}change-password/masyarakat',
      data,
      headers: headers,
    );
    if (response.status.hasError) {
      return Future.error(response.bodyString.toString());
    } else {
      return '${response.statusText}';
    }
  }
}
