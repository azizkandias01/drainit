import 'package:drainit_flutter/app/modules/flood_drainage_list/models/drainage_model.dart';
import 'package:drainit_flutter/app/modules/flood_drainage_list/models/flood_model.dart';
import 'package:drainit_flutter/app/modules/flood_drainage_list/models/geometry_model.dart';
import 'package:drainit_flutter/app/modules/flood_drainage_list/providers/drainage_provider.dart';
import 'package:drainit_flutter/app/modules/flood_drainage_list/providers/flood_provider.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FloodDrainageListController extends GetxController {
  List<FloodModel> floodPoint = [];
  List<Drainage> drainagePoint = [];
  List<Marker> markers = <Marker>[].obs;
  @override
  void onInit() {
    super.onInit();
    loadDrainagePoint();
    loadFloodPoint();
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

  LatLng geoToLatlong(String string) {
    var substring = string.substring(34, string.length - 2);
    List<String> latlong = substring.split(",");
    final latLng = LatLng(double.parse(latlong[1]), double.parse(latlong[0]));
    return latLng;
  }

  @override
  void onClose() {}
}
