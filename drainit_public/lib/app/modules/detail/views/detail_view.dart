import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:drainit_flutter/app/components/constant.dart';
import 'package:drainit_flutter/app/components/status_enum.dart';
import 'package:drainit_flutter/app/components/text_default.dart';
import 'package:drainit_flutter/app/modules/detail/controllers/detail_controller.dart';
import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:drainit_flutter/app/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DetailView extends GetView<DetailController> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    final Completer<GoogleMapController> _googleMapsController = Completer();
    return WillPopScope(
      onWillPop: () async {
        Get.parameters['type'] != null
            ? Get.offAllNamed(Routes.HISTORY)
            : Get.back();
        return false;
      },
      child: SafeArea(
        top: false,
        //double scaffold to make bottomNavigationBar stick to keyboard when appearing
        child: Scaffold(
          body: Obx(
            () => Scaffold(
              bottomNavigationBar:
                  //check if the user is the one who reported the laporan and if the status is done
                  controller.detail.value.status == ReportTypes.DONE &&
                          controller.detail.value.idMasyarakat ==
                              controller.box.read(Routes.USER_ID)
                      ? Container(
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
                                    color: Colors.amberAccent,
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
                        )
                      : const SizedBox(
                          height: 1,
                          width: 1,
                        ),
              appBar: AppBar(
                flexibleSpace: appBarGradient(),
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
                    Get.parameters['type'] != null
                        ? Get.offAllNamed(Routes.HISTORY)
                        : Get.back();
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
                (state) => SafeArea(
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.to(
                                      () => HeroPhotoViewRouteWrapper(
                                        maxScale: 3.0,
                                        minScale: 0.5,
                                        imageProvider:
                                            CachedNetworkImageProvider(
                                          Routes.IMAGEURL +
                                              controller.detail.value.foto!,
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
                                          Routes.IMAGEURL +
                                              controller.detail.value.foto!,
                                        ),
                                        width: 0.9.sw,
                                        height: 300.w,
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                  ),
                                ),
                                10.horizontalSpace,
                                ClipRRect(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.r),
                                  ),
                                  child: SizedBox(
                                    width: 0.9.sw,
                                    height: 300.w,
                                    child: GoogleMap(
                                      initialCameraPosition: CameraPosition(
                                        zoom: 15,
                                        target: controller.geoToLatlong(
                                          controller.detail.value.geometry!,
                                        ),
                                      ),
                                      markers: <Marker>{
                                        Marker(
                                          markerId: const MarkerId("1"),
                                          position: controller.geoToLatlong(
                                            controller.detail.value.geometry!,
                                          ),
                                        )
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ).paddingAll(20.r),
                          ),
                          SizedBox(
                            width: Get.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextSemiBold(
                                  text: "Deskripsi laporan",
                                  fontSize: 18.sp,
                                ),
                                10.verticalSpace,
                                Text(
                                  '${controller.detail.value.deskripsi}',
                                )
                              ],
                            ).paddingOnly(left: 20.w, right: 20.w),
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                child: Icon(
                                  Icons.thumb_up_off_alt_rounded,
                                  color: green2,
                                  size: 16.sp,
                                ),
                              ),
                              10.horizontalSpace,
                              const TextSemiBold(
                                text: "40",
                                textColour: black,
                              ),
                              20.horizontalSpace,
                              Icon(
                                Icons.thumb_down_alt_rounded,
                                color: Colors.grey,
                                size: 16.sp,
                              ),
                              10.horizontalSpace,
                              const TextSemiBold(
                                text: "5",
                                textColour: black,
                              ),
                            ],
                          ).paddingOnly(left: 20.w, right: 20.w, top: 10.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      TextBold(
                                        text: "Aziz Kandias",
                                      ),
                                      TextRegular(
                                        text: "Pelapor",
                                        textColour: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              TextRegular(
                                text: timeAgoSinceDate(
                                  controller.detail.value.createdAt!,
                                ),
                                textColour: Colors.grey,
                              ),
                            ],
                          ).paddingAll(20.r),
                          Container(
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
                                          controller.detail.value.tipe!,
                                        ),
                                      ),
                                      child: Text(
                                        controller.detail.value.tipe!,
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
                                          controller.detail.value.status!,
                                        ),
                                      ),
                                      child: Text(
                                        controller.detail.value.status!,
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          color: white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ).paddingOnly(left: 20.w, right: 20.w),
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
                                  '${controller.detail.value.namaJalan}',
                                )
                              ],
                            ).paddingAll(20.r),
                          ),
                          Visibility(
                            visible: controller.detail.value.status !=
                                "NOT_YET_VERIFIED",
                            child: Container(
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
                                    '${controller.detail.value.namaPelapor}',
                                  )
                                ],
                              ).paddingAll(20.r),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.w,
                              vertical: 10.h,
                            ),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextBold(
                                          text: controller
                                              .detail.value.namaPelapor!,
                                          fontSize: 16.sp,
                                        ),
                                        TextRegular(
                                          text: controller
                                              .detail.value.createdAt!,
                                          fontSize: 14.sp,
                                          textColour: Colors.grey,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                10.verticalSpace,
                                const Text("Anda belum memberikan tanggapan"),
                              ],
                            ),
                          ),
                          const Divider(
                            height: .3,
                            color: Colors.grey,
                          ),
                          const TextBold(text: "Riwayat Update Laporan")
                              .paddingAll(
                            20.r,
                          ),
                          if (controller.updateReport.value.isEmpty)
                            const Center(
                              child: Text("Belum ada update untuk sekarang"),
                            ).paddingAll(20.r),
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
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                            TextRegular(
                                              text:
                                                  "${controller.updateReport.value[i].deskripsi}",
                                              fontSize: 11.sp,
                                              textColour: black,
                                            ),
                                          ],
                                        ).paddingAll(10.r),
                                      ),
                                      TextRegular(
                                        text:
                                            "${controller.updateReport.value[i].waktu}",
                                        fontSize: 11.sp,
                                        textColour: Colors.grey,
                                      ),
                                      5.verticalSpace,
                                      Visibility(
                                        visible: controller
                                                .updateReport.value[i].foto !=
                                            "tidak ada",
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          child: const Image(
                                            image: CachedNetworkImageProvider(
                                              "https://random.imagecdn.app/300/200",
                                            ),
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
      ),
    );
  }
}
