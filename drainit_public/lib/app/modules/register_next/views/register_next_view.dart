// ignore_for_file: sized_box_for_whitespace

import 'package:drainit_flutter/app/components/constant.dart';
import 'package:drainit_flutter/app/components/rounded_button.dart';
import 'package:drainit_flutter/app/components/text_poppins.dart';
import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../controllers/register_next_controller.dart';

class RegisterNextView extends GetView<RegisterNextController> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      builder: () => Scaffold(
        backgroundColor: white,
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 60.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200.h,
                width: 414.w,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: GestureDetector(
                        onTap: () => Get.back(),
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                        ),
                      ),
                    ),
                    SvgPicture.asset(
                      'assets/svg/il_signup_next.svg',
                      height: 200.h,
                      width: 188.w,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 21.h),
              TextPoppinsBold(text: "Selamat Datang", fontSize: 28.sp),
              SizedBox(height: 4.h),
              TextPoppinsRegular(
                text: "Masukan foto profile anda",
                fontSize: 12.sp,
              ),
              SizedBox(height: 40.h),
              Center(
                child: Container(
                  width: 100.w,
                  height: 100.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.w),
                    color: Colors.green,
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    color: white,
                  ),
                ),
              ),
              SizedBox(height: 57.h),
              RoundedButton(
                text: 'Daftar',
                fontSize: 16.sp,
                borderRadius: 12.w,
                height: 56.h,
                width: 376.w,
                color: Colors.green,
                textColor: white,
                press: () {
                  Get.toNamed(Routes.REGISTER_NEXT);
                },
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
