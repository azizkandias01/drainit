import 'package:drainit_flutter/app/components/constant.dart';
import 'package:drainit_flutter/app/components/rounded_button.dart';
import 'package:drainit_flutter/app/components/rounded_input_field.dart';
import 'package:drainit_flutter/app/modules/forgot_password/controllers/forgot_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
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
                      "Reset Password anda",
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
                      height: 45.h,
                    ),
                    Container(
                      width: 374.w,
                      height: 240.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.w),
                        color: white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                  "Masukan email anda yang telah terdaftar untuk"),
                              Text("menerima email reset password"),
                            ],
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          RoundedInputField(
                            roundedCorner: 12.w,
                            hintText: "Email",
                            height: 56.h,
                            width: 334.w,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          RoundedButton(
                            text: "Kirim Email Konfirmasi",
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
