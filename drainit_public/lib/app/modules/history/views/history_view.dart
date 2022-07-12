// ignore_for_file: parameter_assignments

import 'package:cached_network_image/cached_network_image.dart';
import 'package:drainit_flutter/app/components/constant.dart';
import 'package:drainit_flutter/app/components/rounded_button.dart';
import 'package:drainit_flutter/app/components/text_default.dart';
import 'package:drainit_flutter/app/modules/history/controllers/history_controller.dart';
import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:drainit_flutter/app/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:maps_launcher/maps_launcher.dart';

class HistoryView extends GetView<HistoryController> {
  @override
  Widget build(BuildContext context) {
    final selectedFilter = controller.selectedFilter.value;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: appBarGradient(),
        leading: IconButton(
          iconSize: 24.sp,
          icon: Icon(
            Icons.adaptive.arrow_back_outlined,
            color: black,
          ),
          onPressed: () {
            Get.offAllNamed(Routes.HOMEPAGE);
          },
        ),
        title: const TextBold(
          text: "Riwayat Laporan",
          textColour: black,
        ),
        elevation: 0,
        backgroundColor: white,
        centerTitle: false,
      ),
      backgroundColor: Colors.white,
      body: WillPopScope(
        onWillPop: () async {
          Get.offAllNamed(Routes.HOMEPAGE);
          return false;
        },
        child: RefreshIndicator(
          onRefresh: () => controller.loadHistory(),
          child: Column(
            children: [
              buildHeader(context, selectedFilter).paddingAll(10.r),
              Flexible(
                child: buildHistoryReactive(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column buildHeader(BuildContext context, String selectedFilter) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => showSearch(
                context: context,
                delegate: HistorySearchDelegate(controller),
              ),
              child: Container(
                width: 0.6.sw,
                height: ScreenUtil().setHeight(50),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(
                    ScreenUtil().setWidth(10),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Cari",
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(15),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Icon(Icons.search),
                  ],
                ).paddingAll(10.r),
              ),
            ),
            Container(
              height: ScreenUtil().setHeight(50),
              width: 0.15.sw,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(
                  ScreenUtil().setWidth(15),
                ),
              ),
              child: Center(
                child: PopupMenuButton(
                  icon: const Icon(Icons.sort_outlined, color: black),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  onSelected: (value) {
                    if (value == "semua") {
                      selectedFilter = "semua";

                      controller.sortHistory(value.toString());
                    } else if (value == "terbaru") {
                      selectedFilter = "terbaru";
                      controller.sortHistory(value.toString());
                    } else if (value == "terlama") {
                      selectedFilter = "terlama";

                      controller.sortHistory(value.toString());
                    } else if (value == "status") {
                      selectedFilter = "status";

                      controller.sortHistory(value.toString());
                    } else if (value == "jenis") {
                      selectedFilter = "jenis";
                      controller.sortHistory(value.toString());
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'semua',
                      child: Container(
                        height: 20.h,
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.r,
                          vertical: 5.r,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5.r)),
                          color: selectedFilter == "semua" ? green : white,
                        ),
                        child: Text(
                          'Semua',
                          style: TextStyle(
                            color: selectedFilter == "semua" ? white : black,
                            fontSize: 10.sp,
                          ),
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      value: 'terbaru',
                      child: Container(
                        height: 20.h,
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.r,
                          vertical: 5.r,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5.r)),
                          color: selectedFilter == "terbaru" ? green : white,
                        ),
                        child: Text(
                          'Terbaru',
                          style: TextStyle(
                            color: selectedFilter == "terbaru" ? white : black,
                            fontSize: 10.sp,
                          ),
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      value: 'terlama',
                      child: Container(
                        height: 20.h,
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.r,
                          vertical: 5.r,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5.r)),
                          color: selectedFilter == "terlama" ? green : white,
                        ),
                        child: Text(
                          'Terlama',
                          style: TextStyle(
                            color: selectedFilter == "terlama" ? white : black,
                            fontSize: 10.sp,
                          ),
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      value: 'status',
                      child: Container(
                        height: 20.h,
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.r,
                          vertical: 5.r,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5.r)),
                          color: selectedFilter == "status" ? green : white,
                        ),
                        child: Text(
                          'Status',
                          style: TextStyle(
                            color: selectedFilter == "status" ? white : black,
                            fontSize: 10.sp,
                          ),
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      value: 'jenis',
                      child: Container(
                        height: 20.h,
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.r,
                          vertical: 5.r,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5.r)),
                          color: selectedFilter == "jenis" ? green : white,
                        ),
                        child: Text(
                          'Jenis',
                          style: TextStyle(
                            color: selectedFilter == "jenis" ? white : black,
                            fontSize: 10.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Get.bottomSheet(
                Container(
                  height: 0.2.sh,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      ScreenUtil().setWidth(15),
                    ),
                    color: white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextSemiBold(
                        text: "Total laporan anda",
                        fontSize: 16.sp,
                      ).paddingOnly(bottom: 10.h, top: 10.h),
                      buildUserTotalReport(),
                    ],
                  ).paddingAll(10.r),
                ),
              ),
              child: Container(
                height: ScreenUtil().setHeight(50),
                width: 0.15.sw,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(
                    ScreenUtil().setWidth(15),
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.info_outline,
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ),
          ],
        ),
        15.verticalSpace,
      ],
    );
  }

  Widget buildHistoryReactive() {
    return controller.obx(
      (state) => Scrollbar(
        child: Obx(
          () => ListView.builder(
            itemCount: controller.sortedList.length,
            itemBuilder: (context, index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15.r),
                      child: CachedNetworkImage(
                        imageUrl: controller.sortedList[index].foto!,
                        errorWidget: (context, url, error) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                            color: Colors.grey[300],
                          ),
                        ),
                        width: 1.sw,
                        height: 1.sw / 2,
                        fit: BoxFit.cover,
                        progressIndicatorBuilder: (
                          context,
                          url,
                          downloadProgress,
                        ) =>
                            Center(
                          child: CircularProgressIndicator.adaptive(
                            value: downloadProgress.progress,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.r,
                        vertical: 5.r,
                      ),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.r),
                        ),
                        color: getStatusColor(
                          controller.sortedList[index].status!,
                        ),
                      ),
                      width: 100.w,
                      height: 30.h,
                      child: FittedBox(
                        child: Text(
                          controller.sortedList[index].status!,
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: black,
                          ),
                        ),
                      ),
                    ).paddingOnly(left: 20.w, top: 20.h),
                  ],
                ).marginOnly(bottom: 10.r),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextBold(
                          text: controller.sortedList[index].tipe ?? "no data",
                          fontSize: 12.sp,
                        ),
                        Text(
                          timeAgoSinceDate(
                            controller.sortedList[index].createdAt!,
                          ),
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    10.verticalSpace,
                    TextSemiBold(
                      text:
                          controller.sortedList[index].namaJalan!.split(",")[0],
                      textColour: Colors.grey,
                    ),
                    10.verticalSpace,
                    Row(
                      children: [
                        RoundedButton(
                          text: "Lihat Detail",
                          textColor: black,
                          color: Colors.amber,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp,
                          press: () {
                            Get.toNamed(
                              Routes.DETAIL,
                              arguments: controller.sortedList[index].id,
                            );
                          },
                          height: 50.h,
                          width: 0.7.sw,
                          borderRadius: 10.r,
                        ),
                        10.horizontalSpace,
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: Colors.amberAccent,
                          ),
                          height: 50.h,
                          width: 0.2.sw,
                          child: Center(
                            child: IconButton(
                              icon: const Icon(
                                Icons.map_outlined,
                                color: Colors.black,
                              ),
                              onPressed: () async {
                                final coordinates = geoToLatlong(
                                  controller.sortedList[index].geometry!,
                                );
                                await MapsLauncher.launchCoordinates(
                                  coordinates[0],
                                  coordinates[1],
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    20.verticalSpace,
                  ],
                ),
              ],
            ),
          ),
        ),
      ).paddingSymmetric(horizontal: 15.w),
      onError: (err) => GestureDetector(
        onTap: () => controller.getHistory(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/svg/il_no_internet.svg',
                height: Get.height / 3,
                width: Get.width / 3,
              ),
              SizedBox(height: 20.h),
              TextBold(
                text: "Tidak dapat menjangkau internet",
                fontSize: 16.sp,
                textColour: black,
              ),
              SizedBox(
                height: 10.h,
              ),
              TextRegular(
                text: "Ketuk untuk mencoba lagi!",
                fontSize: 12.sp,
                textColour: Colors.black38,
              )
            ],
          ),
        ),
      ),
      onLoading: Center(
        child: SizedBox(
          height: 300.h,
          width: 300.w,
          child: Lottie.asset(
            "assets/lottie/loading_animation.json",
          ),
        ),
      ),
    );
  }

  Row buildUserTotalReport() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 2,
          child: Container(
            height: 80.h,
            decoration: BoxDecoration(
              border: Border.all(
                color: primary,
                width: 2.r,
              ),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextSemiBold(
                  text: controller.list.length.toString(),
                  fontSize: 30.sp,
                ).paddingOnly(top: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.send_rounded,
                      color: black,
                      size: 13.r,
                    ),
                    3.horizontalSpace,
                    TextSemiBold(
                      text: "total laporan",
                      textColour: black,
                      textAlign: TextAlign.center,
                      fontSize: 12.sp,
                    ),
                  ],
                ),
                spacer,
              ],
            ),
          ).paddingOnly(left: 10.w, top: 10.h),
        ),
        Container(
          height: 80.h,
          width: 0.25.sw,
          decoration: BoxDecoration(
            border: Border.all(
              color: primary,
              width: 2.r,
            ),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextSemiBold(
                text: controller.list
                    .where((p0) => p0.status != "DONE")
                    .length
                    .toString(),
                fontSize: 30.sp,
              ).paddingOnly(top: 10.h),
              FittedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.history_rounded,
                      color: black,
                      size: 13.r,
                    ),
                    3.horizontalSpace,
                    TextSemiBold(
                      text: "Diproses",
                      textColour: black,
                      textAlign: TextAlign.center,
                      fontSize: 12.sp,
                    ),
                  ],
                ),
              ).paddingOnly(left: 3.w, right: 3.w),
              spacer,
            ],
          ),
        ).paddingOnly(left: 10.w, top: 10.h),
        Container(
          height: 80.h,
          width: 0.25.sw,
          decoration: BoxDecoration(
            border: Border.all(
              color: primary,
              width: 2.r,
            ),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextSemiBold(
                text: controller.list
                    .where((p0) => p0.status == "DONE")
                    .length
                    .toString(),
                fontSize: 30.sp,
              ).paddingOnly(top: 10.h),
              FittedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      color: black,
                      size: 13.r,
                    ),
                    3.horizontalSpace,
                    TextSemiBold(
                      text: "Selesai",
                      textColour: black,
                      textAlign: TextAlign.center,
                      fontSize: 12.sp,
                    ),
                  ],
                ),
              ).paddingOnly(left: 3.w, right: 3.w),
              spacer,
            ],
          ),
        ).paddingOnly(left: 10.w, top: 10.h),
      ],
    );
  }
}

