import 'package:get/get.dart';

class RegisterProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<String> registerUser(Map data) async {
    final response = await post(
        'https://gis-drainase.pocari.id/api/register/masyarakat', data);
    if (response.status.hasError) {
      return Future.error(response.statusText.toString());
    } else {
      print(response.body);
      return "success register";
    }
  }
}
