import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:drainit_flutter/app/components/constant.dart';
import 'package:drainit_flutter/app/components/text_default.dart';
import 'package:drainit_flutter/app/modules/flood_drainage_list/controllers/flood_drainage_list_controller.dart';
import 'package:drainit_flutter/app/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ignore: prefer_typing_uninitialized_variables
late LatLng _initialPosition;

class FloodDrainageListView extends GetView<FloodDrainageListController> {
  @override
  Widget build(BuildContext context) {
    loadFloodMarker(controller);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Peta titik',
          style: TextStyle(color: Colors.black),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                primary,
                white,
              ],
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        elevation: 0,
        actions: <Widget>[
          PopupMenuButton(
            icon: const Icon(Icons.filter_list, color: black),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            onSelected: (value) {
              if (value == 'rusak') {
                if (controller.markers.isNotEmpty) {
                  controller.markers.clear();
                  loadDrainageMarker(controller);
                } else {
                  loadDrainageMarker(controller);
                }
              }
              if (value == 'banjir') {
                if (controller.markers.isNotEmpty) {
                  controller.markers.clear();
                  loadFloodMarker(controller);
                } else {
                  loadFloodMarker(controller);
                }
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: 'semua',
                child: Text('Semua'),
              ),
              PopupMenuItem(
                value: 'banjir',
                child: Text('Titik banjir'),
              ),
              PopupMenuItem(
                value: 'rusak',
                child: Text('Titik rusak'),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(
              Icons.refresh,
              color: black,
            ),
            onPressed: () {
              Get.dialog(
                Container(
                  color: Colors.white,
                  width: ScreenUtil().setWidth(100),
                  height: ScreenUtil().setHeight(100),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
              controller.loadDrainagePoint();
              controller.loadFloodPoint();
              controller.loadMapDrainage();
              Get.back();
            },
          ),
        ],
      ),
      body: Map(),
    );
  }
}

class Map extends GetView<FloodDrainageListController> {
  static final Completer<GoogleMapController> _controller = Completer();
  static Future<void> _goToCurrentLocation() async {
    _initialPosition = await getPosition();
    final CameraPosition currentLocation = CameraPosition(
      target: _initialPosition,
      zoom: 15.151926040649414,
    );
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(currentLocation));
  }

  @override
  Widget build(BuildContext context) {
    return buildMap();
  }

  Widget buildMap() {
    const CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(0.563336, 101.44186),
      zoom: 14.4746,
    );

    return Scaffold(
      body: Obx(
        () => GoogleMap(
          initialCameraPosition: _kGooglePlex,
          markers: Set<Marker>.of(controller.markers),
          polylines: controller.polylines,
          myLocationButtonEnabled: false,
          onMapCreated: (GoogleMapController controller) {
            if (!_controller.isCompleted) {
              _controller.complete(controller);
              controller.setMapStyle(mapStyles);
            } else {
              controller.setMapStyle(mapStyles);
              //print('completer has created');
            }
          },
        ),
      ),
    );
  }
}

void loadFloodMarker(FloodDrainageListController controller) {
  for (final item in controller.floodPoint) {
    controller.markers.add(
      Marker(
        markerId: MarkerId(item.id!),
        position: controller.geoToLatlong(item.geometry!),
        onTap: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: Get.context!,
            backgroundColor: Colors.transparent,
            builder: (ctx) => Container(
              height: 0.5.sh,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextBold(
                    text: "${item.namaJalan}",
                    fontSize: 18.sp,
                  ),
                  10.verticalSpace,
                  TextBold(text: "${item.status}"),
                  10.verticalSpace,
                  TextMedium(text: "${item.keterangan}"),
                  20.verticalSpace,
                  CachedNetworkImage(
                    imageUrl: item.foto ?? "",
                    height: 0.3.sh,
                    width: 1.sw,
                    errorWidget: (context, url, error) => Container(
                      height: 0.3.sh,
                      width: 1.sw,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: grey300,
                      ),
                    ),
                  ),
                ],
              ).paddingAll(20.r),
            ),
          );
        },
        //   Get.bottomSheet(
        //     Container(
        //       height: 300.h,
        //       color: white,
        //       child: Column(
        //         children: [
        //           Padding(
        //             padding: const EdgeInsets.all(8.0),
        //             child: CachedNetworkImage(
        //               imageUrl: Routes.IMAGEURL + item.foto!,
        //               placeholder: (_, __) {
        //                 return const Center(child: CircularProgressIndicator());
        //               },
        //               height: 150.h,
        //               width: 300.w,
        //               fit: BoxFit.cover,
        //               errorWidget: (_, __, ___) {
        //                 return const Text('data cannot be loaded!');
        //               },
        //             ),
        //           ),
        //           Text(item.namaJalan!),
        //           Text(item.keterangan!),
        //         ],
        //       ),
        //     ),
        //   );
        // },
      ),
    );
  }
}

void loadDrainageMarker(FloodDrainageListController controller) {
  for (final item in controller.drainagePoint) {
    controller.markers.add(
      Marker(
        markerId: MarkerId(item.id!),
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
                        return const Center(child: CircularProgressIndicator());
                      },
                      height: 150.h,
                      width: 300.w,
                      fit: BoxFit.cover,
                      errorWidget: (_, __, ___) {
                        return const Text('data cannot be loaded!');
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
