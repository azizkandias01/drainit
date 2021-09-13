import 'dart:convert';

import 'package:drainit_flutter/app/components/constant.dart';
import 'package:drainit_flutter/app/modules/flood_drainage_list/models/drainage_map.dart';
import 'package:drainit_flutter/app/modules/flood_drainage_list/models/drainage_model.dart';
import 'package:drainit_flutter/app/modules/flood_drainage_list/models/flood_model.dart';
import 'package:drainit_flutter/app/modules/flood_drainage_list/providers/drainage_map_provider.dart';
import 'package:drainit_flutter/app/modules/flood_drainage_list/providers/drainage_provider.dart';
import 'package:drainit_flutter/app/modules/flood_drainage_list/providers/flood_provider.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FloodDrainageListController extends GetxController {
  List<FloodModel> floodPoint = [];
  List<Drainage> drainagePoint = [];
  List<DrainageMap> drainageMapPoint = [];
  List<LatLng> polylineCoordinates = [];
  Set<Polyline> polylines = {};
  List<Marker> markers = <Marker>[].obs;
  @override
  void onInit() {
    super.onInit();
    loadDrainagePoint();
    loadFloodPoint();
    loadMapDrainage();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void loadFloodPoint() async {
    var result =
        await FloodModelProvider().loadFloodPoint() as List<FloodModel>;
    floodPoint = result;
  }

  void loadDrainagePoint() async {
    var result = await DrainageProvider().loadDrainagePoint();
    drainagePoint = result;
  }

  void loadMapDrainage() async {
    var result = await DrainageMapProvider().loadMapDrainage();
    drainageMapPoint = result;
    for (var element in drainageMapPoint) {
      var typeDrainage = drainageType(element.geometry ?? "point");
      var points = drainageGeometry(element.geometry!, typeDrainage);
      List<LatLng> drainagePointsLocal = [];
      for (var element in points) {
        drainagePointsLocal.add(
          LatLng(
            double.parse(
              element[1].toString(),
            ),
            double.parse(
              element[0].toString(),
            ),
          ),
        );
        Polyline polyline;
        polyline = Polyline(
            polylineId: PolylineId(""),
            color: primary,
            width: 3,
            points: drainagePointsLocal);
        polylines.add(polyline);
      }
    }
  }

  LatLng geoToLatlong(String string) {
    var substring = string.substring(34, string.length - 2);
    List<String> latlong = substring.split(",");
    final latLng = LatLng(
      double.parse(latlong[1]),
      double.parse(
        latlong[0],
      ),
    );
    return latLng;
  }

  String drainageType(String parse) {
    return jsonDecode(parse)['type'];
  }

  List<dynamic> drainageGeometry(String geometry, String type) {
    if (type == "MultiLineString") {
      var tagsJson = jsonDecode(geometry)['coordinates'][0];
      List<dynamic>? tags = List.from(tagsJson);

      return tags;
    } else if (type == "LineString") {
      var tagsJson = jsonDecode(geometry)['coordinates'];
      List<dynamic>? tags = List.from(tagsJson);

      return tags;
    } else {
      return [];
    }
  }

  @override
  void onClose() {}
}
