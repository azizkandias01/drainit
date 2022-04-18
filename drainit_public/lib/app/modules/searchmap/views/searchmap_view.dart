// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:math';

import 'package:drainit_flutter/app/components/constant.dart';
import 'package:drainit_flutter/app/modules/searchmap/models/searchmap_model.dart';
import 'package:drainit_flutter/app/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import '../controllers/searchmap_controller.dart';

// ignore: must_be_immutable
class SearchmapView extends GetView<SearchmapController> {
  final fabController = FloatingSearchBarController();
  int _index = 0;

  int get index => _index;

  set index(int value) {
    _index = min(value, 2);
    _index == 2 ? fabController.hide() : fabController.show();
    // setState(() {});
  }

  late bool isPortrait;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Pilih titik laporan'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: SearchmapSearchDelegate());
            },
          ),
        ],
      ),
      body: SafeArea(
        child: buildMap(),
      ),
    );
  }

  Widget buildMap() {
    return Scaffold(
      body: FutureBuilder(
        future: getPosition(),
        builder: (context, AsyncSnapshot<LatLng> snapshot) {
          if (snapshot.hasData) {
            return Obx(
              () => GoogleMap(
                initialCameraPosition:
                    CameraPosition(target: snapshot.data!, zoom: 18),
                onMapCreated: (GoogleMapController controller) {
                  this.controller.googleMapController = controller;
                  this.controller.myMarker.clear();
                  this.controller.myMarker.add(
                        Marker(
                          markerId: const MarkerId('my'),
                          position: snapshot.data!,
                        ),
                      );
                },
                onTap: (latLng) async {
                  controller.myMarker.clear();
                  controller.myMarker.add(
                    Marker(
                      markerId: const MarkerId('my'),
                      position: LatLng(latLng.latitude, latLng.longitude),
                    ),
                  );
                  Get.bottomSheet(
                    Container(
                      color: Colors.white,
                      height: 300,
                      child: Column(
                        children: [
                          Text('Lat: ${latLng.latitude}'),
                          Text(await controller.getAddress(
                              LatLng(latLng.latitude, latLng.longitude))),
                        ],
                      ),
                    ),
                  );
                },
                markers: Set<Marker>.of(controller.myMarker),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class SearchmapSearchDelegate extends SearchDelegate {
  final SearchmapController controller = Get.find<SearchmapController>();
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final RxList<Place> matchData = <Place>[].obs;
    controller.searchLocation(query);

    controller.searchSugesstion.value
        .where((element) =>
            element.name.toLowerCase().contains(query.toLowerCase()))
        .forEach((element) {
      matchData.add(element);
    });
    return Obx(
      () => ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () async {
              Get.back();
              controller.goToSearch(matchData.value[index].lat,
                  matchData.value[index].long, controller.googleMapController);
              controller.myMarker.clear();
              controller.myMarker.add(Marker(
                markerId: MarkerId('my'),
                position: LatLng(
                    matchData.value[index].lat, matchData.value[index].long),
                icon: BitmapDescriptor.defaultMarker,
              ));
              Get.bottomSheet(
                Container(
                  color: Colors.white,
                  height: 300,
                  child: Text(await controller.getAddress(LatLng(
                      matchData.value[index].lat,
                      matchData.value[index].long))),
                ),
              );
            },
            title: Text(
              matchData.value[index].name,
              style: const TextStyle(color: black),
            ),
            subtitle: Text(
              matchData.value[index].country,
              style: TextStyle(color: Colors.grey.shade600),
            ),
            leading: const Icon(
              Icons.place,
              color: Colors.black,
            ),
          );
        },
        itemCount: matchData.value.length,
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final RxList<Place> matchData = <Place>[].obs;
    controller.searchLocation(query);
    controller.searchSugesstion.value
        .where((element) =>
            element.name.toLowerCase().contains(query.toLowerCase()))
        .forEach((element) {
      matchData.add(element);
    });
    return Obx(
      () => ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () async {
              Get.back();
              controller.goToSearch(matchData.value[index].lat,
                  matchData.value[index].long, controller.googleMapController);
              controller.myMarker.clear();
              controller.myMarker.add(Marker(
                markerId: const MarkerId('my'),
                position: LatLng(
                    matchData.value[index].lat, matchData.value[index].long),
              ));
              Get.bottomSheet(
                Container(
                  color: Colors.white,
                  height: 300,
                  child: Text(await controller.getAddress(LatLng(
                      matchData.value[index].lat,
                      matchData.value[index].long))),
                ),
              );
            },
            title: Text(
              matchData.value[index].name,
              style: const TextStyle(color: black),
            ),
            subtitle: Text(
              matchData.value[index].country,
              style: TextStyle(color: Colors.grey.shade600),
            ),
            leading: const Icon(
              Icons.place,
              color: Colors.black,
            ),
          );
        },
        itemCount: matchData.value.length,
      ),
    );
  }
}
