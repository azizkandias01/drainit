import 'package:drainit_flutter/app/components/constant.dart';
import 'package:drainit_flutter/app/components/rounded_button.dart';
import 'package:drainit_flutter/app/components/rounded_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/edit_password_controller.dart';

class EditPasswordView extends GetView<EditPasswordController> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(414, 896),
      builder: () => Scaffold(
        backgroundColor: kBackgroundInput,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Container(
            width: Get.width,
            height: Get.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 34.w),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: SizedBox(
                          height: 120.h,
                          child: GestureDetector(
                            onTap: () => Get.back(),
                            child: Icon(Icons.arrow_back_ios_new),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "Ubah Password anda",
                      style: TextStyle(
                        fontFamily: 'Klasik',
                        fontSize: 24.sp,
                        color: kTextPurple,
                      ),
                    ),
                    SizedBox(
                      height: 39.h,
                    ),
                    SvgPicture.asset(
                      "assets/svg/Password.svg",
                      height: 264.h,
                      width: 414.w,
                    ),
                    SizedBox(
                      height: 35.h,
                    ),
                    Container(
                      width: 374.w,
                      height: 350.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.w),
                        color: white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 25.h,
                          ),
                          RoundedInputField(
                            roundedCorner: 12.w,
                            hintText: "Password Saat Ini",
                            height: 56.h,
                            width: 334.w,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          RoundedInputField(
                            roundedCorner: 12.w,
                            hintText: "Password Baru",
                            height: 56.h,
                            width: 334.w,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          RoundedInputField(
                            roundedCorner: 12.w,
                            hintText: "Konfirmasi Password Baru",
                            height: 56.h,
                            width: 334.w,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          RoundedButton(
                            text: "Ubah Password",
                            fontSize: 16.sp,
                            borderRadius: 12.w,
                            height: 56.h,
                            width: 334.w,
                            color: kIconColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
