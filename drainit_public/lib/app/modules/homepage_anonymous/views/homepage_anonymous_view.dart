import 'package:drainit_flutter/app/components/constant.dart';
import 'package:drainit_flutter/app/components/text_default.dart';
import 'package:drainit_flutter/app/modules/homepage_anonymous/controllers/homepage_anonymous_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomepageAnonymousView extends GetView<HomepageAnonymousController> {
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
          //controller.loadAllTimeline();
        },
        child: ListView(
          children: [
            10.verticalSpace,
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
          ],
        ).paddingAll(20.r),
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
            onTap: () {},
            child: Container(
              height: 50.h,
              width: 170.w,
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

  Widget buildSearchBar(BuildContext context) {
    return GestureDetector(
      child: Row(
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
        ],
      ),
    );
  }

  PreferredSize buildAppBar() {
    return PreferredSize(
      preferredSize: Size(double.infinity, 100.h),
      child: AnimatedSwitcher(
        duration: const Duration(microseconds: 400),
        child: buildHeader(),
      ),
    );
  }

  Widget buildHeader() {
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
                    text: "Masyarakat",
                    fontSize: 18.sp,
                    textColour: grey700,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.directions_run_outlined,
              color: grey500,
              size: 24.r,
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
}
