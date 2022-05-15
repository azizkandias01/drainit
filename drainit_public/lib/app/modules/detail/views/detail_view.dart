import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:drainit_flutter/app/components/constant.dart';
import 'package:drainit_flutter/app/components/text_default.dart';
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
    return WillPopScope(
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
              title: TextMedium(
                text: "Detail Laporan",
                fontSize: 18.sp,
              ),
              centerTitle: true,
              toolbarHeight: 50.h,
              leading: IconButton(
                iconSize: 24.sp,
                icon: Icon(
                  Icons.adaptive.arrow_back_outlined,
                  color: black,
                ),
                onPressed: () {
                  Get.offAllNamed(Routes.HOME, parameters: {'index': "1"});
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
                              const TextBold(
                                text: "Aziz Kandias",
                              ),
                              TextRegular(
                                text: timeAgoSinceDate(
                                  controller.detail.createdAt!,
                                ),
                                textColour: Colors.grey,
                              ),
                            ],
                          ),
                        ],
                      ).paddingOnly(left: 20.w, right: 20.w, bottom: 10.h),
                      Container(
                        decoration: const BoxDecoration(
                          border: Border.fromBorderSide(
                            BorderSide(
                              color: Colors.grey,
                              width: .3,
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TextBold(
                              text: "Jenis Dan Status Laporan",
                            ),
                            20.verticalSpace,
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 5.r,
                                    vertical: 5.r,
                                  ),
                                  alignment: Alignment.center,
                                  height: 30.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5.r),
                                    ),
                                    color: getStatusColor(
                                      controller.detail.tipePengaduan!,
                                    ),
                                  ),
                                  child: Text(
                                    controller.detail.tipePengaduan!,
                                    style: TextStyle(
                                      fontSize: 13.sp,
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
                                  alignment: Alignment.center,
                                  height: 30.h,
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
                                      fontSize: 13.sp,
                                      color: white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ).paddingAll(20.r),
                      ),
                      Container(
                        width: Get.width,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey,
                              width: .3,
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TextBold(
                              text: "Deskripi Laporan",
                            ),
                            10.verticalSpace,
                            Text(
                              '${controller.detail.deskripsiPengaduan}',
                            )
                          ],
                        ).paddingAll(20.r),
                      ),
                      Container(
                        width: Get.width,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey,
                              width: .3,
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TextBold(
                              text: "Nama Jalan",
                            ),
                            10.verticalSpace,
                            Text(
                              '${controller.detail.namaJalan}',
                            )
                          ],
                        ).paddingAll(20.r),
                      ),
                      Container(
                        width: Get.width,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey,
                              width: .3,
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TextBold(
                              text: "Laporan Ditangani Oleh",
                            ),
                            10.verticalSpace,
                            Text(
                              '${controller.detail.namaPetugas}',
                            )
                          ],
                        ).paddingAll(20.r),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey,
                              width: .3,
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TextBold(
                              text: "Foto dan Lokasi Laporan",
                            ),
                            10.verticalSpace,
                            GestureDetector(
                              onTap: () {
                                Get.to(
                                  () => HeroPhotoViewRouteWrapper(
                                    maxScale: 3.0,
                                    minScale: 0.5,
                                    imageProvider: CachedNetworkImageProvider(
                                      Routes.IMAGEURL + controller.detail.foto!,
                                    ),
                                  ),
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.r),
                                ),
                                child: Hero(
                                  tag: "image",
                                  child: Image(
                                    image: CachedNetworkImageProvider(
                                      Routes.IMAGEURL + controller.detail.foto!,
                                    ),
                                    width: Get.width,
                                    height: 200.w,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              ),
                            ),
                            20.verticalSpace,
                            ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.r),
                              ),
                              child: SizedBox(
                                width: Get.width,
                                height: 200.w,
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
                            ),
                          ],
                        ).paddingAll(20.r),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 10.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TextBold(
                              text: "Tanggapan Anda",
                            ),
                            20.verticalSpace,
                            Row(
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
                                    TextBold(
                                      text: controller.detail.namaPelapor!,
                                      fontSize: 16.sp,
                                    ),
                                    TextRegular(
                                      text: controller.detail.createdAt!,
                                      fontSize: 14.sp,
                                      textColour: Colors.grey,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            10.verticalSpace,
                            Text(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        height: .3,
                        color: Colors.grey,
                      ),
                      const TextBold(text: "Riwayat Update Laporan").paddingAll(
                        20.r,
                      ),
                      if (controller.updateReport.value.isEmpty)
                        const Center(
                                child: Text("Belum ada update untuk sekarang"))
                            .paddingAll(20.r),
                      for (int i = 0;
                          i < controller.updateReport.value.length;
                          i++)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundImage: const CachedNetworkImageProvider(
                                "https://i.pravatar.cc/300",
                              ),
                              backgroundColor: Colors.amber,
                              minRadius: 20.r,
                            ),
                            10.horizontalSpace,
                            Flexible(
                              child: Column(
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
                            ),
                          ],
                        ).paddingOnly(left: 20.w, right: 20.w, top: 10.h),
                    ],
                  ),
                ),
              ),
              onLoading: const Center(
                child: CircularProgressIndicator.adaptive(),
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
    );
  }
}
