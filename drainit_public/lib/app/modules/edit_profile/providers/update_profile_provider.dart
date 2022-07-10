import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:get/get_connect/connect.dart';

class UpdateProvider extends GetConnect {
  Future<String> editProfile(Map data, String bearer) async {
    final headers = {'Authorization': "Bearer $bearer"};
    final response = await put(
      '${Routes.BASEURL}masyarakat',
      data,
      headers: headers,
    );
    if (response.status.hasError) {
      return Future.error(response.bodyString.toString());
    } else {
      print(response.body);
      return 'success edit profile';
    }
  }
}
