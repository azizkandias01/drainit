import 'package:cached_network_image/cached_network_image.dart';
import 'package:drainit_petugas/app/utils/text_default.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';
import '../controllers/homepage_controller.dart';

class HomepageView extends GetView<HomepageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 0.6.sh,
            width: 1.sw,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.amberAccent,
                  Colors.orange,
                  Colors.amberAccent,
                ],
              ),
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: white,
                        child: CircleAvatar(
                          radius: 25,
                          backgroundImage:
                              Image.network("https://picsum.photos/250?image=9")
                                  .image,
                        ),
                      ).paddingOnly(right: 10.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextMedium(
                                  text: "David Alexander",
                                  fontSize: 20.sp,
                                  textColour: white)
                              .paddingOnly(bottom: 5.h),
                          TextMedium(
                            text: "PUPR (Petugas)",
                            fontSize: 12.sp,
                            textColour: white,
                          ),
                        ],
                      )
                    ],
                  ).paddingOnly(bottom: 20.h),
                  TextBold(
                    text: "OVERVIEW",
                    fontSize: 14.sp,
                    textColour: white,
                  ).paddingOnly(bottom: 20.h),
                  Container(
                    width: 1.sw,
                    height: 0.2.sh,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: white,
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
                                TextBold(text: "Diproses", fontSize: 14.sp)
                                    .paddingOnly(bottom: 7.h),
                                SizedBox(
                                  width: 0.6.sw,
                                  child: LinearProgressIndicator(
                                    value: 0.7,
                                    backgroundColor: grey[300],
                                    valueColor:
                                        AlwaysStoppedAnimation(Colors.orange),
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
                                TextBold(text: "Selesai", fontSize: 14.sp)
                                    .paddingOnly(bottom: 7.h),
                                SizedBox(
                                  width: 0.6.sw,
                                  child: LinearProgressIndicator(
                                    value: 0.3,
                                    backgroundColor: grey[300],
                                    valueColor:
                                        AlwaysStoppedAnimation(Colors.blue),
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
                          vertical: 5.h,
                        ),
                      ],
                    ),
                  ).paddingOnly(bottom: 20.h),
                  Center(
                    child: SizedBox(
                      height: 60.h,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 100.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: white,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.check_circle,
                                    color: Colors.orange, size: 20.sp),
                                5.verticalSpace,
                                TextMedium(
                                  text: "Semua Laporan",
                                  fontSize: 11.sp,
                                  textColour: Colors.orange,
                                ),
                              ],
                            ),
                          ).marginOnly(right: 10.w);
                        },
                      ),
                    ),
                  ),
                ],
              ).paddingSymmetric(horizontal: 20.w),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 0.5.sh,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextBold(text: "Pengaduan Baru", fontSize: 16.sp),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.amber,
                      ),
                    ],
                  ).paddingOnly(bottom: 20.h),
                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: 0.58.sw,
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          "https://picsum.photos/250?image=10",
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 5.r,
                                          vertical: 5.r,
                                        ),
                                        height: 25.h,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(5.r),
                                          ),
                                          color: Colors.amber,
                                        ),
                                        child: Text(
                                          "ON_PROGRESS",
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            color: white,
                                          ),
                                        ),
                                      ),
                                      5.horizontalSpace,
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 5.r,
                                          vertical: 5.r,
                                        ),
                                        height: 25.h,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(5.r),
                                          ),
                                          color: Colors.blue,
                                        ),
                                        child: Text(
                                          "Banjir",
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            color: white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ).paddingOnly(top: 12.h, left: 10.w),
                                ],
                              ),
                              Flexible(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ).paddingOnly(right: 10.w, bottom: 5.h);
                      },
                    ),
                  ),
                ],
              ).paddingSymmetric(horizontal: 20.w, vertical: 30.h),
            ),
          ),
        ],
      ),
    );
  }
}
