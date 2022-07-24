import 'package:drainit_petugas/app/utils/colors.dart';
import 'package:drainit_petugas/app/utils/rounded_button.dart';
import 'package:drainit_petugas/app/utils/text_default.dart';
import 'package:drainit_petugas/app/utils/text_poppins.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextBold(
                  text: "Drain",
                  textColour: blue,
                  fontSize: 48.sp,
                ),
                TextBold(
                  text: "It",
                  textColour: orange,
                  fontSize: 48.sp,
                ),
              ],
            ),
            TextMedium(
              text: "Petugas",
              fontSize: 18.sp,
            ),
            SizedBox(height: ScreenUtil().setHeight(57)),
            TextMedium(
              text: "Login untuk mengakses akun anda!",
              fontSize: 18.sp,
              textColour: black,
            ),
            SizedBox(height: ScreenUtil().setHeight(36)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextPoppinsRegular(text: "Email", fontSize: 12.sp),
                SizedBox(height: ScreenUtil().setHeight(10)),
                Container(
                  height: ScreenUtil().setHeight(57),
                  width: ScreenUtil().setWidth(325),
                  child: TextField(
                    controller: controller.emailController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: blue,
                        ),
                      ),
                      hintText: "Email",
                      hintStyle: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: ScreenUtil().setHeight(10)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextPoppinsRegular(text: "Password", fontSize: 12.sp),
                SizedBox(height: ScreenUtil().setHeight(10)),
                Container(
                  height: ScreenUtil().setHeight(57),
                  width: ScreenUtil().setWidth(325),
                  child: TextField(
                    obscureText: true,
                    controller: controller.passwordController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: blue,
                        ),
                      ),
                      hintText: "Password",
                      hintStyle: TextStyle(
                        fontSize: ScreenUtil().setSp(14),
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: ScreenUtil().setHeight(40)),
            controller.obx(
              (state) => RoundedButtonWidget(
                  buttonText: "Login",
                  width: 141.w,
                  onpressed: () => {
                        controller.loginPetugas(controller.emailController.text,
                            controller.passwordController.text)
                      }),
              onEmpty: RoundedButtonWidget(
                  buttonText: "Login",
                  width: 141.w,
                  onpressed: () => {
                        controller.loginPetugas(controller.emailController.text,
                            controller.passwordController.text)
                      }),
              onError: (error) {
                return RoundedButtonWidget(
                    buttonText: "Login",
                    width: 141.w,
                    onpressed: () => {
                          controller.loginPetugas(
                              controller.emailController.text,
                              controller.passwordController.text)
                        });
              },
              onLoading: Center(
                child: CupertinoActivityIndicator(
                  radius: 20.w,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
