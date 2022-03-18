// ignore_for_file: avoid_print

import 'package:drainit_flutter/app/components/constant.dart';
import 'package:drainit_flutter/app/components/rounded_button.dart';
import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:drainit_flutter/app/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../components/text_poppins.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) => ScreenUtilInit(
        designSize: const Size(414, 896),
        builder: () => Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
                child: Column(
                  children: [
                    CircleAvatar(
                      maxRadius: ScreenUtil().setWidth(50),
                      backgroundImage: NetworkImage(
                        controller.dataProfile.foto!.contains('.j')
                            ? imagePath() + controller.dataProfile.foto!
                            : 'defaultbanjir.png',
                      ),
                      onBackgroundImageError: (object, trace) {
                        print('error object');
                      },
                    ),
                    SizedBox(height: 20.h),
                    TextPoppinsBold(
                      text: controller.dataProfile.nama!,
                      fontSize: 25.sp,
                    ),
                    TextPoppinsBold(
                      text: controller.dataProfile.email!,
                      fontSize: 15.sp,
                      textColour: Colors.grey[500],
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(10),
                    ),
                    TextPoppinsBold(
                      text: controller.dataProfile.alamat!,
                      fontSize: 15.sp,
                      textColour: Colors.grey[500],
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(20),
                    ),
                    Row(
                      children: [
                        Container(
                          width: ScreenUtil().setWidth(250),
                          height: ScreenUtil().setHeight(50),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: green,
                          ),
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(10),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.logoutAccount();
                          },
                          child: Container(
                            width: ScreenUtil().setWidth(100),
                            height: ScreenUtil().setHeight(50),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: green,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(20),
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextPoppinsBold(
                              text: 'Total Laporan',
                              fontSize: 15.sp,
                              textColour: Colors.grey[500],
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(5),
                            ),
                            TextPoppinsBold(
                              text: "50",
                              fontSize: 30.sp,
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
                              text: 'Selesai',
                              fontSize: 15.sp,
                              textColour: Colors.grey[500],
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(5),
                            ),
                            TextPoppinsBold(
                              text: "23",
                              fontSize: 30.sp,
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
                              textColour: Colors.grey[500],
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(5),
                            ),
                            TextPoppinsBold(
                              text: "27",
                              fontSize: 30.sp,
                            ),
                          ],
                        ),
                        const Spacer(),
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(20),
                    ),
                    TextPoppinsBold(
                      text: 'Laporan Terbaru',
                      fontSize: 20.sp,
                      textColour: Colors.grey[500],
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(2000),
                      child: ListView.builder(
                          itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: Get.width,
                                  height: ScreenUtil().setHeight(150),
                                  decoration: BoxDecoration(
                                    color: green,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: TextPoppinsBold(
                                      text: 'Laporan ke-$index',
                                      fontSize: 15.sp,
                                      textColour: Colors.grey[500],
                                    ),
                                  ),
                                ),
                              ),
                          itemCount: 100),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      onError: (err) {
        return Center(
          child: Text('Cannot Retrieve data error : $err'),
        );
      },
    );
  }
}

