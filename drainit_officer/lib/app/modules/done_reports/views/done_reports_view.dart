import 'package:cached_network_image/cached_network_image.dart';
import 'package:drainit_petugas/app/routes/app_pages.dart';
import 'package:drainit_petugas/app/utils/text_default.dart';
import 'package:drainit_petugas/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';
import '../controllers/done_reports_controller.dart';

class DoneReportsView extends GetView<DoneReportsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 0.5.sh,
            width: 1.sw,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  primary,
                  orange,
                  primary,
                ],
              ),
            ),
            child: Container(
              height: Get.statusBarHeight,
              width: 1.sw,
              child: SafeArea(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.adaptive.arrow_back_outlined,
                            color: white,
                          ),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                        TextBold(
                          text: 'Laporan Selesai',
                          fontSize: 16.sp,
                          textColour: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 0.88.sh,
              width: 1.sw,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.w),
                  topRight: Radius.circular(30.w),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    height: 40,
                    width: 1.sw,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextBold(
                          text: controller.list.length.toString() + " Laporan",
                          fontSize: 16.sp,
                          textColour: Colors.black,
                        ),
                        PopupMenuButton(
                          icon: Icon(Icons.filter_list, color: black),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          onSelected: (value) {
                            // if (value == "semua") {
                            //   selectedFilter = "semua";
                            //   controller.sortHistory(value.toString());
                            // } else if (value == "terbaru") {
                            //   selectedFilter = "terbaru";
                            //
                            //   controller.sortHistory(value.toString());
                            // } else if (value == "terlama") {
                            //   selectedFilter = "terlama";
                            //
                            //   controller.sortHistory(value.toString());
                            // } else if (value == "status") {
                            //   selectedFilter = "status";
                            //
                            //   controller.sortHistory(value.toString());
                            // } else if (value == "jenis") {
                            //   selectedFilter = "jenis";
                            //   controller.sortHistory(value.toString());
                            // }
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 'semua',
                              child: Container(
                                height: 20.h,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.r, vertical: 5.r),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.r)),
                                  //color: selectedFilter == "semua" ? green : white,
                                ),
                                child: Text(
                                  'Semua',
                                  style: TextStyle(
                                    //color: selectedFilter == "semua" ? white : black,
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
                                    horizontal: 10.r, vertical: 5.r),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.r)),
                                  //color: selectedFilter == "terbaru" ? green : white,
                                ),
                                child: Text(
                                  'Terbaru',
                                  style: TextStyle(
                                    //color: selectedFilter == "terbaru" ? white : black,
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
                                    horizontal: 10.r, vertical: 5.r),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.r)),
                                  //color: selectedFilter == "terlama" ? green : white,
                                ),
                                child: Text(
                                  'Terlama',
                                  style: TextStyle(
                                    //color: selectedFilter == "terlama" ? white : black,
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
                                    horizontal: 10.r, vertical: 5.r),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.r)),
                                  //color: selectedFilter == "status" ? green : white,
                                ),
                                child: Text(
                                  'Status',
                                  style: TextStyle(
                                    //color: selectedFilter == "status" ? white : black,
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
                                    horizontal: 10.r, vertical: 5.r),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.r)),
                                  // color: selectedFilter == "jenis" ? green : white,
                                ),
                                child: Text(
                                  'Jenis',
                                  style: TextStyle(
                                    //color: selectedFilter == "jenis" ? white : black,
                                    fontSize: 10.sp,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ).paddingOnly(
                    top: 20.h,
                    left: 25.w,
                    right: 20.w,
                  ),
                  Flexible(
                    child: ListView.builder(
                      padding: EdgeInsets.only(
                        top: 0.h,
                      ),
                      itemCount: controller.list.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 1.sw,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.w),
                            border: Border.all(
                              color: Colors.grey[300]!,
                              width: 1.w,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextMedium(
                                    text: controller.list[index].namaJalan!
                                        .split(",")[0],
                                    fontSize: 12.sp,
                                    textColour: Colors.black,
                                  ),
                                  Container(
                                    height: 20.h,
                                    width: 80.w,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(10.w),
                                    ),
                                    child: Center(
                                      child: TextMedium(
                                        text: controller.list[index].status!,
                                        fontSize: 7.sp,
                                        textColour: white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              TextMedium(
                                text: controller.list[index].status!,
                                fontSize: 11.sp,
                                textColour: Colors.grey[500],
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
                                    minRadius: 18.r,
                                  ),
                                  10.horizontalSpace,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextBold(
                                        text:
                                            controller.list[index].namaPelapor!,
                                      ),
                                      TextRegular(
                                        text: "Pelapor",
                                        textColour: Colors.grey,
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  TextMedium(
                                    text: timeAgoSinceDate(
                                      controller.list[index].createdAt!,
                                    ),
                                  ),
                                ],
                              ),
                              20.verticalSpace,
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15.w),
                                child: CachedNetworkImage(
                                  imageUrl: Routes.IMAGEURL +
                                      controller.list[index].foto!,
                                  fit: BoxFit.cover,
                                  width: 1.sw,
                                  height: 150.h,
                                ),
                              ),
                              20.verticalSpace,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () =>
                                        Get.toNamed(Routes.DETAIL, arguments: [
                                      controller.list[index].id!,
                                      controller.list[index].geometry!,
                                    ]),
                                    child: Container(
                                      height: 30.h,
                                      width: 0.4.sw,
                                      decoration: BoxDecoration(
                                        color: Colors.amberAccent,
                                        borderRadius:
                                            BorderRadius.circular(10.w),
                                      ),
                                      child: Center(
                                        child: TextMedium(
                                          text: "Detail",
                                          fontSize: 12.sp,
                                          textColour: white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(
                                        () => HeroPhotoViewRouteWrapper(
                                          maxScale: 3.0,
                                          minScale: 0.5,
                                          imageProvider:
                                              CachedNetworkImageProvider(
                                            Routes.IMAGEURL +
                                                controller.list[index].foto!,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: 30.h,
                                      width: 0.35.sw,
                                      decoration: BoxDecoration(
                                        color: Colors.amber,
                                        borderRadius:
                                            BorderRadius.circular(10.w),
                                      ),
                                      child: Center(
                                        child: TextMedium(
                                          text: "Ke Lokasi",
                                          fontSize: 12.sp,
                                          textColour: white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ).paddingSymmetric(horizontal: 20.w, vertical: 15.h),
                        ).paddingSymmetric(horizontal: 20.w, vertical: 10.h);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<RefreshIndicator> buildRefreshIndicator() async {
    return RefreshIndicator(
      onRefresh: () async {
        await controller.loadReports();
      },
      child: Scrollbar(
        child: oldView(),
      ),
    );
  }

  ListView oldView() {
    return ListView.builder(
      itemBuilder: (_, index) {
        return ListTile(
          dense: true,
          onTap: () {
            Get.toNamed(Routes.DETAIL, arguments: [
              controller.list[index].id,
              controller.list[index].geometry,
            ]);
          },
          isThreeLine: true,
          title: TextBold(
            text: 'Laporan ${controller.list[index].namaJalan}',
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.verticalSpace,
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.r,
                      vertical: 5.r,
                    ),
                    alignment: Alignment.center,
                    height: 25.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.r),
                      ),
                      color: getStatusColor(
                        controller.list[index].tipe!,
                      ),
                    ),
                    child: Text(
                      controller.list[index].tipe!,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  10.horizontalSpace,
                  TextThin(
                    text: timeAgoSinceDate(
                        controller.list[index].createdAt.toString(),
                        numericDates: true),
                    textColour: Colors.grey,
                  ),
                ],
              ),
              20.verticalSpace,
              ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.r),
                ),
                child: Image(
                  image: CachedNetworkImageProvider(
                      Routes.IMAGEURL + controller.list[index].foto!),
                  height: Get.width / 2,
                  width: Get.width,
                  fit: BoxFit.cover,
                ),
              ),
              20.verticalSpace,
              Divider(
                height: 1.h,
                color: Colors.grey,
              ),
            ],
          ),
        ).paddingAll(10.r);
      },
      itemCount: controller.list.length,
    );
  }
}
