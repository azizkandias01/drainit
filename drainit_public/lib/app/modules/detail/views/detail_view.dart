import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:drainit_flutter/app/components/constant.dart';
import 'package:drainit_flutter/app/components/text_poppins.dart';
import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:drainit_flutter/app/utils/Utils.dart';
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
      builder: (context) => WillPopScope(
        onWillPop: () async {
          Get.offAllNamed(Routes.HOME, parameters: {'index': "1"});
          return false;
        },
        child: SafeArea(
          top: false,
          //double scaffold to make bottomNavigationBar stick to keyboard when appearing
          child: Scaffold(
            body: Scaffold(
              bottomNavigationBar: Container(
                height: ScreenUtil().setHeight(50),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey,
                      width: 0.5,
                    ),
                  ),
                ),
                width: Get.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10,
                          ),
                          hintText: "Beri tanggapan",
                          hintStyle: TextStyle(
                            fontSize: ScreenUtil().setSp(11),
                            color: Colors.grey,
                          ),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: ScreenUtil().setSp(14),
                          color: Colors.black,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: ScreenUtil().setHeight(50),
                        width: ScreenUtil().setWidth(50),
                        decoration: const BoxDecoration(
                          color: Colors.green,
                        ),
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                          size: ScreenUtil().setSp(20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
                      Icons.refresh,
                      color: black,
                    ),
                    onPressed: () {
                      controller.getDetail();
                      controller.getUpdate();
                    },
                  )
                ],
              ),
              backgroundColor: Colors.white,
              body: controller.obx(
                (state) => Scrollbar(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: const CachedNetworkImageProvider(
                                "https://i.pravatar.cc/300",
                              ),
                              backgroundColor: Colors.amber,
                              minRadius: 20.r,
                            ),
                            10.horizontalSpace,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextPoppinsBold(
                                  text: "Aziz Kandias",
                                  fontSize: 12.sp,
                                  textColour: black,
                                ),
                                TextPoppinsRegular(
                                  text:
                                      "${timeAgoSinceDate(controller.detail.createdAt!)}",
                                  fontSize: 11.sp,
                                  textColour: Colors.grey,
                                ),
                              ],
                            ),
                          ],
                        ).paddingOnly(left: 20.w, right: 20.w),
                        20.verticalSpace,
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 5.r,
                                vertical: 5.r,
                              ),
                              height: 20.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5.r),
                                ),
                                color:
                                    controller.detail.tipePengaduan == "Banjir"
                                        ? Colors.lightBlue
                                        : Colors.brown,
                              ),
                              child: Text(
                                "${controller.detail.tipePengaduan}",
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: white,
                                ),
                              ),
                            ),
                            10.horizontalSpace,
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 5.r,
                                vertical: 5.r,
                              ),
                              height: 20.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5.r),
                                ),
                                color: getStatusColor(
                                  controller.detail.statusPengaduan!,
                                ),
                              ),
                              child: Text(
                                controller.detail.statusPengaduan!,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: white,
                                ),
                              ),
                            ),
                          ],
                        ).paddingOnly(left: 20.w, right: 20.w),
                        20.verticalSpace,
                        const Text(
                                "Lorem ipsum, atau ringkasnya lipsum, adalah teks standar yang ditempatkan untuk mendemostrasikan elemen grafis atau presentasi visual seperti font, tipografi, dan tata letak.")
                            .paddingOnly(left: 20.w, right: 20.w, bottom: 20.h),
                        // Container(
                        //   height: 60.h,
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.all(
                        //       Radius.circular(10.r),
                        //     ),
                        //     border: Border.all(
                        //       color: Colors.grey,
                        //     ),
                        //   ),
                        //   child: Row(children: [
                        //     Text(
                        //       "${controller.detail.namaJalan}",
                        //       style: TextStyle(
                        //         fontSize: 12.sp,
                        //         color: Colors.grey,
                        //       ),
                        //     ),
                        //   ]),
                        // ).paddingAll(20.r),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.to(
                                  HeroPhotoViewRouteWrapper(
                                    maxScale: 3.0,
                                    minScale: 0.5,
                                    imageProvider: CachedNetworkImageProvider(
                                      Routes.IMAGEURL + controller.detail.foto!,
                                    ),
                                  ),
                                );
                              },
                              child: Hero(
                                tag: "image",
                                child: Image(
                                  image: CachedNetworkImageProvider(
                                    Routes.IMAGEURL + controller.detail.foto!,
                                  ),
                                  width: Get.width / 2,
                                  height: Get.width,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: Get.width / 2,
                              height: Get.width,
                              child: GoogleMap(
                                initialCameraPosition: CameraPosition(
                                    zoom: 15,
                                    target: controller.geoToLatlong(
                                        controller.detail.geometry!)),
                                markers: <Marker>{
                                  Marker(
                                      markerId: MarkerId("1"),
                                      position: controller.geoToLatlong(
                                          controller.detail.geometry!))
                                },
                              ),
                            ),
                          ],
                        ),
                        const Text(
                          "Tanggapan anda 5 hari yang lalu",
                          style: TextStyle(color: Colors.grey),
                        ).paddingOnly(left: 20.w, top: 10.h),
                        Divider(
                          thickness: 1.h,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 10.h),
                          child: Row(
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
                              Flexible(
                                child: AutoSizeText(
                                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                  ),
                                  maxLines: 5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 1.h,
                        ),
                        const Text(
                          "Riwayat Update Laporan Petugas",
                          style: TextStyle(color: Colors.grey),
                        ).paddingOnly(left: 20.w),
                        for (int i = 0;
                            i < controller.updateReport.value.length;
                            i++)
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
                                      borderRadius: BorderRadius.circular(20.r),
                                      color: Colors.grey[200],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${controller.updateReport.value[i].namaPetugas}",
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        5.verticalSpace,
                                        Text(
                                          "Update: ${controller.updateReport.value[i].judul}",
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        5.verticalSpace,
                                        TextPoppinsRegular(
                                          text:
                                              "${controller.updateReport.value[i].deskripsi}",
                                          fontSize: 11.sp,
                                          textColour: black,
                                        ),
                                      ],
                                    ).paddingAll(10.r),
                                  ),
                                  TextPoppinsRegular(
                                    text:
                                        "${controller.updateReport.value[i].waktu}",
                                    fontSize: 11.sp,
                                    textColour: Colors.grey,
                                  ),
                                  5.verticalSpace,
                                  Visibility(
                                    visible:
                                        controller.updateReport.value[i].foto !=
                                            "tidak ada",
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.r),
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
                      ],
                    ),
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
        ),
      ),
    );
  }
}