class oldView extends StatelessWidget {
  const oldView({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 48.h,
        ),
        ProfileBox(
          email: controller.dataProfile.email,
        ),
        SizedBox(
          height: 39.h,
        ),
        ProfileInfo(
          name: controller.dataProfile.nama,
          address: controller.dataProfile.alamat,
          phoneNumber: controller.dataProfile.noHp,
          photoUrl: controller.dataProfile.foto,
        ),
        SizedBox(height: 22.h),
        ProfileMenuButton(
          text: 'Ubah Password',
          onPressed: () {
            Get.toNamed(Routes.EDIT_PASSWORD);
          },
          iconPath: 'assets/svg/password_icon.svg',
          iconWidth: 38.w,
          iconHeight: 38.h,
          borderRadius: 12,
          fontSize: 16.sp,
          height: 50.h,
          textColor: kTextPurple,
          width: 374.w,
          backgroundColor: white,
        ),
        SizedBox(height: 8.h),
        ProfileMenuButton(
          onPressed: () {
            showAboutDialog(
              context: context,
              applicationName: "Drainit",
              applicationVersion: "1.0.0",
            );
          },
          text: 'Tentang Kami',
          iconPath: 'assets/svg/question_icon.svg',
          iconWidth: 38.w,
          iconHeight: 38.h,
          borderRadius: 12,
          fontSize: 16.sp,
          height: 50.h,
          textColor: kTextPurple,
          width: 374.w,
          backgroundColor: white,
        ),
        SizedBox(height: 8.h),
        ProfileMenuButton(
          text: 'Keluar Akun',
          onPressed: () {
            controller.logoutAccount();
          },
          iconPath: 'assets/svg/logout_icon.svg',
          iconWidth: 38.w,
          iconHeight: 38.h,
          borderRadius: 12,
          fontSize: 16.sp,
          height: 50.h,
          width: 374.w,
          textColor: kTextPurple,
          backgroundColor: white,
        ),
      ],
    );
  }
}

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({
    Key? key,
    this.name,
    this.totalReports,
    this.totalReportsDone,
    this.address,
    this.photoUrl,
    this.phoneNumber,
  }) : super(key: key);

  final String? name;
  final String? totalReports;
  final String? totalReportsDone;
  final String? address;
  final String? photoUrl;
  final String? phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320.h,
      width: 374.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.w),
        color: white,
      ),
      child: Column(
        children: [
          SizedBox(
            height: 12.h,
          ),
          Row(
            children: [
              SizedBox(
                width: 16.w,
              ),
              CircleAvatar(
                backgroundImage: NetworkImage(
                  photoUrl!.contains('.j')
                      ? imagePath() + photoUrl!
                      : 'defaultbanjir.png',
                  scale: 64.w,
                ),
                onBackgroundImageError: (object, trace) {
                  print('error object');
                },
              ),
              SizedBox(
                width: 10.w,
              ),
              SizedBox(
                width: 215.w,
                height: 60.h,
                child: Column(
                  children: [
                    SizedBox(
                      height: 12.h,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        name ?? 'default',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: kTextPurple,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Beginner',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: kColorGrey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              SvgPicture.asset(
                'assets/svg/Badge.svg',
                height: 38.h,
                width: 38.w,
              ),
            ],
          ),
          SizedBox(
            height: 17.w,
          ),
          Row(
            children: [
              Container(
                height: 63.h,
                width: 186.w,
                decoration: BoxDecoration(
                  border: Border.all(color: kBackgroundInput),
                ),
                child: SizedBox(
                  height: 40.h,
                  width: 155.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Total Laporan',
                            style: TextStyle(
                              fontSize: 12.sp,
                            ),
                          ),
                          Text(
                            totalReports ?? '18',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'Klasik',
                              fontSize: 24.sp,
                              color: kTextPurple,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 38.w,
                      ),
                      SvgPicture.asset('assets/svg/clock.svg'),
                    ],
                  ),
                ),
              ),
              Container(
                height: 63.h,
                width: 188.w,
                decoration: BoxDecoration(
                  border: Border.all(color: kBackgroundInput),
                ),
                child: SizedBox(
                  height: 40.h,
                  width: 155.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Laporan Selesai',
                            style: TextStyle(
                              fontSize: 12.sp,
                            ),
                          ),
                          Text(
                            totalReportsDone ?? '12',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'Klasik',
                              fontSize: 24.sp,
                              color: kTextPurple,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 38.w,
                      ),
                      SvgPicture.asset(
                        'assets/svg/flag.svg',
                        height: 40.h,
                        width: 40.w,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 18.h),
          Padding(
            padding: EdgeInsets.only(left: 22.w),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Nomor Handphone',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: kTextPurple,
                ),
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.only(left: 22.w),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                phoneNumber ?? '08233652155',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: kColorGrey,
                ),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.only(left: 22.w),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Alamat',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: kTextPurple,
                ),
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.only(left: 22.w),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                address ??
                    'Jalan Bukit Sari 10, Umban Sari Atas, Rumbai, Pek...',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: kColorGrey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileBox extends StatelessWidget {
  const ProfileBox({
    Key? key,
    this.email,
  }) : super(key: key);

  final String? email;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            width: 374.w,
            height: 146.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                12.w,
              ),
            ),
            child: SvgPicture.asset(
              'assets/svg/Profile_Box.svg',
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            left: 33.w,
            child: SizedBox(
              width: 172.w,
              height: 146.h,
              child: Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Lihat Profil Anda',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: kTextPurple,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      email ?? 'cannot retrieve email',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: kColorGrey,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 22.h,
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: RoundedButton(
                      text: 'Beginner',
                      borderRadius: 8.w,
                      color: kIconColor,
                      fontSize: 14.sp,
                      width: 120.w,
                      height: 40.h,
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
}

class TopMenu extends StatelessWidget {
  const TopMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64.h,
      width: 387.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SvgPicture.asset(
            'assets/svg/Back_Icon.svg',
          ),
          const Spacer(),
          Text(
            'Profile',
            style: TextStyle(
              fontFamily: 'Klasik',
              fontSize: 16.sp,
              color: kTextPurple,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.EDIT_PROFILE);
            },
            child: SvgPicture.asset(
              'assets/svg/Edit_Icon.svg',
            ),
          ),
        ],
      ),
    );
  }
}