class BuildHistoryList extends StatelessWidget {
  const BuildHistoryList({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final HistoryController controller;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: controller.foundList.value.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => controller.foundList.value.isNotEmpty
          ? ListTile(
              dense: true,
              contentPadding: EdgeInsets.symmetric(
                vertical: 10.h,
              ),
              isThreeLine: true,
              onTap: () {
                Get.toNamed(
                  Routes.DETAIL,
                  arguments: controller.foundList.value[index].id,
                );
              },
              title: Text(
                " ${controller.foundList.value[index].namaJalan!}",
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ).paddingAll(5.r),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                          color: getStatusColor(
                            controller.foundList.value[index].status!,
                          ),
                        ),
                        child: Text(
                          controller.foundList.value[index].status!,
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
                            controller.foundList.value[index].tipe!,
                          ),
                        ),
                        child: Text(
                          controller.foundList.value[index].tipe!,
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  5.verticalSpace,
                  Text(
                    timeAgoSinceDate(
                      controller.foundList.value[index].createdAt!,
                    ),
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ).paddingAll(5.r),
              trailing: Image(
                image: CachedNetworkImageProvider(
                  controller.foundList.value[index].foto!,
                ),
                height: 50,
                width: 50,
                fit: BoxFit.fill,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.error),
              ),
            ).paddingSymmetric(horizontal: 10.w)
          : Center(
              child: Text(
                "Tidak ada laporan yang ditemukan",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ),
    );
  }
}
