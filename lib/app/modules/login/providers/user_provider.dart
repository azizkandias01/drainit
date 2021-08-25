import 'package:drainit_flutter/app/modules/login/models/user_model.dart';
import 'package:get/get.dart';

class UserProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'https://gis-drainase.pocari.id/api/';
  }

  Future<LoginReponse> loginUser(Map data) async {
    final response =
        await post('https://gis-drainase.pocari.id/api/login/masyarakat', data);
    if (response.status.hasError) {
      return Future.error(response.statusText.toString());
    } else {
      print(response.body);
      return LoginReponse.fromJson(response.body);
    }
  }
}
