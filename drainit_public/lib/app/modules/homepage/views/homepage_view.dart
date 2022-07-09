import 'package:cached_network_image/cached_network_image.dart';
import 'package:drainit_flutter/app/components/constant.dart';
import 'package:drainit_flutter/app/components/text_default.dart';
import 'package:drainit_flutter/app/modules/history/controllers/history_controller.dart';
import 'package:drainit_flutter/app/modules/homepage/controllers/homepage_controller.dart';
import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:drainit_flutter/app/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class HomepageView extends GetView<HomepageController> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return Scaffold(
      appBar: buildAppBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          controller.profileC.getAccountProfile();
          controller.historyC.loadHistory();
        },
        child: ListView(
          children: [
            buildSearchBar2(context).paddingOnly(bottom: 20.h),
            Column(
              children: [
                TextSemiBold(
                  text: "Laporkan Banjir atau Drainase rusak",
                  fontSize: 20.sp,
                  textAlign: TextAlign.center,
                ),
                SvgPicture.asset("assets/svg/ic_shocked.svg", height: 300.h),
              ],
            ),
            buildHomeMenu().paddingOnly(bottom: 20.h),
            TextSemiBold(
              text: "Total laporan anda",
              fontSize: 16.sp,
            ).paddingOnly(bottom: 10.h),
            buildUserTotalReport().paddingOnly(bottom: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextSemiBold(
                  text: "Laporan terbaru",
                  fontSize: 16.sp,
                  textColour: Colors.black,
                ),
                TextMedium(
                  text: "lihat semua",
                  fontSize: 12.sp,
                  textColour: textGrey,
                ),
              ],
            ).paddingOnly(bottom: 24.h),
            buildNewReportsReactive().paddingOnly(bottom: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextSemiBold(
                  text: "Semua laporan",
                  fontSize: 16.sp,
                  textColour: Colors.black,
                ),
                TextMedium(
                  text: "lihat semua",
                  fontSize: 12.sp,
                  textColour: textGrey,
                ),
              ],
            ),
            // BuildHistoryListFuture(controller: controller.historyC),
          ],
        ).paddingAll(20.r),
      ),
    );
  }

  Widget buildNewReportsReactive() {
    return controller.obx(
      (state) => SizedBox(
        height: 272.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (ctx, id) {
            return GestureDetector(
              onTap: () {
                Get.toNamed(
                  Routes.DETAIL,
                  arguments: controller.timelineList[id].id,
                );
              },
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: CachedNetworkImage(
                      width: 222.w,
                      height: 272.h,
                      fit: BoxFit.cover,
                      imageUrl: Routes.IMAGEURL +
                          controller.timelineList[id].foto.toString(),
                    ),
                  ),
                  Row(
                    children: [
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
                            controller.timelineList[id].status!,
                          ),
                        ),
                        width: 100.w,
                        height: 30.h,
                        child: FittedBox(
                          child: Text(
                            controller.timelineList[id].status!,
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: black,
                            ),
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
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.r),
                          ),
                          color: getStatusColor(
                            controller.timelineList[id].tipe!,
                          ),
                        ),
                        width: 60.w,
                        height: 30.h,
                        child: FittedBox(
                          child: Text(
                            controller.timelineList[id].tipe!,
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ).paddingOnly(left: 20.w, top: 20.h),
                  Positioned(
                    bottom: 0,
                    child: FittedBox(
                      child: Row(
                        children: [
                          Icon(
                            Icons.thumb_up_off_alt_rounded,
                            color: green2,
                            size: 16.sp,
                          ),
                          10.horizontalSpace,
                          const TextSemiBold(
                            text: "40",
                            textColour: white,
                          ),
                          20.horizontalSpace,
                          Icon(
                            Icons.thumb_down_alt_rounded,
                            color: red,
                            size: 16.sp,
                          ),
                          10.horizontalSpace,
                          const TextSemiBold(
                            text: "5",
                            textColour: white,
                          ),
                        ],
                      ),
                    ).paddingOnly(left: 20.w, top: 20.h, bottom: 45.h),
                  ),
                  Positioned(
                    bottom: 0,
                    child: FittedBox(
                      child: TextSemiBold(
                        text: controller.timelineList[id].namaJalan!
                            .split(",")[0],
                        textColour: white,
                      ),
                    ).paddingOnly(left: 20.w, top: 20.h, bottom: 20.h),
                  ),
                ],
              ).marginOnly(right: 15.w),
            );
          },
          itemCount: controller.timelineList.length,
        ),
      ),
      onLoading: Shimmer.fromColors(
        baseColor: grey,
        highlightColor: grey300,
        child: SizedBox(
          height: 272.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (ctx, id) {
              return Container(
                width: 222.w,
                height: 272.h,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(
                    20.r,
                  ),
                ),
              ).marginOnly(right: 24.w);
            },
            itemCount: 10,
          ),
        ),
      ),
      onError: (e) => Center(
        child: Text(
          e.toString(),
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.red,
          ),
        ),
      ),
      onEmpty: Center(
        child: Text(
          "Tidak ada laporan",
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget buildAllReportsReactive() {
    return controller.obx(
      (state) => SizedBox(
        height: 272.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (ctx, id) {
            return GestureDetector(
              onTap: () {
                Get.toNamed(
                  Routes.DETAIL,
                  arguments: controller.timelineList[id].id,
                );
              },
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: CachedNetworkImage(
                      width: 222.w,
                      height: 272.h,
                      fit: BoxFit.cover,
                      imageUrl: Routes.IMAGEURL +
                          controller.timelineList[id].foto.toString(),
                    ),
                  ),
                  Row(
                    children: [
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
                            controller.timelineList[id].status!,
                          ),
                        ),
                        width: 100.w,
                        height: 30.h,
                        child: FittedBox(
                          child: Text(
                            controller.timelineList[id].status!,
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: black,
                            ),
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
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.r),
                          ),
                          color: getStatusColor(
                            controller.timelineList[id].tipe!,
                          ),
                        ),
                        width: 60.w,
                        height: 30.h,
                        child: FittedBox(
                          child: Text(
                            controller.timelineList[id].tipe!,
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ).paddingOnly(left: 20.w, top: 20.h),
                  Positioned(
                    bottom: 0,
                    child: FittedBox(
                      child: Row(
                        children: [
                          Icon(
                            Icons.thumb_up_off_alt_rounded,
                            color: green2,
                            size: 16.sp,
                          ),
                          10.horizontalSpace,
                          const TextSemiBold(
                            text: "40",
                            textColour: white,
                          ),
                          20.horizontalSpace,
                          Icon(
                            Icons.thumb_down_alt_rounded,
                            color: red,
                            size: 16.sp,
                          ),
                          10.horizontalSpace,
                          const TextSemiBold(
                            text: "5",
                            textColour: white,
                          ),
                        ],
                      ),
                    ).paddingOnly(left: 20.w, top: 20.h, bottom: 45.h),
                  ),
                  Positioned(
                    bottom: 0,
                    child: FittedBox(
                      child: TextSemiBold(
                        text: controller.timelineList[id].namaJalan!
                            .split(",")[0],
                        textColour: white,
                      ),
                    ).paddingOnly(left: 20.w, top: 20.h, bottom: 20.h),
                  ),
                ],
              ).marginOnly(right: 15.w),
            );
          },
          itemCount: controller.timelineList.length,
        ),
      ),
      onLoading: Shimmer.fromColors(
        baseColor: grey,
        highlightColor: grey300,
        child: SizedBox(
          height: 272.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (ctx, id) {
              return Container(
                width: 222.w,
                height: 272.h,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(
                    20.r,
                  ),
                ),
              ).marginOnly(right: 24.w);
            },
            itemCount: 10,
          ),
        ),
      ),
      onError: (e) => Center(
        child: Text(
          e.toString(),
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.red,
          ),
        ),
      ),
      onEmpty: Center(
        child: Text(
          "Tidak ada laporan",
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.grey,
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
                TextSemiBold(text: "20", fontSize: 30.sp)
                    .paddingOnly(top: 10.h),
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
              TextSemiBold(text: "10", fontSize: 30.sp).paddingOnly(top: 10.h),
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
              TextSemiBold(text: "10", fontSize: 30.sp).paddingOnly(top: 10.h),
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

  SizedBox buildHomeMenu() {
    return SizedBox(
      height: 70.h,
      width: 1.sw,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, id) {
          return GestureDetector(
            onTap: () {
              Get.toNamed(
                controller.dataButton[id].route,
                arguments: "login",
              );
            },
            child: Container(
              height: 50.h,
              width: 115.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: controller.dataButton[id].color,
                ),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      controller.dataButton[id].icon,
                      color: white,
                      size: 24.r,
                    ),
                    5.verticalSpace,
                    TextSemiBold(
                      text: controller.dataButton[id].text,
                      textColour: white,
                      textAlign: TextAlign.center,
                      fontSize: 13.sp,
                    ),
                  ],
                ),
              ),
            ).paddingOnly(left: 10.w),
          );
        },
        itemCount: controller.dataButton.length,
      ),
    );
  }

  Row buildSearchBar2(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //search bar
      children: [
        Container(
          width: 0.9.sw,
          height: 48.h,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(
              ScreenUtil().setWidth(10),
            ),
          ),
          child: GestureDetector(
            onTap: () => showSearch(
              context: context,
              delegate: HistorySearchDelegate(controller.historyC),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  size: 24.r,
                  color: grey500,
                ),
                20.horizontalSpace,
                TextMedium(
                  text: "Cari laporan",
                  fontSize: 12.sp,
                  textColour: grey500,
                ),
              ],
            ).paddingAll(10.r),
          ),
        ),
      ],
    );
  }

  PreferredSize buildAppBar() {
    return PreferredSize(
      preferredSize: Size(double.infinity, 100.h),
      child: AnimatedSwitcher(
        duration: const Duration(microseconds: 400),
        child: buildHeaderReactive(),
      ),
    );
  }

  Container buildSearchBar(BuildContext context, HistoryController historyC) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [primary, white],
        ),
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //search bar
          children: [
            Container(
              width: 0.73.sw,
              height: 48.h,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(
                  ScreenUtil().setWidth(10),
                ),
              ),
              child: GestureDetector(
                onTap: () => showSearch(
                  context: context,
                  delegate: HistorySearchDelegate(historyC),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      size: 24.r,
                      color: grey500,
                    ),
                    20.horizontalSpace,
                    TextMedium(
                      text: "Cari laporan",
                      fontSize: 12.sp,
                      textColour: grey500,
                    ),
                  ],
                ).paddingAll(10.r),
              ),
            ),
            Image.asset(
              "assets/image/ic_filter.png",
              height: ScreenUtil().setHeight(48),
              width: ScreenUtil().setWidth(48),
            ),
          ],
        ).paddingOnly(
          left: 20.w,
          right: 20.w,
          top: 10.h,
          bottom: 10.h,
        ),
      ),
    );
  }

  Widget buildHeaderReactive() {
    return controller.profileC.obx(
      (state) => Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [primary, white],
          ),
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FittedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextMedium(
                      text: "Halo,",
                      textColour: black,
                      fontSize: 17.sp,
                    ),
                    TextSemiBold(
                      text:
                          controller.profileC.dataProfile.data!.nama.toString(),
                      fontSize: 18.sp,
                      textColour: grey700,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.PROFILE);
                },
                child: CircleAvatar(
                  radius: 25.r,
                  backgroundImage: CachedNetworkImageProvider(
                    Routes.IMAGEURL +
                        controller.profileC.dataProfile.data!.foto.toString(),
                  ),
                ),
              ),
            ],
          ).paddingOnly(
            left: 20.w,
            right: 20.w,
            top: 10.h,
            bottom: 10.h,
          ),
        ),
      ),
      onLoading: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [primary, white],
          ),
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FittedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Shimmer.fromColors(
                      baseColor: grey,
                      highlightColor: grey300,
                      child: SizedBox(
                        height: ScreenUtil().setHeight(10),
                        width: ScreenUtil().setWidth(50),
                        child: Container(
                          color: grey,
                          height: 10.h,
                          width: 0.3.sw,
                        ),
                      ),
                    ),
                    10.verticalSpace,
                    Shimmer.fromColors(
                      baseColor: grey,
                      highlightColor: grey300,
                      child: SizedBox(
                        height: ScreenUtil().setHeight(10),
                        width: ScreenUtil().setWidth(70),
                        child: Container(
                          color: grey,
                          height: 10.h,
                          width: 0.2.sw,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Shimmer.fromColors(
                baseColor: grey,
                highlightColor: grey300,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    ScreenUtil().setWidth(50),
                  ),
                  child: Container(
                    width: ScreenUtil().setWidth(50),
                    height: ScreenUtil().setHeight(50),
                    color: Colors.grey[100],
                  ),
                ),
              ),
            ],
          ).paddingOnly(
            left: 20.w,
            right: 20.w,
            top: 10.h,
            bottom: 10.h,
          ),
        ),
      ),
      onEmpty: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [primary, white],
          ),
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FittedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextMedium(
                      text: "no data",
                      textColour: black,
                      fontSize: 17.sp,
                    ),
                    TextSemiBold(
                      text: "no data",
                      fontSize: 18.sp,
                      textColour: grey700,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.PROFILE);
                },
                child: CircleAvatar(
                  radius: 25.r,
                  backgroundImage: CachedNetworkImageProvider(
                    Routes.IMAGEURL +
                        "controller.profileC.dataProfile.data!.foto.toString()",
                  ),
                ),
              ),
            ],
          ).paddingOnly(
            left: 20.w,
            right: 20.w,
            top: 10.h,
            bottom: 10.h,
          ),
        ),
      ),
      onError: (err) => Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [primary, white],
          ),
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FittedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextMedium(
                      text: "no data error",
                      textColour: black,
                      fontSize: 17.sp,
                    ),
                    TextSemiBold(
                      text: "no data",
                      fontSize: 18.sp,
                      textColour: grey700,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.PROFILE);
                },
                child: CircleAvatar(
                  radius: 25.r,
                  backgroundImage: CachedNetworkImageProvider(
                    Routes.IMAGEURL + "",
                  ),
                ),
              ),
            ],
          ).paddingOnly(
            left: 20.w,
            right: 20.w,
            top: 10.h,
            bottom: 10.h,
          ),
        ),
      ),
    );
  }
}
