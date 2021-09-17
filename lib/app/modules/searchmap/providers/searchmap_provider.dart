import 'package:get/get.dart';

class SearchmapProvider extends GetConnect {
  Future<List<dynamic>> loadSearch(String query) async {
    final response = await get(
      'https://photon.komoot.io/api/?q=$query&lat=0.5696307903657801&lon=101.42544396221638',
    );
    if (response.status.hasError) {
      return Future.error(response.statusText.toString());
    } else {
      return response.body['features'] as List;
    }
  }
}
