// ignore_for_file: avoid_print

import 'package:drainit_flutter/app/components/constant.dart';
import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

import '../../../components/text_poppins.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: designSize,
      builder: () => Scaffold(
        backgroundColor: Colors.green[600],
        body: SafeArea(
          child: controller.obx(
            (state) => SingleChildScrollView(
              child: SizedBox(
                height: ScreenUtil().setHeight(1000),
                child: Column(
                  children: [
                    //TOP BAR
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(
                            LineIcons.arrowLeft,
                            color: white,
                          ),
                          onPressed: () => Get.back(),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            LineIcons.verticalEllipsis,
                            color: white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    //PROFILE IMAGE
                    Padding(
                      padding: EdgeInsets.only(left: 30.w, right: 30.w),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                maxRadius: ScreenUtil().setWidth(40),
                                minRadius: ScreenUtil().setWidth(40),
                                backgroundImage: NetworkImage(
                                  controller.dataProfile.foto!.contains('.j')
                                      ? Routes.IMAGEURL +
                                          controller.dataProfile.foto!
                                      : 'defaultbanjir.png',
                                ),
                                backgroundColor: green,
                              ),
                              SizedBox(
                                width: 30.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.dataProfile.nama!,
                                    style: GoogleFonts.montserrat(
                                      fontSize: ScreenUtil().setSp(30),
                                      fontWeight: FontWeight.bold,
                                      color: white,
                                    ),
                                  ),
                                  TextPoppinsRegular(
                                    text: controller.dataProfile.email!,
                                    fontSize: 20.sp,
                                    textColour: white,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.phone,
                                    color: white,
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Text(
                                    controller.dataProfile.noHp ?? "no_data",
                                    style: GoogleFonts.montserrat(
                                      fontSize: ScreenUtil().setSp(16),
                                      color: white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          //ADDRESS & EDIT BUTTON
                          Row(
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.place,
                                    color: white,
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Text(
                                    controller.dataProfile.alamat ?? "no_data",
                                    style: GoogleFonts.montserrat(
                                      fontSize: ScreenUtil().setSp(16),
                                      color: white,
                                    ),
                                  ),
                                ],
                              ),
                              spacer,
                              Container(
                                width: Get.width / 4,
                                height: 30.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: white,
                                ),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        LineIcons.pen,
                                        color: green,
                                        size: 20.sp,
                                      ),
                                      SizedBox(
                                        width: 3.w,
                                      ),
                                      Text(
                                        'Edit',
                                        style: GoogleFonts.montserrat(
                                          fontSize: ScreenUtil().setSp(16),
                                          fontWeight: FontWeight.bold,
                                          color: green,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          //REPORT SUMMARY
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextPoppinsBold(
                                    text: 'Total Laporan',
                                    fontSize: 15.sp,
                                    textColour: Colors.white,
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setHeight(5),
                                  ),
                                  TextPoppinsBold(
                                    text: "50",
                                    fontSize: 30.sp,
                                    textColour: Colors.white,
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Container(
                                width: ScreenUtil().setWidth(1),
                                height: ScreenUtil().setHeight(50),
                                color: white,
                              ),
                              const Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextPoppinsBold(
                                    text: 'Selesai',
                                    fontSize: 15.sp,
                                    textColour: Colors.white,
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setHeight(5),
                                  ),
                                  TextPoppinsBold(
                                    text: "23",
                                    fontSize: 30.sp,
                                    textColour: Colors.white,
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Container(
                                width: ScreenUtil().setWidth(1),
                                height: ScreenUtil().setHeight(50),
                                color: Colors.grey[300],
                              ),
                              const Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextPoppinsBold(
                                    text: 'Proses',
                                    fontSize: 15.sp,
                                    textColour: white,
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setHeight(5),
                                  ),
                                  TextPoppinsBold(
                                    text: "27",
                                    fontSize: 30.sp,
                                    textColour: white,
                                  ),
                                ],
                              ),
                              const Spacer(),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(20),
                    ),
                    Flexible(
                      child: Container(
                        width: Get.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.r),
                            topRight: Radius.circular(20.r),
                          ),
                        ),
                        child: Container(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            onError: (err) {
              return Center(
                child: Text('Cannot Retrieve data error : $err'),
              );
            },
          ),
        ),
      ),
    );
  }
}
