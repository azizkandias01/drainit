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
    if (await location.requestPermission() != PermissionStatus.granted) {
      throw 'No GPS permissions';
    }
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
                                      placeholder: (_, __) {
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

Set<Polyline> _polylines = {};
List<TaskModel> listofTasks = [];

class Map extends GetView<FloodDrainageListController> {
  void setMaps() {
    Polyline polyline;
    print(controller.polylineCoordinates);
    polyline = Polyline(
        polylineId: PolylineId(""),
        color: primary,
        width: 3,
        points: controller.polylineCoordinates);
    _polylines.add(polyline);
  }

  static final Completer<GoogleMapController> _controller = Completer();
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
      target: LatLng(0.475547403985763, 101.48610746420654),
      zoom: 12.4746,
    );

    return Scaffold(
      body: Obx(
        () => GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          markers: Set<Marker>.of(controller.markers),
          polylines: controller.polylines,
          onMapCreated: (GoogleMapController controller) {
            if (!_controller.isCompleted) {
              _controller.complete(controller);
              controller.setMapStyle(mapStyles);
              setMaps();
            } else {
              controller.setMapStyle(mapStyles);
              print("completer has created");
              setMaps();
            }
          },
        ),
      ),
    );
  }
}

class TaskModel {
  String taskid;
  String name;
  String address;
  double slatitude;
  double dlatitude;
  double slongitude;
  double dlongitude;

  TaskModel(this.taskid, this.name, this.address, this.slongitude,
      this.slatitude, this.dlongitude, this.dlatitude);
}
