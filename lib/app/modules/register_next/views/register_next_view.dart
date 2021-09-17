// ignore_for_file: sized_box_for_whitespace

import 'package:drainit_flutter/app/components/constant.dart';
import 'package:drainit_flutter/app/components/rounded_button.dart';
import 'package:drainit_flutter/app/components/rounded_input_field.dart';
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
        backgroundColor: kBackgroundInput,
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: 414.w,
          height: 896.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: [
                  SizedBox(
                    height: 60.h,
                  ),
                  Container(
                    height: 200.h,
                    width: 414.w,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 25.w),
                            child: GestureDetector(
                              onTap: () => Get.back(),
                              child: const Icon(
                                Icons.arrow_back_ios_new,
                              ),
                            ),
                          ),
                        ),
                        SvgPicture.asset(
                          'assets/svg/RegisterIlustration.svg',
                          height: 200.h,
                          width: 188.w,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 21.h),
                  Text(
                    'Selamat Datang',
                    style: TextStyle(
                      fontFamily: 'Klasik',
                      fontSize: 36.sp,
                      color: kTextPurple,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Lengkapi data anda',
                    style: TextStyle(
                      fontFamily: 'Klasik',
                      fontSize: 16.sp,
                      color: kColorGrey,
                    ),
                  ),
                  SizedBox(height: 26.h),
                  SvgPicture.asset(
                    'assets/svg/Profile_Img.svg',
                    height: 86.h,
                    width: 86.w,
                  ),
                  SizedBox(height: 57.h),
                  RoundedInputField(
                    hintText: 'Nama Lengkap',
                    backgroundColor: white,
                    //  textEditingController: controller.myControllerName,
                    roundedCorner: 12.r,
                    width: 374.w,
                    height: 56.h,
                  ),
                  SizedBox(height: 8.h),
                  RoundedInputField(
                    hintText: 'Nama Lengkap',
                    backgroundColor: white,
                    // textEditingController: controller.myControllerName,
                    roundedCorner: 12.r,
                    width: 374.w,
                    height: 56.h,
                  ),
                  SizedBox(height: 8.h),
                  RoundedInputField(
                    hintText: 'Nama Lengkap',
                    backgroundColor: white,
                    //  textEditingController: controller.myControllerName,
                    roundedCorner: 12.r,
                    width: 374.w,
                    height: 56.h,
                  ),
                  SizedBox(
                    height: 48.h,
                  ),
                  RoundedButton(
                    text: 'Next',
                    fontSize: 16.sp,
                    borderRadius: 12.w,
                    height: 56.h,
                    width: 376.w,
                    color: kIconColor,
                    press: () {
                      Get.toNamed(Routes.REGISTER_NEXT);
                    },
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
