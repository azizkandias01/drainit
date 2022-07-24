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
        child: Scaffold(
          body: Obx(
            () => Scaffold(
              bottomNavigationBar:
                  controller.detail.value.status == ReportTypes.DONE &&
                          controller.detail.value.idMasyarakat ==
                              controller.box.read(Routes.USER_ID) &&
                          controller.detail.value.feedbackMasyarakat!.isEmpty
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
                                  controller: controller.feedbackController,
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
                                onTap: () {
                                  //TODO test this
                                  controller.feedbackMasyarakat(
                                    controller.feedbackController.text,
                                  );
                                  Get.back();
                                  controller.feedbackController.clear();
                                },
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
                                          controller.detail.value.foto
                                              .toString(),
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
                                          controller.detail.value.foto
                                              .toString(),
                                        ),
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Container(
                                            width: 0.9.sw,
                                            height: 300.w,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10.r),
                                              ),
                                              color: Colors.grey,
                                            ),
                                          );
                                        },
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
                                          controller.detail.value.geometry
                                              .toString(),
                                        ),
                                      ),
                                      markers: <Marker>{
                                        Marker(
                                          markerId: const MarkerId("1"),
                                          position: controller.geoToLatlong(
                                            controller.detail.value.geometry
                                                .toString(),
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
                                  color: Colors.blue,
                                  size: 24.sp,
                                ),
                              ),
                              10.horizontalSpace,
                              TextSemiBold(
                                text: "${controller.detail.value.upvote}",
                                textColour: black,
                              ),
                            ],
                          ).paddingOnly(left: 20.w, right: 20.w, top: 10.h),
                          if (controller.detail.value.petugas!.isNotEmpty)
                            Builder(
                              builder: (context) {
                                final petugas =
                                    controller.detail.value.petugas!.length;
                                var namaPetugas = "";
                                for (var i = 0; i < petugas; i++) {
                                  namaPetugas +=
                                      "${controller.detail.value.petugas![i].namaPetugas}";
                                  if (i < petugas - 1) {
                                    namaPetugas += ", ";
                                  }
                                }
                                return Row(
                                  children: [
                                    const TextRegular(
                                      text: "Ditangani oleh",
                                      textColour: Colors.grey,
                                    ),
                                    10.horizontalSpace,
                                    TextSemiBold(
                                      text: namaPetugas,
                                      textColour: Colors.grey,
                                    ),
                                  ],
                                ).paddingSymmetric(
                                  horizontal: 20.w,
                                  vertical: 10.h,
                                );
                              },
                            )
                          else
                            const SizedBox(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  // CircleAvatar(
                                  //   backgroundImage: NetworkImage(
                                  //     controller.dataProfile.data!.foto!,
                                  //   ),
                                  //   backgroundColor: Colors.amber,
                                  //   minRadius: 20.r,
                                  // ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextBold(
                                        text: controller
                                                .detail.value.namaPelapor ??
                                            "anonymous",
                                      ),
                                      const TextRegular(
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
                                  text: "Lokasi Laporan",
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
                                    controller.detail.value.namaPelapor ??
                                        "anonymous",
                                  )
                                ],
                              ).paddingAll(20.r),
                            ),
                          ),
                          if (controller.detail.value.feedbackMasyarakat! !=
                              "null")
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20.w,
                                vertical: 10.h,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const TextBold(
                                    text: "Tanggapan Pelapor",
                                  ),
                                  20.verticalSpace,
                                  Row(
                                    children: [
                                      //FIXME: FOTO PELAPOR HARUS DIKIRIM DARI SERVER DAN HARUS BERUPA IMAGE tapi auth tidak memungkinkan
                                      // CircleAvatar(
                                      //   backgroundImage: NetworkImage(
                                      //     controller.dataProfile.data!.foto!,
                                      //   ),
                                      //   backgroundColor: Colors.amber,
                                      //   minRadius: 20.r,
                                      // ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextBold(
                                            text: controller
                                                    .detail.value.namaPelapor ??
                                                "anonymous",
                                            fontSize: 16.sp,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  10.verticalSpace,
                                  Text(
                                    controller.detail.value.feedbackMasyarakat
                                        .toString(),
                                  ),
                                ],
                              ),
                            )
                          else
                            const SizedBox(),
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
                                            "${controller.updateReport.value[i].createdAt}",
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
                                          child: Image(
                                            image: NetworkImage(
                                              controller.updateReport.value[i]
                                                      .foto ??
                                                  "",
                                            ),
                                            errorBuilder: (_, __, ___) =>
                                                const SizedBox(),
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
                      Get.back();
                    },
                    child: Center(
                      child: Text(err.toString()),
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
