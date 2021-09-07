import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:drainit_flutter/app/components/constant.dart';
import 'package:drainit_flutter/app/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../controllers/flood_drainage_list_controller.dart';

late var _initialPosition;

Future<LatLng> _getPosition() async {
  final Location location = Location();
  if (!await location.serviceEnabled()) {
    if (!await location.requestService()) throw 'GPS service is disabled';
  }
  if (await location.hasPermission() == PermissionStatus.denied) {
    if (await location.requestPermission() != PermissionStatus.granted)
      throw 'No GPS permissions';
  }
  final LocationData data = await location.getLocation();
  return LatLng(data.latitude!, data.longitude!);
}

class FloodDrainageListView extends GetView<FloodDrainageListController> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(414, 896),
      builder: () => Scaffold(
        body: Center(
            child: Stack(
          children: [
            Map(),
            SafeArea(child: chipAction()),
          ],
        )),
      ),
    );
  }

  Widget chipAction() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ActionChip(
              label: Text("Flood"),
              onPressed: () {
                if (controller.markers.isNotEmpty) {
                  controller.markers.clear();
                  for (var item in controller.floodPoint) {
                    controller.markers.add(
                      Marker(
                        markerId: MarkerId(item.id!),
                        icon: BitmapDescriptor.defaultMarker,
                        position: controller.geoToLatlong(item.geometry!),
                        onTap: () {
                          Get.bottomSheet(
                            Container(
                              height: 300.h,
                              color: white,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CachedNetworkImage(
                                      imageUrl: imagePath() + item.foto!,
                                      placeholder: (Context, String) {
                                        return Center(
                                            child: CircularProgressIndicator());
                                      },
                                      height: 150.h,
                                      width: 300.w,
                                      fit: BoxFit.cover,
                                      errorWidget: (_, __, ___) {
                                        return Text("data cannot be loaded!");
                                      },
                                    ),
                                  ),
                                  Text(item.namaJalan!),
                                  Text(item.keterangan!),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                } else {
                  for (var item in controller.floodPoint) {
                    controller.markers.add(
                      Marker(
                        markerId: MarkerId(item.id!),
                        icon: BitmapDescriptor.defaultMarker,
                        position: controller.geoToLatlong(item.geometry!),
                        onTap: () {
                          Get.bottomSheet(
                            Container(
                              height: 300.h,
                              color: white,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CachedNetworkImage(
                                      imageUrl: imagePath() + item.foto!,
                                      placeholder: (Context, String) {
                                        return Center(
                                            child: CircularProgressIndicator());
                                      },
                                      height: 150.h,
                                      width: 300.w,
                                      fit: BoxFit.cover,
                                      errorWidget: (_, __, ___) {
                                        return Text("data cannot be loaded!");
                                      },
                                    ),
                                  ),
                                  Text(item.namaJalan!),
                                  Text(item.keterangan!),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                }
              }),
          SizedBox(
            width: 10,
          ),
          ActionChip(
            label: Text("Drainage"),
            onPressed: () {
              if (controller.markers.isNotEmpty) {
                controller.markers.clear();
                for (var item in controller.drainagePoint) {
                  controller.markers.add(
                    Marker(
                      markerId: MarkerId(item.id!),
                      icon: BitmapDescriptor.defaultMarker,
                      position: controller.geoToLatlong(item.geometry!),
                      onTap: () {
                        Get.bottomSheet(
                          Container(
                            height: 300.h,
                            color: white,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CachedNetworkImage(
                                    imageUrl: imagePath() + item.foto!,
                                    placeholder: (Context, String) {
                                      return Center(
                                          child: CircularProgressIndicator());
                                    },
                                    height: 150.h,
                                    width: 300.w,
                                    fit: BoxFit.cover,
                                    errorWidget: (_, __, ___) {
                                      return Text("data cannot be loaded!");
                                    },
                                  ),
                                ),
                                Text(item.namaJalan!),
                                Text(item.keterangan!),
                              ],
                            ),
                          ),
                        );
                      },
                      infoWindow: InfoWindow(
                          title: item.namaJalan, snippet: item.status),
                    ),
                  );
                }
              } else {
                for (var item in controller.drainagePoint) {
                  controller.markers.add(
                    Marker(
                      markerId: MarkerId(item.id!),
                      icon: BitmapDescriptor.defaultMarker,
                      position: controller.geoToLatlong(item.geometry!),
                      onTap: () {
                        Get.bottomSheet(
                          Container(
                            height: 300.h,
                            color: white,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CachedNetworkImage(
                                    imageUrl: imagePath() + item.foto!,
                                    placeholder: (Context, String) {
                                      return Center(
                                          child: CircularProgressIndicator());
                                    },
                                    height: 150.h,
                                    width: 300.w,
                                    fit: BoxFit.cover,
                                    errorWidget: (_, __, ___) {
                                      return Text("data cannot be loaded!");
                                    },
                                  ),
                                ),
                                Text(item.namaJalan!),
                                Text(item.keterangan!),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              }
            },
          ),
          SizedBox(
            width: 10.w,
          ),
          ActionChip(
              label: Text("Current Location"),
              onPressed: () => Map._goToCurrentLocation()),
        ],
      ),
    );
  }
}

class Map extends GetView<FloodDrainageListController> {
  static Completer<GoogleMapController> _controller = Completer();
  static Future<void> _goToCurrentLocation() async {
    _initialPosition = await _getPosition();
    final CameraPosition currentLocation = CameraPosition(
      target: _initialPosition,
      zoom: 18.151926040649414,
    );
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(currentLocation));
  }

  @override
  Widget build(BuildContext context) {
    return buildMap();
  }

  Widget buildMap() {
    final CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(0.510440, 101.438309),
      zoom: 14.4746,
    );

    return Scaffold(
      body: Obx(
        () => GoogleMap(
          mapType: MapType.hybrid,
          initialCameraPosition: _kGooglePlex,
          markers: Set<Marker>.of(controller.markers),
          onMapCreated: (GoogleMapController controller) {
            if (!_controller.isCompleted) {
              _controller.complete(controller);
            } else {
              print("completer has created");
            }
          },
        ),
      ),
    );
  }
}
