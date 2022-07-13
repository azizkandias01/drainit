import 'package:drainit_petugas/app/modules/profile/models/profile_model.dart';
import 'package:drainit_petugas/app/routes/app_pages.dart';
import 'package:get/get.dart';

class ProfileProvider extends GetConnect {
  Future<Data> getProfile(String bearer) async {
    final response =
        await get(Routes.BASEURL_USER + "profile/petugas", headers: {
      "Authorization": "Bearer $bearer",
    });
    if (response.status.hasError) {
      print(response.bodyString);
      return Future.error(response.statusCode.toString());
    } else {
      return ProfileModel.fromJson(response.body as Map<String, dynamic>).data!;
    }
  }
}
