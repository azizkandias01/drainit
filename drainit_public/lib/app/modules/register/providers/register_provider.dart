import 'package:get/get.dart';

class RegisterProvider extends GetConnect {
  Future<String> registerUser(Map data) async {
    final response = await post(
      'https://gis-drainase.pocari.id/api/register/masyarakat',
      data,
    );
    if (response.status.hasError) {
      return Future.error(response.statusText.toString());
    } else {
      return 'success register';
    }
  }
}
