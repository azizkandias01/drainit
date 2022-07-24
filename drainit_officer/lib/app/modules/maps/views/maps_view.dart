import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:d_chart/d_chart.dart';
import 'package:drainit_petugas/app/routes/app_pages.dart';
import 'package:drainit_petugas/app/utils/colors.dart';
import 'package:drainit_petugas/app/utils/text_default.dart';
import 'package:drainit_petugas/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/maps_controller.dart';

class MapsView extends GetView<MapsController> {
  static final Completer<GoogleMapController> _googleMapsController =
      Completer();
  @override
  Widget build(BuildContext context) {
    loadFloodMarker(controller);
    final CameraPosition cameraPosition = CameraPosition(
      target: LatLng(0.563336, 101.44186),
      zoom: 14.4746,
    );
    List<Widget> filterChip() {
      List<Widget> chips = [];
      for (int i = 0; i < controller.chipsList.length; i++) {
        Widget item = ChoiceChip(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.only(left: 10.w),
          labelPadding: EdgeInsets.only(right: 10.w),
          label: TextMedium(
            text: controller.chipsList[i].label,
            fontSize: 10.sp,
            textColour:
                controller.selectedIndexFilter.value == i ? Colors.black : grey,
          ),
          avatar: Icon(
            controller.chipsList[i].icon,
            size: 18.r,
            color:
                controller.selectedIndexFilter.value == i ? Colors.black : grey,
          ),
          labelStyle: TextStyle(color: Colors.white),
          backgroundColor: Colors.white,
          selectedColor: primary,
          selected: controller.selectedIndexFilter.value == i,
          onSelected: (bool value) {
            controller.selectedIndexFilter.value =
                value ? i : controller.selectedIndexFilter.value;
            if (controller.selectedIndexFilter.value == 0) {
              controller.markers.clear();
              loadFloodMarker(controller);
            } else if (controller.selectedIndexFilter.value == 1) {
              controller.markers.clear();
              loadDrainageMarker(controller);
            } else if (controller.selectedIndexFilter.value == 2) {
              controller.markers.clear();
              loadIOTMarker(controller);
            }
          },
        ).paddingAll(5.r);
        chips.add(item);
      }
      return chips;
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          InfoWidget(),
        ],
        title: TextBold(
          text: 'Peta Drainase',
          textColour: Colors.black,
          fontSize: 18.sp,
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                primary,
                Colors.white,
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Obx(
            () => GoogleMap(
              initialCameraPosition: cameraPosition,
              myLocationButtonEnabled: false,
              markers: Set<Marker>.of(controller.markers),
              polylines: controller.polylines,
              onMapCreated: (GoogleMapController controller) {
                if (!_googleMapsController.isCompleted) {
                  _googleMapsController.complete(controller);
                  controller.setMapStyle(mapStyles);
                } else {
                  print('completer has created');
                  controller.setMapStyle(mapStyles);
                }
              },
            ),
          ),
          Obx(
            () => SafeArea(
              child: Align(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Wrap(
                    children: filterChip(),
                  ).paddingSymmetric(horizontal: 20.r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void loadFloodMarker(MapsController controller) {
    for (final item in controller.floodPoint) {
      controller.markers.add(
        Marker(
          markerId: MarkerId(item.id!),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueBlue,
          ),
          position: controller.geoToLatlong(item.geometry!),
          onTap: () {
            Get.bottomSheet(
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(
                        thickness: 3,
                        color: Colors.grey,
                        endIndent: 170.w,
                        indent: 170.w,
                      ),
                      TextMedium(
                        text: item.namaJalan.toString(),
                        fontSize: 18.sp,
                      ),
                      10.verticalSpace,
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 5.r,
                              vertical: 5.r,
                            ),
                            alignment: Alignment.center,
                            height: 25.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.r),
                              ),
                              color: getStatusColor(
                                "Banjir",
                              ),
                            ),
                            child: TextMedium(
                              text: "Banjir",
                              textColour: white,
                            ),
                          ),
                          10.horizontalSpace,
                          TextThin(
                            text:
                                "Kerusakan " + item.kondisiKerusakan.toString(),
                            textColour: Colors.grey,
                          ),
                        ],
                      ),
                      20.verticalSpace,
                      TextMedium(
                        text:
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                        textColour: Colors.grey,
                      ),
                      20.verticalSpace,
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: CachedNetworkImage(
                          imageUrl: "https://picsum.photos/200",
                          placeholder: (_, __) {
                            return const Center(
                                child: CircularProgressIndicator.adaptive());
                          },
                          width: Get.width,
                          height: 200.h,
                          fit: BoxFit.fitWidth,
                          errorWidget: (_, __, ___) {
                            return const Text('data cannot be loaded!');
                          },
                        ),
                      ),
                    ],
                  ).paddingAll(20.r),
                ),
              ),
            );
          },
        ),
      );
    }
  }

  void loadDrainageMarker(MapsController controller) {
    for (final item in controller.drainagePoint) {
      controller.markers.add(
        Marker(
          markerId: MarkerId(item.id!),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen,
          ),
          position: controller.geoToLatlong(item.geometry!),
          onTap: () {
            Get.bottomSheet(
              Container(
                height: .5.sh,
                color: white,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CachedNetworkImage(
                        imageUrl: Routes.IMAGEURL + item.foto!,
                        placeholder: (_, __) {
                          return const Center(
                              child: CircularProgressIndicator());
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
                    Text(item.geometry!),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }
  }

  void loadIOTMarker(MapsController controller) {
    for (int i = 0; i < 2; i++) {
      controller.markers.add(
        Marker(
          markerId: MarkerId(i.toString()),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueOrange,
          ),
          position: i == 0
              ? controller.iotMapPoints.coordinatTitikPcr
              : controller.iotMapPoints.coordinatTitikWismaAtlet,
          onTap: () {
            List<Map<String, dynamic>> dataNodePcr = [];
            List<Map<String, dynamic>> dataNodePcrDebit = [];
            List<Map<String, dynamic>> dataNodeWismaAtlet = [];
            List<Map<String, dynamic>> dataNodeWismaAtletDebit = [];
            for (var item in controller.iotMapPoints.titikPcr!) {
              dataNodePcr.add(
                {
                  "domain": item.id.toString(),
                  "measure": item.tingginode1,
                },
              );
              dataNodePcrDebit.add(
                {
                  "domain": item.id.toString(),
                  "measure": item.debitnode1,
                },
              );
            }
            for (var item in controller.iotMapPoints.titikWismaAtlet!) {
              dataNodeWismaAtlet.add(
                {
                  "domain": item.id.toString(),
                  "measure": item.tingginode2,
                },
              );
              dataNodeWismaAtletDebit.add(
                {
                  "domain": item.id.toString(),
                  "measure": item.debitnode2,
                },
              );
            }

            showModalBottomSheet(
              context: Get.context!,
              backgroundColor: Colors.transparent,
              builder: (context) => Container(
                height: .8.sh,
                padding: EdgeInsets.all(10.r),
                color: white,
                child: Column(
                  children: [
                    20.verticalSpace,
                    Text(
                      i == 0 ? "Data Node PCR" : "Data Node Wisma Atlet",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: .3.sh,
                      width: 1.sw,
                      child: DChartBar(
                        data: i == 0
                            ? [
                                {
                                  'id': 'nodePcr',
                                  'data': dataNodePcr,
                                },
                                {
                                  'id': 'nodeWismaAtlet',
                                  'data': dataNodePcrDebit,
                                },
                              ]
                            : [
                                {
                                  'id': 'nodePcr',
                                  'data': dataNodeWismaAtlet,
                                },
                                {
                                  'id': 'nodeWismaAtlet',
                                  'data': dataNodeWismaAtletDebit,
                                },
                              ],
                        domainLabelPaddingToAxisLine: 16,
                        axisLineTick: 2,
                        axisLinePointTick: 2,
                        axisLinePointWidth: 10,
                        axisLineColor: Colors.green,
                        measureLabelPaddingToAxisLine: 16,
                        barColor: (barData, index, id) {
                          if (id == 'nodePcr') {
                            return Colors.green;
                          } else if (id == 'debitPcr') {
                            return Colors.red;
                          } else if (id == 'nodeWismaAtlet') {
                            return Colors.orange;
                          } else {
                            return Colors.blue;
                          }
                        },
                        showBarValue: true,
                      ),
                    ),
                    20.verticalSpace,
                    Text(
                      "Update Terakhir",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      i == 0
                          ? controller.iotMapPoints.titikPcr!.last.tanggal1
                              .toString()
                          : controller
                              .iotMapPoints.titikWismaAtlet!.last.tanggal2
                              .toString(),
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }
  }
}

class InfoWidget extends StatelessWidget {
  const InfoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.info_outline),
      onPressed: () {
        Get.bottomSheet(
          Container(
            height: .3.sh,
            width: .5.sw,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.w),
              color: Colors.white,
            ),
            child: Column(
              children: [
                TextBold(
                  text: 'Informasi',
                  fontSize: 20,
                  textColour: Colors.black,
                ),
                Row(
                  children: [
                    Image(
                      image: CachedNetworkImageProvider(
                        'https://img.icons8.com/ios-filled/50/4a90e2/marker.png',
                      ),
                      height: 64,
                    ),
                    TextMedium(text: "Titik banjir yang dilaporkan masyarakat"),
                  ],
                ),
                Row(
                  children: [
                    Image(
                      image: CachedNetworkImageProvider(
                        'https://img.icons8.com/ios-filled/50/fa314a/marker.png',
                      ),
                      height: 64,
                    ),
                    Flexible(
                      child: TextMedium(
                          text:
                              "Titik Kerusakan drainase yang dilaporkan masyarakat"),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Image(
                      image: CachedNetworkImageProvider(
                        'https://img.icons8.com/ios/50/000000/squiggly-line.png',
                      ),
                      height: 64,
                    ),
                    Flexible(
                      child: TextMedium(text: "Jalur Drainase Kota Pekanbaru"),
                    ),
                  ],
                ),
              ],
            ).paddingAll(20.r),
          ),
        );
      },
    );
  }
}
