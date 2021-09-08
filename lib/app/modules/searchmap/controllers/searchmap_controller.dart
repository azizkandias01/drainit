import 'package:drainit_flutter/app/modules/searchmap/models/searchmap_model.dart';
import 'package:drainit_flutter/app/modules/searchmap/providers/searchmap_provider.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchmapController extends GetxController {
  var isLoading = false.obs;
  var data = LatLng(0.0, 0.0).obs;
  var myMarker = [].obs;
  List<Place> _suggestions = history;
  List<Place> get suggestions => _suggestions;

  String _query = '';
  String get query => _query;

  void onQueryChanged(String query) async {
    if (query == _query) return;

    _query = query;
    isLoading.value = true;

    if (query.isEmpty) {
      _suggestions = history;
    } else {
      await SearchmapProvider().loadSearch(query).then(
            (value) => {
              _suggestions =
                  value.map((e) => Place.fromJson(e)).toSet().toList()
            },
          );
    }
    isLoading.value = false;
  }

  void clear() {
    _suggestions = history;
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
