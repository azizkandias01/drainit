import 'dart:convert';

import 'package:drainit_petugas/app/modules/maps/models/drainage_map.dart';
import 'package:drainit_petugas/app/modules/maps/models/drainage_model.dart';
import 'package:drainit_petugas/app/modules/maps/models/flood_model.dart';
import 'package:drainit_petugas/app/modules/maps/models/iot_model.dart';
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

  IOT iotMapPoints = IOT();

  ///list of markers that observable means the variable could change
  ///
  List<Marker> markers = <Marker>[].obs;
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
    loadIOTPoint();
  }

  ///function for load flood points from API
  Future<void> loadFloodPoint() async {
    final List<FloodModel> result =
        await FloodModelProvider().loadFloodPoint() as List<FloodModel>;
    floodPoint = result;
  }

  Future<void> loadIOTPoint() async {
    final IOT result = await DrainageMapProvider().loadIOT() as IOT;
    iotMapPoints = result;
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
