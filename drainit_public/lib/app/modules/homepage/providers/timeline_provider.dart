import 'package:drainit_flutter/app/modules/homepage/models/timeline_model.dart';
import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:get/get_connect/connect.dart';

class TimelineProvider extends GetConnect {
  Future<List<Timeline>> loadTimeline(String token) async {
    final header = {'Authorization': 'Bearer $token'};

    final response = await get(
      '${Routes.BASEURL_SYSTEM}pengaduan_sortedup',
      headers: header,
    ).timeout(const Duration(seconds: 10));

    if (response.status.hasError) {
      return Future.error(response.statusText.toString());
    } else {
      // print(response.body);
      final dataRaw = (response.body as List)
          .map(
            (e) => Timeline.fromJson(e as Map<String, dynamic>),
          )
          .toList();
      return dataRaw;
    }
  }

  Future<List<Timeline>> loadAllimeline(String token, String userId) async {
    final header = {'Authorization': 'Bearer $token'};

    final response = await get(
      '${Routes.BASEURL_SYSTEM}pengaduan',
      headers: header,
    ).timeout(const Duration(seconds: 10));

    if (response.status.hasError) {
      return Future.error(response.statusText.toString());
    } else {
      final dataRaw = (response.body as List)
          .map(
            (e) => Timeline.fromJson(e as Map<String, dynamic>),
          )
          .toList();
      return dataRaw;
    }
  }

  Future<String> vote(Map data, String bearer) async {
    final headers = {'Authorization': 'Bearer $bearer'};

    final response = await post(
      '${Routes.BASEURL_SYSTEM}vote',
      data,
      headers: headers,
    ).timeout(const Duration(seconds: 10));

    if (response.hasError) {
      return Future.error(response.statusText.toString());
    } else {
      return "success";
    }
  }

  Future<String> deleteVote(String idPengaduan, String bearer) async {
    final headers = {'Authorization': 'Bearer $bearer'};
    final response = await delete(
      '${Routes.BASEURL_SYSTEM}vote/$idPengaduan',
      headers: headers,
    ).timeout(const Duration(seconds: 10));

    if (response.hasError) {
      return Future.error(response.bodyString.toString());
    } else {
      return "success";
    }
  }
}
