import 'package:drainit_flutter/app/modules/timeline/models/timeline_model.dart';
import 'package:get/get.dart';

class TimelineProvider extends GetConnect {
  Future loadTimeline(String token) async {
    final header = {"Authorization": "Bearer $token"};

    final response = await get(
      "https://gis-drainase.pocari.id/api/pengaduanwithvote",
      headers: header,
    );
    if (response.status.hasError) {
      return Future.error(response.statusText.toString());
    } else {
      // print(response.body);
      var dataRaw = (response.body as List)
          .map(
            (e) => TimelineModel.fromJson(e),
          )
          .where((element) =>
              element.foto!.contains(".jpeg") || element.foto!.contains(".png"))
          .toList();
      return dataRaw;
    }
  }
}
