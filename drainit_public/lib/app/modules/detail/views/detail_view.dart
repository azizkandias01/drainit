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
import 'package:line_icons/line_icons.dart';

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
          appBar: AppBar(
            backgroundColor: white,
            elevation: 0,
            title: const Text(
              "Detail Laporan",
              style: TextStyle(color: black),
            ),
            centerTitle: true,
            toolbarHeight: 50.h,
            leading: IconButton(
              iconSize: 24.sp,
              icon: const Icon(
                Icons.arrow_back_outlined,
                color: black,
              ),
              onPressed: () {
                print("back");
              },
            ),
            actions: [
              IconButton(
                iconSize: 24.sp,
                icon: const Icon(
                  Icons.more_horiz_outlined,
                  color: black,
                ),
                onPressed: () {
                  print("back");
                },
              )
            ],
          ),
          backgroundColor: Colors.white,
          body: controller.obx(
            (state) => SafeArea(
              bottom: false,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Scrollbar(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    const CachedNetworkImageProvider(
                                  "https://i.pravatar.cc/300",
                                ),
                                backgroundColor: Colors.amber,
                                minRadius: 20.r,
                              ),
                              20.horizontalSpace,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextPoppinsBold(
                                    text: "Aziz Kandias",
                                    fontSize: 12.sp,
                                    textColour: black,
                                  ),
                                  TextPoppinsRegular(
                                    text: "2 minggu lalu",
                                    fontSize: 11.sp,
                                    textColour: Colors.grey,
                                  ),
                                ],
                              ),
                            ],
                          ).paddingOnly(left: 20.w, right: 20.w),
                          20.verticalSpace,
                          Text("Lorem ipsum, atau ringkasnya lipsum, adalah teks standar yang ditempatkan untuk mendemostrasikan elemen grafis atau presentasi visual seperti font, tipografi, dan tata letak.")
                              .paddingOnly(left: 20.w, right: 20.w),
                          20.verticalSpace,
                          20.verticalSpace,
                          Row(
                            children: [
                              Image(
                                image: CachedNetworkImageProvider(
                                  Routes.IMAGEURL + controller.detail.foto!,
                                ),
                                width: Get.width / 2,
                                height: Get.width,
                                fit: BoxFit.fitHeight,
                              ),
                              SizedBox(
                                width: Get.width / 2,
                                height: Get.width,
                                child: GoogleMap(
                                  initialCameraPosition: const CameraPosition(
                                      target: LatLng(0, 0)),
                                  markers: <Marker>{
                                    const Marker(
                                        markerId: MarkerId("1"),
                                        position: LatLng(0, 0))
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      iconSize: 25.sp,
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.thumb_up_off_alt,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    TextPoppinsRegular(
                                      text: "Like",
                                      fontSize: 12.sp,
                                      textColour: Colors.grey,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      iconSize: 25.r,
                                      onPressed: () {},
                                      icon: const Icon(
                                        LineIcons.comment,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    TextPoppinsRegular(
                                      text: "Update",
                                      fontSize: 12.sp,
                                      textColour: Colors.grey,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      iconSize: 25.sp,
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.star_outline,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    TextPoppinsRegular(
                                      text: "Beri rating",
                                      fontSize: 12.sp,
                                      textColour: Colors.grey,
                                    ),
                                  ],
                                ),
                              ],
                            ).paddingOnly(left: 40.w, right: 40.w),
                          ),
                          Divider(
                            thickness: 1.h,
                          ),
                          const Text("Riwayat Update Laporan")
                              .paddingOnly(left: 20.w),
                          for (int i = 0; i <= 10; i++)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      const CachedNetworkImageProvider(
                                    "https://i.pravatar.cc/300",
                                  ),
                                  backgroundColor: Colors.amber,
                                  minRadius: 20.r,
                                ),
                                10.horizontalSpace,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.r),
                                        color: Colors.grey[200],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextPoppinsBold(
                                            text: "Muksim Amin",
                                            fontSize: 12.sp,
                                            textColour: black,
                                          ),
                                          TextPoppinsRegular(
                                            text:
                                                "Mempersiapkan alat dan bahan",
                                            fontSize: 11.sp,
                                            textColour: black,
                                          ),
                                        ],
                                      ).paddingAll(10.r),
                                    ),
                                    TextPoppinsRegular(
                                      text: "1 jam yang lalu",
                                      fontSize: 11.sp,
                                      textColour: Colors.grey,
                                    ),
                                    5.verticalSpace,
                                    Visibility(
                                      visible: i.isOdd,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        child: const Image(
                                          image: CachedNetworkImageProvider(
                                              "https://random.imagecdn.app/300/200"),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ).paddingOnly(left: 20.w, right: 20.w, top: 10.h),
                          50.verticalSpace,
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: Get.width,
                    height: 50.h,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        top: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Container(
                            height: 40.h,
                            color: Colors.grey[200],
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "Tambahkan feedback anda",
                                hintStyle: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.grey,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.send,
                          color: Colors.grey,
                        ),
                      ],
                    ).paddingOnly(left: 20.w, right: 20.w),
                  ),
                ],
              ),
            ),
            //   CustomScrollView(
            //     slivers: [
            //       const _FlexibleSpaceHeader(),
            //       SliverPersistentHeader(
            //         pinned: true,
            //         delegate: _HeaderSliver(),
            //       ),
            //       // for (var i = 0; i < 10; i++) ...[
            //       //   SliverList(
            //       //     delegate: SliverChildListDelegate([
            //       //       TimelineTile(
            //       //         lineXY: 0.3,
            //       //         alignment: TimelineAlign.manual,
            //       //         endChild: Padding(
            //       //           padding: const EdgeInsets.all(8.0),
            //       //           child: Container(
            //       //             width: 274.w,
            //       //             height: 137.w,
            //       //             decoration: BoxDecoration(
            //       //               borderRadius: BorderRadius.circular(
            //       //                 30.r,
            //       //               ),
            //       //               color: kIconColor,
            //       //             ),
            //       //             child: Column(
            //       //               children: [Text("Laporan $i")],
            //       //             ),
            //       //           ),
            //       //         ),
            //       //         startChild: Container(
            //       //           color: kIconColor,
            //       //           child: Text("Senin"),
            //       //         ),
            //       //       ),
            //       //     ]),
            //       //   ),
            //       // ],
            //       SliverList(
            //         delegate: SliverChildListDelegate(
            //           [
            //             SizedBox(
            //               width: Get.width,
            //               height: 1000.h,
            //               child: Padding(
            //                 padding: EdgeInsets.only(
            //                   left: 30.w,
            //                   right: 17.w,
            //                   top: 20.h,
            //                 ),
            //                 child: Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Column(
            //                       crossAxisAlignment: CrossAxisAlignment.start,
            //                       children: [
            //                         Container(
            //                           width: Get.width,
            //                           height: 500.h,
            //                           decoration: BoxDecoration(
            //                             borderRadius: BorderRadius.circular(
            //                               30.r,
            //                             ),
            //                             color: green2,
            //                           ),
            //                           child: Column(
            //                             children: [
            //                               Padding(
            //                                 padding: EdgeInsets.all(20.r),
            //                                 child: ClipRRect(
            //                                   borderRadius:
            //                                       BorderRadius.circular(
            //                                     30.r,
            //                                   ),
            //                                   child: Image(
            //                                     fit: BoxFit.cover,
            //                                     image:
            //                                         CachedNetworkImageProvider(
            //                                       Routes.IMAGEURL +
            //                                           controller.detail.foto!,
            //                                     ),
            //                                   ),
            //                                 ),
            //                               ),
            //                             ],
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                     SizedBox(
            //                       height: 20.h,
            //                     ),
            //                     TextPoppinsBold(
            //                       text: "Lokasi",
            //                       textColour: black,
            //                       fontSize: 16.sp,
            //                     ),
            //                     SizedBox(
            //                       height: 10.h,
            //                     ),
            //                     SizedBox(
            //                       height: 300.h,
            //                       width: Get.width,
            //                       child: GoogleMap(
            //                         initialCameraPosition: CameraPosition(
            //                           target: controller.geoToLatlong(
            //                               controller.detail.geometry ?? ""),
            //                           zoom: 17.0,
            //                         ),
            //                         onMapCreated:
            //                             (GoogleMapController controller) {
            //                           if (!_googleMapsController.isCompleted) {
            //                             _googleMapsController
            //                                 .complete(controller);
            //                           }
            //                         },
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
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
