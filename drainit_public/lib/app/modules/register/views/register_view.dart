import 'package:drainit_flutter/app/components/constant.dart';
import 'package:drainit_flutter/app/components/rounded_button.dart';
import 'package:drainit_flutter/app/components/rounded_input_field.dart';
import 'package:drainit_flutter/app/components/text_poppins.dart';
import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      builder: () => Scaffold(
        backgroundColor: white,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Header(),
                  TextPoppinsBold(text: "Daftar", fontSize: 24.sp),
                  SizedBox(
                    height: 10.h,
                  ),
                  const InputText(
                    title: "Nama",
                    hintText: "Example",
                  ),
                  const InputText(
                    title: "Email",
                    hintText: "Example@gmail.com",
                  ),
                  const InputText(
                    title: "Alamat",
                    hintText: "Jl. Sudirman no.16",
                  ),
                  const InputText(
                    title: "Password",
                    hintText: "******",
                  ),
                  const InputText(
                    title: "Password Confirmation",
                    hintText: "******",
                  ),
                  Row(
                    children: [
                      Obx(
                        () => Checkbox(
                          value: controller.isChecked.value,
                          onChanged: (value) {
                            controller.isChecked.value = value!;
                          },
                        ),
                      ),
                      TextPoppinsRegular(
                        text: "Saya setuju dengan syarat dan ketentuan",
                        fontSize: 12.sp,
                      ),
                    ],
                  ),
                  RoundedButton(
                    text: "Lanjut",
                    height: ScreenUtil().setHeight(50),
                    borderRadius: 10.r,
                    width: Get.width,
                    color: Colors.green,
                    textColor: Colors.white,
                    press: () {
                      Get.toNamed(Routes.REGISTER_NEXT);
                    },
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Sudah punya akun?',
                        style: TextStyle(
                          fontSize: 14.sp,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.toNamed(Routes.LOGIN),
                        child: Text(
                          ' Masuk disini!',
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
            ),
          ),
        ),
      ),
    );
  }
}

class InputText extends StatelessWidget {
  final String title;
  final String hintText;
  const InputText({
    Key? key,
    required this.title,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextPoppinsRegular(text: title, fontSize: 14.sp),
        SizedBox(height: ScreenUtil().setHeight(5)),
        RoundedInputField(
          hintText: hintText,
        ),
        SizedBox(height: ScreenUtil().setHeight(15)),
      ],
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: const Icon(Icons.arrow_back_ios_new),
                ),
              ),
            ),
            Center(
              child: SvgPicture.asset(
                'assets/svg/il_signup.svg',
                height: 150.h,
                width: 150.w,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class buildOldView extends StatelessWidget {
  const buildOldView({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final RegisterController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 48.h,
            ),
            SizedBox(
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
                        child: const Icon(Icons.arrow_back_ios_new),
                      ),
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/svg/il_signup.svg',
                    height: 200.h,
                    width: 188.w,
                  ),
                ],
              ),
            ),
            SizedBox(height: 21.h),
            Text(
              'Buat akun baru',
              style: TextStyle(
                fontFamily: 'Klasik',
                fontSize: 24.sp,
                color: kTextPurple,
              ),
            ),
            SizedBox(height: 66.h),
            RoundedInputField(
              hintText: 'Nama Lengkap',
              backgroundColor: white,
              textEditingController: controller.myControllerName,
              roundedCorner: 12.r,
              width: 374.w,
              height: 56.h,
            ),
            SizedBox(height: 8.h),
            RoundedInputField(
              hintText: 'Nama Lengkap',
              backgroundColor: white,
              textEditingController: controller.myControllerName,
              roundedCorner: 12.r,
              width: 374.w,
              height: 56.h,
            ),
            SizedBox(height: 8.h),
            RoundedInputField(
              hintText: 'Nama Lengkap',
              backgroundColor: white,
              textEditingController: controller.myControllerName,
              roundedCorner: 12.r,
              width: 374.w,
              height: 56.h,
            ),
            SizedBox(
              height: 64.h,
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
        SizedBox(
          height: 41.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                child: const Divider(
                  color: kTextPurple,
                  height: 36,
                ),
              ),
            ),
            Text(
              'Atau Daftar Dengan',
              style: TextStyle(
                color: kTextPurple,
                fontSize: 14.sp,
                fontFamily: 'Klasik',
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                child: const Divider(
                  color: kTextPurple,
                  height: 36,
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 20.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoginWithButton(
              text: 'Google',
              iconPath: 'assets/svg/GoogleIcon.svg',
              borderRadius: 12,
              fontSize: 16.sp,
              height: 50.h,
              width: 181.w,
              textColor: kTextPurple,
              spaceBetweenIconAndText: 12.w,
              backgroundColor: white,
            ),
            SizedBox(
              width: 12.w,
            ),
            LoginWithButton(
              text: 'Facebook',
              iconHeight: 32.h,
              iconWidth: 32.w,
              iconPath: 'assets/svg/FacebookIcon.svg',
              spaceBetweenIconAndText: 12.w,
              borderRadius: 12,
              fontSize: 16.sp,
              height: 50.h,
              width: 181.w,
              textColor: kTextPurple,
              backgroundColor: white,
            ),
          ],
        ),
        SizedBox(
          height: 32.h,
        ),
        Center(
          child: RichText(
            text: TextSpan(
              text: 'Sudah Punya Akun? ',
              style: GoogleFonts.poppins(fontSize: 14.sp, color: black),
              children: [
                TextSpan(
                  text: 'Masuk Disini! ',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Get.toNamed(Routes.LOGIN);
                    },
                  style: GoogleFonts.poppins(
                    color: kTextPurple,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class InputPassword extends StatelessWidget {
  const InputPassword({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final RegisterController controller;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        width: Get.width * 0.8,
        height: Get.height * 0.05,
        decoration: BoxDecoration(
          color: grey,
          borderRadius: BorderRadius.circular(25),
        ),
        child: TextField(
          obscureText: controller.isPasswordHidden.value,
          cursorColor: primaryVariant,
          controller: controller.myControllerPassword,
          decoration: InputDecoration(
            hintText: 'Password',
            hintStyle: const TextStyle(fontSize: 13),
            icon: const Icon(
              Icons.lock,
              color: primary,
            ),
            suffixIcon: IconButton(
              color: primary,
              icon: controller.isPasswordHidden.value
                  ? const Icon(Icons.remove_red_eye)
                  : const Icon(Icons.remove_red_eye_outlined),
              onPressed: () => controller.isPasswordHidden.toggle(),
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}

class InputPasswordConfirm extends StatelessWidget {
  const InputPasswordConfirm({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final RegisterController controller;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        width: Get.width * 0.8,
        height: Get.height * 0.05,
        decoration: BoxDecoration(
          color: grey,
          borderRadius: BorderRadius.circular(25),
        ),
        child: TextField(
          obscureText: controller.isConfirmPasswordHidden.value,
          cursorColor: primaryVariant,
          controller: controller.myControllerPasswordConfirm,
          decoration: InputDecoration(
            hintText: 'Konfirmasi Password',
            hintStyle: const TextStyle(fontSize: 13),
            icon: const Icon(
              Icons.lock,
              color: primary,
            ),
            suffixIcon: IconButton(
              color: primary,
              icon: controller.isConfirmPasswordHidden.value
                  ? const Icon(Icons.remove_red_eye)
                  : const Icon(Icons.remove_red_eye_outlined),
              onPressed: () => controller.isConfirmPasswordHidden.toggle(),
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
