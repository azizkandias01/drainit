import 'package:drainit_flutter/app/modules/profile/models/profile_model.dart';
import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:get/get.dart';

class ProfileProvider extends GetConnect {
  Future<ProfileResponse?> geProfile(String token) async {
    final header = {'Authorization': 'Bearer $token'};
    final response = await get(
      '${Routes.BASEURL}profile/masyarakat',
      headers: header,
    ).timeout(const Duration(seconds: 10));
    if (response.statusCode == 200) {
      return ProfileResponse.fromJson(response.body as Map<String, dynamic>);
    } else {
      return Future.error(response.statusText.toString());
    }
  }
}
