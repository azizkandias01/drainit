import 'package:drainit_flutter/app/components/constant.dart';
import 'package:drainit_flutter/app/components/rounded_button.dart';
import 'package:drainit_flutter/app/components/rounded_input_field.dart';
import 'package:drainit_flutter/app/components/text_poppins.dart';
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
    whiteBar();
    return ScreenUtilInit(
      designSize: designSize,
      builder: () => Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SvgPicture.asset(
                  'assets/svg/il_login.svg',
                  height: ScreenUtil().setHeight(400),
                  width: ScreenUtil().setWidth(400),
                  fit: BoxFit.fitHeight,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 20.w,
                  right: 20.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextPoppinsBold(text: "Masuk", fontSize: 24.sp),
                    SizedBox(height: ScreenUtil().setHeight(10)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextPoppinsRegular(text: "Email", fontSize: 14.sp),
                        SizedBox(height: ScreenUtil().setHeight(10)),
                        RoundedInputField(
                          key: const Key('emailFormField'),
                          hintText: "example@gmail.com",
                          textEditingController: controller.myControllerEmail,
                        ),
                      ],
                    ),
                    SizedBox(height: ScreenUtil().setHeight(10)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextPoppinsRegular(text: "Password", fontSize: 14.sp),
                        SizedBox(height: ScreenUtil().setHeight(10)),
                        InputPassword(
                          key: const Key('passwordFormField'),
                          controller: controller,
                        ),
                      ],
                    ),
                    SizedBox(height: ScreenUtil().setHeight(20)),
                    controller.obx(
                      (state) => RoundedButton(
                        key: const Key('loginButton'),
                        text: "Masuk",
                        height: ScreenUtil().setHeight(50),
                        borderRadius: 10.r,
                        width: Get.width,
                        color: Colors.green,
                        textColor: Colors.white,
                        press: () async {
                          if (controller.myControllerEmail.text.isEmpty ||
                              controller.myControllerPassword.text.isEmpty) {
                            controller.loginInformationEmpty();
                          } else {
                            await controller.userLogin(
                              controller.myControllerEmail.text,
                              controller.myControllerPassword.text,
                            );
                          }
                        },
                      ),
                      onLoading: Center(
                        child: CupertinoActivityIndicator(
                          radius: 20.r,
                        ),
                      ),
                      onEmpty: RoundedButton(
                        key: const Key('loginButton'),
                        text: "Masuk",
                        height: ScreenUtil().setHeight(50),
                        borderRadius: 10.r,
                        width: Get.width,
                        color: Colors.green,
                        textColor: Colors.white,
                        press: () async {
                          if (controller.myControllerEmail.text.isEmpty ||
                              controller.myControllerPassword.text.isEmpty) {
                            controller.loginInformationEmpty();
                          } else {
                            await controller.userLogin(
                              controller.myControllerEmail.text,
                              controller.myControllerPassword.text,
                            );
                          }
                        },
                      ),
                      onError: (error) => RoundedButton(
                        text: "Masuk",
                        height: ScreenUtil().setHeight(50),
                        borderRadius: 10.r,
                        width: Get.width,
                        color: Colors.green,
                        textColor: Colors.white,
                        press: () async {
                          if (controller.myControllerEmail.text.isEmpty ||
                              controller.myControllerPassword.text.isEmpty) {
                            controller.loginInformationEmpty();
                          } else {
                            await controller.userLogin(
                              controller.myControllerEmail.text,
                              controller.myControllerPassword.text,
                            );
                          }
                        },
                      ),
                    ),
                    SizedBox(height: ScreenUtil().setHeight(10)),
                    Center(
                      child: TextPoppinsRegular(
                        text: "Atau",
                        fontSize: 14.sp,
                        textColour: Colors.grey,
                      ),
                    ),
                    SizedBox(height: ScreenUtil().setHeight(10)),
                    Container(
                      width: Get.width,
                      height: ScreenUtil().setHeight(50),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                          color: Colors.green,
                          width: 1.w,
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () => {
                          Get.toNamed(Routes.HOME, arguments: 'anonymouse'),
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              CupertinoIcons.person,
                              color: Colors.green,
                            ),
                            SizedBox(width: ScreenUtil().setWidth(10)),
                            TextPoppinsRegular(
                              text: "Login tanpa akun",
                              fontSize: 14.sp,
                              textColour: Colors.green,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: ScreenUtil().setHeight(20)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Belum Punya Akun?',
                          style: TextStyle(
                            fontSize: 14.sp,
                          ),
                        ),
                        GestureDetector(
                          key: const Key('register'),
                          onTap: () => Get.toNamed(Routes.REGISTER),
                          child: Text(
                            ' Daftar Disini!',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
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
      () => SizedBox(
        width: 376.w,
        height: 56.h,
        child: TextField(
          obscureText: controller.isPasswordHidden.value,
          cursorColor: kBackgroundInput,
          controller: controller.myControllerPassword,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(
                color: Colors.grey,
                width: 1.w,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(
                color: Colors.green,
              ),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            hintText: 'Password',
            hintStyle: TextStyle(fontSize: 12.sp),
            suffixIcon: IconButton(
              color: Colors.grey,
              icon: controller.isPasswordHidden.value
                  ? const Icon(Icons.remove_red_eye)
                  : const Icon(Icons.remove_red_eye_outlined),
              onPressed: () {
                controller.isPasswordHidden.toggle();
              },
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
