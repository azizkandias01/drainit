import 'dart:convert';

import 'package:drainit_petugas/app/modules/maps/models/drainage_map.dart';
import 'package:drainit_petugas/app/modules/maps/models/drainage_model.dart';
import 'package:drainit_petugas/app/modules/maps/models/flood_model.dart';
import 'package:drainit_petugas/app/modules/maps/providers/drainage_map_provider.dart';
import 'package:drainit_petugas/app/modules/maps/providers/drainage_provider.dart';
import 'package:drainit_petugas/app/modules/maps/providers/flood_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsController extends GetxController {
  ///list of flood point
  List<FloodModel> floodPoint = <FloodModel>[];

  ///list of drainage point
  List<Drainage> drainagePoint = <Drainage>[];

  ///list of drainage map point
  List<DrainageMap> drainageMapPoint = <DrainageMap>[];

  ///list of polylinse of coordinates
  List<LatLng> polylineCoordinates = <LatLng>[];

  ///list of polylines that will render on maps
  Set<Polyline> polylines = <Polyline>{};

  ///list of markers that observable means the variable could change
  ///
  List<Marker> markers = <Marker>[].obs;
  final floodIcon =
      "iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAABmJLR0QA/wD/AP+gvaeTAAAC50lEQVR4nO2WTW9MURiAn/dMJzXT/gTVhY+FUZU2IpGSqQWJj2ChCxSJNqE+/oeP2CnRShArFkhLwsKICrVBW7UiqfoLTEN7z2vRmTtDOtO5DJHxPqvJzclzzn1z750HjP8byf/YNDzxWeGTQAb1gyO7Wl9FEW0aGmtDXI9Cp8AyQIFpgcycuIHnO1JvIvuc61UlXexT1cfgBp7tWjMWxdcxPN4uIj05X9PIzpZG+HEAWrReUW7GZlzfk67U53Li9K3JxiDpLwEHin0/oaA3EnE98Whb65fq+OR6Ih6crMiX8P0IB4t9IztbBMDlLyTivhH17YieBbII3XNJ/2Ljg4nlpeSbh96tDJLBKHAQyKKc88L6RNw3zvvcBkQuADMgh7OzbjR9b3JFKV/H/TergqR/GfrgfGmfHsnOutHFzjeX9C8QuoGsIGfEubasfm3Ir1lwwul7kyuCWHAXJAV8Qel3Krfr64N3ADPf6lIqvkvgOJBUeOsde55vb/lQ6sZEY3eA1bkb63debuV92bm6NajfV+yrC9zeJ7tT7yvwLXg+xO8D+hY7X6lH7M88ikl/Gdhf3lftV6W8r+QA8nQMj7cLchRIM/8xAvioqhnvYoNRP255X+5j2ZS7PC2QwbnBp9tTr3/Ft9D5XCx2NarPMIz/i+qWoHO9qGwBXQqgMO3gsVe5ErXcarAEI/1d/nFfxSVY7XL7+75Cqf56CcKln8tN0C5Uj1GFcvttXwXni1yCWx+ONczMykWQQ2XWeYFrS+L+dCWPom/wF1XpLuNThGuJOn/q3ynBobetIvSA7wRpzlmnBDIiOvB0x9qJxRzFbLw/uc75oEdEOoHm3DmnwGUIdGBkd8t4FJ+VoGEYxm9gKRxuaClsKVyYmqWwpXCIpbBhGEYNYykcbmgpbClcmJqlsKVwiKWwYRhGDWMpHG5oKWwpXJiapbClcIilsGEYRg1jKRxuaClsKVyYmqWwpXCIpbBR23wHb+8W37SzH6AAAAAASUVORK5CYII=";
  final selectedIndexFilter = 0.obs;
  final List<Filter> chipsList = [
    Filter(
      "Banjir",
      Icons.water,
    ),
    Filter(
      "Drainase Rusak",
      Icons.broken_image,
    ),
    Filter(
      "IOT",
      Icons.settings_remote,
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    loadDrainagePoint();
    loadFloodPoint();
    loadMapDrainage();
  }

  ///function for load flood points from API
  Future<void> loadFloodPoint() async {
    final List<FloodModel> result =
        await FloodModelProvider().loadFloodPoint() as List<FloodModel>;
    floodPoint = result;
  }

  ///function for load broken drainage points from API
  Future<void> loadDrainagePoint() async {
    final List<Drainage> result =
        await DrainageProvider().loadDrainagePoint() as List<Drainage>;
    drainagePoint = result;
  }

  ///drawing polylines to map
  Future<void> loadMapDrainage() async {
    final dynamic result = await DrainageMapProvider().loadMapDrainage();
    drainageMapPoint = result as List<DrainageMap>;
    for (final DrainageMap element in drainageMapPoint) {
      final String typeDrainage = drainageType(element.geometry ?? "'point'");
      final List<dynamic> points =
          drainageGeometry(element.geometry!, typeDrainage);
      final List<LatLng> drainagePointsLocal = <LatLng>[];
      for (final dynamic element in points) {
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
          polylineId: const PolylineId(''),
          color: Colors.yellow,
          width: 3,
          points: drainagePointsLocal,
        );
        polylines.add(polyline);
      }
    }
  }

  ///converting geo data from api to latlong
  LatLng geoToLatlong(String string) {
    final String substring = string.substring(34, string.length - 2);
    final List<String> latlong = substring.split(',');
    final LatLng latLng = LatLng(
      double.parse(latlong[1]),
      double.parse(
        latlong[0],
      ),
    );
    return latLng;
  }

  ///get drainage type from given geo data
  String drainageType(String parse) {
    return jsonDecode(parse)['type'] as String;
  }

  ///decode data that api gives as string so this needs to be parse to json
  List<dynamic> drainageGeometry(String geometry, String type) {
    if (type == 'MultiLineString') {
      final dynamic tagsJson = jsonDecode(geometry)['coordinates'][0];
      final List<dynamic> tags =
          List<dynamic>.from(tagsJson as Iterable<dynamic>);
      return tags;
    } else if (type == 'LineString') {
      final dynamic tagsJson = jsonDecode(geometry)['coordinates'];
      final List<dynamic> tags =
          List<dynamic>.from(tagsJson as Iterable<dynamic>);

      return tags;
    } else {
      return <dynamic>[];
    }
  }
}

class Filter {
  String label;
  IconData icon;
  Filter(this.label, this.icon);
}
