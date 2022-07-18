import 'package:cached_network_image/cached_network_image.dart';
import 'package:drainit_petugas/app/modules/done_reports/models/report_model.dart';
import 'package:drainit_petugas/app/modules/homepage/models/report_model.dart';
import 'package:drainit_petugas/app/routes/app_pages.dart';
import 'package:drainit_petugas/app/utils/constant.dart';
import 'package:drainit_petugas/app/utils/text_default.dart';
import 'package:drainit_petugas/app/utils/utils.dart';
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
      body: Container(
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
          child: RefreshIndicator(
            onRefresh: () async {
              controller.loadAllTimeline();
              controller.profileC.getAccountProfile();
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  topMenu(),
                  bottomMenu(),
                ],
              ),
            ),
          )),
    );
  }

  Widget bottomMenu() {
    return controller.obx(
      (state) {
        return bottomWidget(controller.allTimelineList);
      },
      onLoading: loadingPlaceholder(),
      onEmpty: IconButton(
          onPressed: () async {
            controller.loadAllTimeline();
            controller.profileC.getAccountProfile();
          },
          icon: Icon(Icons.refresh_outlined)),
      onError: (err) => Container(
        width: 1.sw,
        height: .7.sh,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                err ?? "Belum ada laporan untuk saat ini",
                style: TextStyle(color: orange),
              ),
            ),
            IconButton(
                onPressed: () async {
                  controller.loadAllTimeline();
                  controller.profileC.getAccountProfile();
                },
                icon: Icon(Icons.refresh))
          ],
        ),
      ),
    );
  }

  Widget topMenu() {
    return Container(
      width: 1.sw,
      decoration: BoxDecoration(),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headerProfile().paddingSymmetric(vertical: 10.h),
            menuRow().paddingOnly(bottom: 15.h, top: 10.h),
          ],
        ).paddingOnly(left: 20.w, right: 20.w, bottom: 10.h),
      ),
    );
  }

  Widget bottomWidget(List<ReportModel> snapshot) {
    return Container(
      width: 1.sw,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
          Column(
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
            ],
          ),
          snapshot.isNotEmpty
              ? GridView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10.w,
                    crossAxisSpacing: 10.h,
                    childAspectRatio: (1 / 1.4),
                  ),
                  itemBuilder: (_, index) => GestureDetector(
                    onTap: () => Get.toNamed(Routes.DETAIL, arguments: [
                      snapshot[index].id,
                      snapshot[index].geometry,
                    ]),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15.r),
                          child: CachedNetworkImage(
                            imageUrl: snapshot[index].foto.toString(),
                            fit: BoxFit.cover,
                            width: 1.sw,
                            height: 1.sh,
                            errorWidget: (context, url, error) => Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.r),
                                color: Colors.grey[200],
                              ),
                              height: 1.sh,
                              width: 1.sw,
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
                                color: getStatusColor(
                                    snapshot[index].status.toString()),
                              ),
                              child: Center(
                                child: TextBold(
                                  text: snapshot[index].status.toString(),
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
                              width: 50.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5.r),
                                ),
                                color: getStatusColor(
                                    snapshot[index].tipe.toString()),
                              ),
                              child: Center(
                                child: TextBold(
                                  text: snapshot[index].tipe.toString(),
                                  textColour: white,
                                  fontSize: 7.sp,
                                ),
                              ),
                            ),
                          ],
                        ).paddingOnly(top: 15.h, left: 15.w),
                        Positioned(
                          bottom: 0,
                          child: FittedBox(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.thumb_up_off_alt_rounded,
                                  color: Colors.blue,
                                  size: 16.sp,
                                ),
                                10.horizontalSpace,
                                TextBold(
                                  text: "${snapshot[index].upvote}",
                                  textColour: white,
                                ),
                              ],
                            ),
                          ).paddingOnly(left: 15.w, top: 20.h, bottom: 40.h),
                        ),
                        Positioned(
                          bottom: 20.h,
                          left: 15.w,
                          child: TextMedium(
                            text:
                                snapshot[index].namaJalan?.split(",")[0] ?? "",
                            textColour: white,
                            fontSize: 10.sp,
                          ),
                        )
                      ],
                    ),
                  ),
                  itemCount: snapshot.length,
                )
              : Center(
                  child: TextBold(
                    text: "Belum ada pengaduan",
                    fontSize: 16.sp,
                    textColour: orange,
                  ),
                ).paddingOnly(top: 20.h, left: 20.w, right: 20.w),
        ],
      ).paddingSymmetric(horizontal: 20.w, vertical: 10.h),
    );
  }

  Card cardItem(AsyncSnapshot<List<Report>> snapshot, int index) {
    return Card(
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
                      imageUrl: snapshot.data?[index].foto.toString() ?? "",
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
                          text: snapshot.data?[index].statusPengaduan
                                  .toString() ??
                              "",
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
                          text: snapshot.data?[index].tipePengaduan
                                  .toString()
                                  .toUpperCase() ??
                              "",
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
                    text: "${snapshot.data?[index].namaJalan?.split(",")[0]} "
                        ", "
                        "${snapshot.data?[index].namaJalan?.split(",")[1]}",
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextMedium(text: "Deskripsi", fontSize: 10.sp),
                      TextRegular(
                          overflow: TextOverflow.ellipsis,
                          text: snapshot.data?[index].deskripsiPengaduan
                                  ?.toString() ??
                              "",
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
    );
  }

  Align loadingPlaceholder() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 0.70.sh,
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

  Container overviewCard() {
    var totalDoneReports = controller.allTimelineList
        .where((element) => element.status == done)
        .length;
    var totalReports = controller.allTimelineList.length;
    var totalDoneReportsPercentage = (totalDoneReports / totalReports) * 100;
    var totalDoneReportsPercentageText =
        '${totalDoneReportsPercentage.toStringAsFixed(0)}%';
    var totalProcessesReport = controller.allTimelineList
        .where((element) => element.status != done)
        .length;
    var totalProcessesReportPercentage =
        (totalProcessesReport / totalReports) * 100;
    var totalProcessesReportPercentageText =
        '${totalProcessesReportPercentage.toStringAsFixed(0)}%';

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
        //TODO update from on progress to done
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
                      value: totalProcessesReportPercentage > 0
                          ? totalProcessesReportPercentage / 100
                          : 0,
                      backgroundColor: grey[300],
                      valueColor: AlwaysStoppedAnimation(Colors.orange),
                    ),
                  ).paddingOnly(bottom: 7.h),
                  TextMedium(
                      text: "$totalProcessesReport Diproses",
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
                    text: totalProcessesReportPercentage > 0
                        ? totalProcessesReportPercentageText
                        : "0%",
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
                      value: totalDoneReportsPercentage > 1
                          ? totalDoneReportsPercentage / 100
                          : 0,
                      backgroundColor: grey[300],
                      valueColor: AlwaysStoppedAnimation(Colors.blue),
                    ),
                  ).paddingOnly(bottom: 7.h),
                  TextMedium(
                      text: "$totalDoneReports Selesai",
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
                    text: totalDoneReportsPercentage > 0
                        ? totalDoneReportsPercentageText
                        : "0%",
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

  Widget headerProfile() {
    return controller.profileC.obx(
      (state) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextMedium(
                      text: controller.profileC.profile.data?.nama ?? "",
                      fontSize: 20.sp,
                      textColour: white)
                  .paddingOnly(bottom: 5.h),
              TextMedium(
                text: "Status : ${controller.profileC.profile.data?.status}",
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
                backgroundImage: Image.network(
                        controller.profileC.profile.data?.foto.toString() ?? "")
                    .image,
              ),
            ),
          ),
        ],
      ),
      onLoading: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Shimmer.fromColors(
                highlightColor: Colors.grey[300]!,
                baseColor: Colors.grey[100]!,
                child: Container(
                  width: 0.5.sw,
                  height: 20.h,
                  decoration: BoxDecoration(
                    color: grey,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                ),
              ),
              10.verticalSpace,
              Shimmer.fromColors(
                highlightColor: Colors.grey[300]!,
                baseColor: Colors.grey[100]!,
                child: Container(
                  width: 0.5.sw,
                  height: 20.h,
                  decoration: BoxDecoration(
                    color: grey,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                ),
              ),
            ],
          ),
          CircleAvatar(
            radius: 28,
            backgroundColor: white,
            child: CircleAvatar(
              radius: 25,
              child: Shimmer.fromColors(
                highlightColor: Colors.grey[300]!,
                baseColor: Colors.grey[100]!,
                child: Container(
                  decoration: BoxDecoration(
                    color: grey,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
