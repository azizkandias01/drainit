import 'dart:math';

import 'package:drainit_flutter/app/modules/searchmap/models/searchmap_model.dart';
import 'package:drainit_flutter/app/modules/searchmap/providers/searchmap_provider.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchmapController extends GetxController {
  RxBool isLoading = false.obs;
  Rx<LatLng> data = const LatLng(0.0, 0.0).obs;
  RxList myMarker = [].obs;
  List<Place> _suggestions = history;
  List<Place> get suggestions => _suggestions;

  String _query = '';
  String get query => _query;

  Future<void> onQueryChanged(String query) async {
    if (query == _query) return;

    _query = query;
    isLoading.value = true;

    if (query.isEmpty) {
      _suggestions = history;
    } else {
      await SearchmapProvider().loadSearch(query).then(
            (value) => {
              _suggestions = value
                  .map((e) => Place.fromJson(e as Map<String, dynamic>))
                  .toSet()
                  .toList()
            },
          );
    }
    isLoading.value = false;
  }

  void goToSearch(
    double lat,
    double long,
    GoogleMapController controller,
  ) {
    final CameraPosition cameraPosition = CameraPosition(
      target: LatLng(lat, long),
      zoom: 18.151926040649414,
    );
    myMarker.clear();
    myMarker.add(
      Marker(
        markerId: const MarkerId("rand"),
        position: LatLng(lat, long),
      ),
    );
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  void clear() {
    _suggestions = history;
  }

  Future<String> getAddress(LatLng coordinate) async {
    final List<Placemark> placemarks = await placemarkFromCoordinates(
      coordinate.latitude,
      coordinate.longitude,
    );
    final first = placemarks.first;
    final locality = first.locality ?? '';
    final administrativeArea = first.administrativeArea ?? '';
    final subLocality = first.subLocality ?? '';
    final subAdministrativeArea = first.subAdministrativeArea ?? '';
    final street = first.street ?? '';
    final name = first.name ?? '';
    final thoroughfare = first.thoroughfare ?? '';
    final subThoroughfare = first.subThoroughfare ?? '';
    final addressLine =
        '$locality,$administrativeArea,$subLocality,$subAdministrativeArea,$street,$name,$thoroughfare,$subThoroughfare';
    return addressLine;
  }

  @override
  void onClose() {
    // TODO: implement onClose

    print("close map");
  }

  @override
  void onInit() {
    super.onInit();
    print("strart map");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("dispose map");
  }
}

const List<Place> history = [
  Place(
    name: 'San Fracisco',
    country: 'United States of America',
    state: 'California',
    lat: 50.4,
    long: 23.1,
  ),
  Place(
    name: 'Singapore',
    country: 'Singapore',
    state: '',
    lat: 50.4,
    long: 23.1,
  ),
  Place(
    name: 'Munich',
    state: 'Bavaria',
    country: 'Germany',
    lat: 50.4,
    long: 23.1,
  ),
  Place(
    name: 'London',
    country: 'United Kingdom',
    state: '',
    lat: 50.4,
    long: 23.1,
  ),
];
