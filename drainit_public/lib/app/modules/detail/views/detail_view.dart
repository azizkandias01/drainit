import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:drainit_flutter/app/components/constant.dart';
import 'package:drainit_flutter/app/components/rounded_button.dart';
import 'package:drainit_flutter/app/components/text_poppins.dart';
import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    final Completer<GoogleMapController> _googleMapsController = Completer();
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      builder: () => WillPopScope(
        onWillPop: () async {
          Get.offAllNamed(Routes.HOME, parameters: {'index': "1"});
          return false;
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: controller.obx(
            (state) => SafeArea(
              bottom: false,
              child: CustomScrollView(
                slivers: [
                  const _FlexibleSpaceHeader(),
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _HeaderSliver(),
                  ),
                  // for (var i = 0; i < 10; i++) ...[
                  //   SliverList(
                  //     delegate: SliverChildListDelegate([
                  //       TimelineTile(
                  //         lineXY: 0.3,
                  //         alignment: TimelineAlign.manual,
                  //         endChild: Padding(
                  //           padding: const EdgeInsets.all(8.0),
                  //           child: Container(
                  //             width: 274.w,
                  //             height: 137.w,
                  //             decoration: BoxDecoration(
                  //               borderRadius: BorderRadius.circular(
                  //                 30.r,
                  //               ),
                  //               color: kIconColor,
                  //             ),
                  //             child: Column(
                  //               children: [Text("Laporan $i")],
                  //             ),
                  //           ),
                  //         ),
                  //         startChild: Container(
                  //           color: kIconColor,
                  //           child: Text("Senin"),
                  //         ),
                  //       ),
                  //     ]),
                  //   ),
                  // ],
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        SizedBox(
                          width: Get.width,
                          height: 1000.h,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 30.w,
                              right: 17.w,
                              top: 20.h,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: Get.width,
                                      height: 500.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          30.r,
                                        ),
                                        color: green2,
                                      ),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(20.r),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                30.r,
                                              ),
                                              child: Image(
                                                fit: BoxFit.cover,
                                                image:
                                                    CachedNetworkImageProvider(
                                                  Routes.IMAGEURL +
                                                      controller.detail.foto!,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                TextPoppinsBold(
                                  text: "Lokasi",
                                  textColour: black,
                                  fontSize: 16.sp,
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                SizedBox(
                                  height: 300.h,
                                  width: Get.width,
                                  child: GoogleMap(
                                    initialCameraPosition: CameraPosition(
                                      target: controller.geoToLatlong(
                                          controller.detail.geometry ?? ""),
                                      zoom: 17.0,
                                    ),
                                    onMapCreated:
                                        (GoogleMapController controller) {
                                      if (!_googleMapsController.isCompleted) {
                                        _googleMapsController
                                            .complete(controller);
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            onError: (err) {
              return GestureDetector(
                onTap: () {
                  Get.offNamedUntil(
                    Routes.HOME,
                    ModalRoute.withName(Routes.DETAIL),
                  );
                },
                child: const Center(
                  child: Text("Kembali"),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _FlexibleSpaceHeader extends GetView<DetailController> {
  const _FlexibleSpaceHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 120.h,
      collapsedHeight: 120.h,
      leading: const SizedBox(),
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.only(left: 30.w, right: 30.w),
        collapseMode: CollapseMode.pin,
        title: Stack(
          children: [
            TextPoppinsBold(
              text: "Detail\nLaporan",
              fontSize: 36.sp,
              textColour: black,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: RoundedButton(
                text: "Selesai",
                width: 100.w,
                height: 50.h,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final maxHeaderExtent = 80.0.h;

class _HeaderSliver extends SliverPersistentHeaderDelegate {
  final controller = Get.find<DetailController>();
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final percent = shrinkOffset / maxHeaderExtent;
    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      bottom: 0,
      child: Container(
        height: maxHeaderExtent,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(left: 30.w, right: 30.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RoundedButton(
                text: "Detail",
                width: 80.w,
                height: 40.h,
                color: green2,
                textColor: white,
              ),
              RoundedButton(
                text: "Update Laporan",
                width: 150.w,
                height: 40.h,
                color: green2,
                textColor: white,
              ),
              RoundedButton(
                text: "Feedback",
                width: 100.w,
                height: 40.h,
                color: green2,
                textColor: white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => maxHeaderExtent;

  @override
  // TODO: implement minExtent
  double get minExtent => maxHeaderExtent;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
