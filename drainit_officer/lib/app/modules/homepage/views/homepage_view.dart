import 'package:cached_network_image/cached_network_image.dart';
import 'package:drainit_petugas/app/modules/done_reports/models/report_model.dart';
import 'package:drainit_petugas/app/routes/app_pages.dart';
import 'package:drainit_petugas/app/utils/text_default.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/colors.dart';
import '../controllers/homepage_controller.dart';

class HomepageView extends GetView<HomepageController> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      body: Stack(
        children: [
          topMenu(),
          bottomMenu(),
        ],
      ),
    );
  }

  FutureBuilder<List<Report>> bottomMenu() {
    return FutureBuilder<List<Report>>(
      future: controller.doneReportsController.getDoneReports(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return loadingPlaceholder();
        } else if (snapshot.hasData) {
          return bottomWidget(snapshot);
        } else {
          return Center(
            child: TextMedium(
              text: "Tidak ada pengaduan",
              fontSize: 20.sp,
            ),
          );
        }
      },
    );
  }

  Align bottomWidget(AsyncSnapshot<List<Report>> snapshot) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 0.75.sh,
        width: 1.sw,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.verticalSpace,
            TextBold(
              text: "OVERVIEW",
              fontSize: 14.sp,
              textColour: black,
            ),
            10.verticalSpace,
            overviewCard(),
            20.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextBold(text: "Pengaduan Baru", fontSize: 16.sp),
                GestureDetector(
                  onTap: () => Get.toNamed(Routes.DONE_REPORTS),
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.amber,
                  ),
                ),
              ],
            ),
            15.verticalSpace,
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                addAutomaticKeepAlives: true,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => Get.toNamed(Routes.DETAIL, arguments: [
                      snapshot.data![index].id,
                      snapshot.data![index].geometry,
                    ]),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.r),
                      ),
                      child: SizedBox(
                        width: 0.55.sw,
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                SizedBox(
                                  width: 0.6.sw,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.r),
                                      topRight: Radius.circular(20.r),
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: Routes.IMAGEURL +
                                          snapshot.data![index].foto!,
                                      fit: BoxFit.fill,
                                      width: 0.6.sw,
                                      height: 0.29.sh,
                                    ),
                                  ),
                                ),
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
                                        color: Colors.amber,
                                      ),
                                      child: Center(
                                        child: TextBold(
                                          text: snapshot
                                              .data![index].statusPengaduan!,
                                          fontSize: 7.sp,
                                          textColour: white,
                                        ),
                                      ),
                                    ),
                                    5.horizontalSpace,
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
                                        color: Colors.blue,
                                      ),
                                      child: Center(
                                        child: TextBold(
                                          text: snapshot
                                              .data![index].tipePengaduan!
                                              .toUpperCase(),
                                          textColour: white,
                                          fontSize: 7.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                ).paddingOnly(top: 15.h, left: 15.w),
                                Positioned(
                                  bottom: 10.h,
                                  left: 10.w,
                                  child: TextMedium(
                                    text: snapshot.data![index].namaJalan!
                                            .split(",")[0] +
                                        ", " +
                                        snapshot.data![index].namaJalan!
                                            .split(",")[1],
                                    textColour: white,
                                    fontSize: 10.sp,
                                  ),
                                )
                              ],
                            ),
                            Flexible(
                              child: Container(
                                width: 0.6.sw,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: white,
                                      borderRadius: BorderRadius.circular(
                                        10.r,
                                      )),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      TextMedium(
                                          text: "Deskripsi", fontSize: 10.sp),
                                      TextRegular(
                                          overflow: TextOverflow.ellipsis,
                                          text: snapshot
                                              .data![index].deskripsiPengaduan!,
                                          fontSize: 10.sp),
                                    ],
                                  ).paddingSymmetric(
                                    horizontal: 10.w,
                                    vertical: 10.h,
                                  ),
                                ).paddingAll(15.r),
                              ),
                            )
                          ],
                        ),
                      ),
                    ).paddingOnly(right: 10.w, bottom: 5.h),
                  );
                },
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 20.w, vertical: 10.h),
      ),
    );
  }

  Align loadingPlaceholder() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 0.75.sh,
        width: 1.sw,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Shimmer.fromColors(
              highlightColor: Colors.grey[300]!,
              baseColor: Colors.grey[100]!,
              child: Container(
                width: 0.9.sw,
                height: 40.h,
                decoration: BoxDecoration(
                  color: grey,
                  borderRadius: BorderRadius.circular(15.r),
                ),
              ),
            ),
            20.verticalSpace,
            Shimmer.fromColors(
              highlightColor: Colors.grey[300]!,
              baseColor: Colors.grey[100]!,
              child: Container(
                width: 0.9.sw,
                height: 0.2.sh,
                decoration: BoxDecoration(
                  color: grey,
                  borderRadius: BorderRadius.circular(15.r),
                ),
              ),
            ),
            20.verticalSpace,
            Shimmer.fromColors(
              highlightColor: Colors.grey[300]!,
              baseColor: Colors.grey[100]!,
              child: Container(
                width: 0.9.sw,
                height: 40.h,
                decoration: BoxDecoration(
                  color: grey,
                  borderRadius: BorderRadius.circular(15.r),
                ),
              ),
            ),
            10.verticalSpace,
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Shimmer.fromColors(
                    highlightColor: Colors.grey[300]!,
                    baseColor: Colors.grey[200]!,
                    child: SizedBox(
                      width: 0.6.sw,
                      child: Column(
                        children: [
                          Container(
                            width: 0.6.sw,
                            height: 0.28.sh,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15.r),
                                topRight: Radius.circular(15.r),
                              ),
                              color: grey[300],
                            ),
                          ),
                          Flexible(
                            child: Container(
                              width: 0.6.sw,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20.r),
                                  bottomRight: Radius.circular(20).r,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ).paddingOnly(right: 10.w, bottom: 5.h),
                  );
                },
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 20.w, vertical: 15.h),
      ),
    );
  }

  Container topMenu() {
    return Container(
      height: 0.55.sh,
      width: 1.sw,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            primary,
            Colors.orange,
            primary,
          ],
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headerProfile().paddingSymmetric(vertical: 10.h),
            menuRow().paddingOnly(bottom: 15.h, top: 10.h),
          ],
        ).paddingSymmetric(horizontal: 20.w),
      ),
    );
  }

  Container overviewCard() {
    return Container(
      width: 1.sw,
      height: 0.2.sh,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: white,
        border: Border.all(
          color: Colors.grey[300]!,
          width: 1.w,
        ),
      ),
      child: Column(
        children: [
          10.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextBold(text: "Laporan Aktif", fontSize: 14.sp)
                      .paddingOnly(bottom: 7.h),
                  SizedBox(
                    width: 0.6.sw,
                    child: LinearProgressIndicator(
                      value: 0.7,
                      backgroundColor: grey[300],
                      valueColor: AlwaysStoppedAnimation(Colors.orange),
                    ),
                  ).paddingOnly(bottom: 7.h),
                  TextMedium(
                      text: "16 Diproses",
                      fontSize: 14.sp,
                      textColour: Colors.orange),
                ],
              ),
              Container(
                width: 50.w,
                height: 50.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.amber,
                      Colors.orange,
                    ],
                  ),
                ),
                child: Center(
                  child: TextMedium(
                    text: "60%",
                    fontSize: 14.sp,
                    textColour: white,
                  ),
                ),
              ),
            ],
          ).paddingSymmetric(horizontal: 20.w, vertical: 10.h),
          Divider(
            color: grey[300],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextBold(text: "Laporan Selesai", fontSize: 14.sp)
                      .paddingOnly(bottom: 7.h),
                  SizedBox(
                    width: 0.6.sw,
                    child: LinearProgressIndicator(
                      value: 0.3,
                      backgroundColor: grey[300],
                      valueColor: AlwaysStoppedAnimation(Colors.blue),
                    ),
                  ).paddingOnly(bottom: 7.h),
                  TextMedium(
                      text: "4 Selesai",
                      fontSize: 14.sp,
                      textColour: Colors.blue),
                ],
              ),
              Container(
                width: 50.w,
                height: 50.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.lightBlue,
                      Colors.blueAccent,
                    ],
                  ),
                ),
                child: Center(
                  child: TextBold(
                    text: "30%",
                    fontSize: 14.sp,
                    textColour: white,
                  ),
                ),
              ),
            ],
          ).paddingSymmetric(
            horizontal: 20.w,
          ),
        ],
      ),
    );
  }

  Row menuRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Get.toNamed(Routes.PROCESSED_REPORTS),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              width: 100.w,
              height: 60.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.list_outlined, color: Colors.orange, size: 20.sp),
                  5.verticalSpace,
                  TextMedium(
                    text: "Laporan Aktif",
                    fontSize: 11.sp,
                    textColour: Colors.orange,
                  ),
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => Get.toNamed(Routes.DONE_REPORTS),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              width: 100.w,
              height: 60.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle_outline,
                      color: Colors.orange, size: 20.sp),
                  5.verticalSpace,
                  TextMedium(
                    text: "Laporan Selesai",
                    fontSize: 11.sp,
                    textColour: Colors.orange,
                  ),
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => Get.toNamed(Routes.MAPS),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              width: 100.w,
              height: 60.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.map_outlined, color: Colors.orange, size: 20.sp),
                  5.verticalSpace,
                  TextMedium(
                    text: "Peta Titik",
                    fontSize: 11.sp,
                    textColour: Colors.orange,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row headerProfile() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextMedium(
                    text: "David Alexander", fontSize: 20.sp, textColour: white)
                .paddingOnly(bottom: 5.h),
            TextMedium(
              text: "PUPR (Available)",
              fontSize: 12.sp,
              textColour: white,
            ),
          ],
        ),
        GestureDetector(
          onTap: () => Get.toNamed(Routes.PROFILE),
          child: CircleAvatar(
            radius: 28,
            backgroundColor: white,
            child: CircleAvatar(
              radius: 25,
              backgroundImage:
                  Image.network("https://picsum.photos/250?image=9").image,
            ),
          ),
        ),
      ],
    );
  }
}
