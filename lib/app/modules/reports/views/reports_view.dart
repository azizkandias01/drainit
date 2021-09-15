import 'package:drainit_flutter/app/components/constant.dart';
import 'package:drainit_flutter/app/components/rounded_button.dart';
import 'package:drainit_flutter/app/components/rounded_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/reports_controller.dart';

class ReportsView extends GetView<ReportsController> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(414, 896),
      builder: () => Scaffold(
        body: Container(
          height: 896.w,
          width: 414.w,
          child: Column(
            children: [
              SizedBox(
                height: 286.h,
              ),
              Container(
                decoration: BoxDecoration(
                  color: kBackgroundInput,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(36),
                    topRight: Radius.circular(36),
                  ),
                ),
                height: 610.h,
                width: 414.w,
                child: Column(
                  children: [
                    SizedBox(
                      height: 24.h,
                    ),
                    ProfileMenuButton(
                      text: "Ubah Password",
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
                    SizedBox(
                      height: 20.h,
                    ),
                    ProfileMenuButton(
                      text: "Ubah Password",
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
                    SizedBox(
                      height: 45.h,
                    ),
                    RoundedInputField(
                      backgroundColor: white,
                      height: 117.h,
                      width: 374.w,
                    ),
                    SizedBox(
                      height: 42.h,
                    ),
                    RoundedInputField(
                      backgroundColor: white,
                      height: 117.h,
                      width: 374.w,
                    ),
                    SizedBox(height: 31.h),
                    RoundedButton(
                      text: "Login Lagi",
                      fontSize: 16.sp,
                      borderRadius: 12.w,
                      height: 56.h,
                      width: 376.w,
                      color: kIconColor,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
