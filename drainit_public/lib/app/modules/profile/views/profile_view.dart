// ignore_for_file: avoid_print

import 'package:drainit_flutter/app/components/constant.dart';
import 'package:drainit_flutter/app/modules/edit_password/views/edit_password_view.dart';
import 'package:drainit_flutter/app/modules/edit_profile/views/edit_profile_view.dart';
import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
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
        body: controller.obx(
          (state) => SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              child: SizedBox(
                height: ScreenUtil().setHeight(1000),
                child: Column(
                  children: [
                    //TOP BAR
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     IconButton(
                    //       icon: const Icon(
                    //         LineIcons.arrowLeft,
                    //         color: white,
                    //       ),
                    //       onPressed: () => Get.back(),
                    //     ),
                    //     IconButton(
                    //       onPressed: () {},
                    //       icon: const Icon(
                    //         LineIcons.verticalEllipsis,
                    //         color: white,
                    //       ),
                    //     ),
                    //   ],
                    // ),
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
                                  controller.dataProfile.foto!.contains('.jp')
                                      ? Routes.IMAGEURL +
                                          controller.dataProfile.foto!
                                      : 'https://random.imagecdn.app/500/150',
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
                              spacer,
                              PopupMenuButton<int>(
                                icon: Icon(
                                  Icons.adaptive.more,
                                  color: white,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                itemBuilder: (BuildContext context) =>
                                    <PopupMenuItem<int>>[
                                  PopupMenuItem<int>(
                                    value: 1,
                                    child: TextPoppinsRegular(
                                      text: 'Edit Password',
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                  PopupMenuItem<int>(
                                    value: 2,
                                    child: TextPoppinsRegular(
                                      text: 'Edit Profile',
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                  PopupMenuItem<int>(
                                    value: 3,
                                    child: TextPoppinsRegular(
                                      text: 'Logout',
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ],
                                onSelected: (int value) {
                                  if (value == 1) {
                                    Get.to(EditPasswordView());
                                  } else if (value == 2) {
                                    Get.to(EditProfileView());
                                  } else if (value == 3) {
                                    controller.logoutAccount();
                                  }
                                },
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
                        child: Padding(
                          padding: EdgeInsets.all(30.r),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextPoppinsBold(
                                text: 'Laporan Terbaru',
                                fontSize: 20.sp,
                                textColour: green,
                              ),
                              Flexible(
                                child: ListView.separated(
                                  itemBuilder: (_, __) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 30.r,
                                            backgroundColor: green,
                                            child: Icon(
                                              Icons.person,
                                              color: white,
                                              size: 30.sp,
                                            ),
                                          ),
                                          SizedBox(
                                            width: ScreenUtil().setWidth(20),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              TextPoppinsRegular(
                                                text: "12 hours ago",
                                                fontSize: 12.sp,
                                                textColour: Colors.grey[400],
                                              ),
                                              SizedBox(
                                                height:
                                                    ScreenUtil().setHeight(10),
                                              ),
                                              TextPoppinsBold(
                                                text: "Zeekands",
                                                fontSize: 12.sp,
                                                textColour: black,
                                              ),
                                              SizedBox(
                                                height:
                                                    ScreenUtil().setHeight(10),
                                              ),
                                              Row(
                                                children: [
                                                  TextPoppinsRegular(
                                                    text: "melaporkan",
                                                    fontSize: 11.sp,
                                                    textColour: black,
                                                  ),
                                                  SizedBox(
                                                    width: ScreenUtil()
                                                        .setWidth(10),
                                                  ),
                                                  TextPoppinsBold(
                                                    text: "banjir  ",
                                                    fontSize: 11.sp,
                                                    textColour: black,
                                                  ),
                                                  Icon(
                                                    LineIcons.water,
                                                    color: green,
                                                    size: 11.sp,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  itemCount: 20,
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return Divider(
                                      color: Colors.grey[300],
                                      thickness: 1.r,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          onError: (err) => GestureDetector(
            onTap: () => controller.getAccountProfile(),
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
                  TextPoppinsBold(
                    text: "Tidak dapat menjangkau internet",
                    fontSize: 16.sp,
                    textColour: black,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextPoppinsRegular(
                    text: "Ketuk untuk mencoba lagi!",
                    fontSize: 12.sp,
                    textColour: Colors.black38,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
