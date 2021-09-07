import 'package:drainit_flutter/app/components/constant.dart';
import 'package:drainit_flutter/app/components/rounded_button.dart';
import 'package:drainit_flutter/app/components/rounded_input_field.dart';
import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(414, 896),
      builder: () => Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Stack(
              children: [
                Positioned(
                  top: -10.w,
                  child: Container(
                    width: 414.w,
                    height: 896.h,
                    child: SvgPicture.asset(
                      "assets/svg/bg.svg",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 329.h,
                    ),
                    Column(
                      children: [
                        Text(
                          "SELAMAT DATANG",
                          style: TextStyle(
                            fontFamily: 'Klasik',
                            fontSize: 32.sp,
                            fontWeight: FontWeight.bold,
                            color: kTextPurple,
                          ),
                        ),
                        Text(
                          "DI DRAINIT",
                          style: TextStyle(
                              fontFamily: 'Klasik',
                              fontSize: 32.sp,
                              fontWeight: FontWeight.bold,
                              color: kTextPurple),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    LoginWithButton(
                      iconPath: 'assets/svg/FacebookIcon.svg',
                      iconHeight: 23.h,
                      iconWidth: 23.w,
                      width: 374.w,
                      height: 50.h,
                      spaceBetweenIconAndText: 17.w,
                      text: "Login With Google",
                      borderRadius: 12.r,
                      textColor: kTextPurple,
                      backgroundColor: white,
                      fontSize: 16.sp,
                    ),
                    SizedBox(height: 15.h),
                    LoginWithButton(
                      iconPath: 'assets/svg/GoogleIcon.svg',
                      width: 374.w,
                      height: 50.h,
                      spaceBetweenIconAndText: 17.w,
                      text: "Login With Google",
                      borderRadius: 12.r,
                      textColor: kTextPurple,
                      backgroundColor: white,
                      fontSize: 16.sp,
                    ),
                    SizedBox(
                      height: 26.h,
                    ),
                    SizedBox(
                      width: 414.w,
                      height: 356.h,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.r),
                            topRight: Radius.circular(20.r),
                          ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                              "Login Dengan Email",
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: kTextPurple,
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Divider(
                              color: kIconColor,
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            RoundedInputField(
                              roundedCorner: 12.w,
                              textEditingController:
                                  controller.myControllerEmail,
                              hintText: "Email",
                              height: 56.h,
                              width: 376.w,
                              textSize: 16.sp,
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            InputPassword(controller: controller),
                            SizedBox(
                              height: 20.h,
                            ),
                            controller.obx(
                              (state) => RoundedButton(
                                text: "Login",
                                fontSize: 16.sp,
                                borderRadius: 12.w,
                                height: 56.h,
                                width: 376.w,
                                color: kIconColor,
                                press: () {
                                  controller.userLogin(
                                    controller.myControllerEmail.text,
                                    controller.myControllerPassword.text,
                                  );
                                },
                              ),
                              onEmpty: RoundedButton(
                                text: "Login",
                                fontSize: 16.sp,
                                borderRadius: 12.w,
                                height: 56.h,
                                width: 376.w,
                                color: kIconColor,
                                press: () {
                                  controller.userLogin(
                                    controller.myControllerEmail.text,
                                    controller.myControllerPassword.text,
                                  );
                                },
                              ),
                              onError: (err) {
                                return RoundedButton(
                                  text: "Login Lagi",
                                  fontSize: 16.sp,
                                  borderRadius: 12.w,
                                  height: 56.h,
                                  width: 376.w,
                                  color: kIconColor,
                                  press: () {
                                    controller.userLogin(
                                      controller.myControllerEmail.text,
                                      controller.myControllerPassword.text,
                                    );
                                  },
                                );
                              },
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            GestureDetector(
                              onTap: () => Get.toNamed(Routes.FORGOT_PASSWORD),
                              child: Text(
                                "Lupa Password?",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 6.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Belum Punya Akun?",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => Get.toNamed(Routes.REGISTER),
                                  child: Text(
                                    " Daftar Disini!",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: kIconColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InputPassword extends StatelessWidget {
  const InputPassword({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final LoginController controller;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        width: 376.w,
        height: 56.h,
        decoration: BoxDecoration(
          color: kBackgroundInput,
          borderRadius: BorderRadius.circular(12.w),
        ),
        child: TextField(
          obscureText: controller.isPasswordHidden.value,
          cursorColor: kBackgroundInput,
          controller: controller.myControllerPassword,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
              left: 20.w,
              top: 20.h,
              bottom: 21.h,
            ),
            hintText: "Password",
            suffixIcon: IconButton(
              color: kIconColor,
              icon: controller.isPasswordHidden.value
                  ? Icon(Icons.remove_red_eye)
                  : Icon(Icons.remove_red_eye_outlined),
              onPressed: () async {
                await controller.isPasswordHidden.toggle();
              },
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
