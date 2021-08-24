import 'dart:io';

import 'package:drainit_flutter/app/components/constant.dart';
import 'package:drainit_flutter/app/components/rounded_button.dart';
import 'package:drainit_flutter/app/components/rounded_input_field.dart';
import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: Get.width,
          height: Get.height * 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: [
                  Container(
                    height: Get.height * .15,
                    color: primary,
                  ),
                  SizedBox(height: Get.height * 0.03),
                  Obx(
                    () => controller.cropImagePath.value == ''
                        ? Column(
                            children: [
                              Text(
                                'Select image from camera/galley',
                                style: TextStyle(fontSize: 20),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  controller.getImage(ImageSource.gallery);
                                },
                                child: Text("Gallery"),
                              )
                            ],
                          )
                        : Column(
                            children: [
                              ClipOval(
                                child: Image.file(
                                  File(controller.cropImagePath.value),
                                  width: Get.width * .4,
                                  height: Get.width * .4,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  controller.getImage(ImageSource.gallery);
                                },
                                child: Text("Ubah foto"),
                              ),
                            ],
                          ),
                  ),
                  SizedBox(height: Get.height * 0.03),
                  RoundedInputField(
                    hintText: "Nama Lengkap",
                    textEditingController: controller.myControllerName,
                    roundedCorner: 25,
                  ),
                  RoundedInputField(
                    textEditingController: controller.myControllerPhoneNumber,
                    hintText: "Nomor Hp",
                    roundedCorner: 25,
                  ),
                  RoundedInputField(
                    hintText: "Email",
                    textEditingController: controller.myControllerEmail,
                    roundedCorner: 25,
                  ),
                  RoundedInputField(
                    textEditingController: controller.myControllerAddress,
                    hintText: "Alamat",
                    roundedCorner: 25,
                  ),
                  InputPassword(
                    controller: controller,
                  ),
                  InputPasswordConfirm(
                    controller: controller,
                  ),
                  controller.obx(
                    (data) => Column(
                      children: [
                        Text(
                          "Akun berhasil dibuat, anda dapat login sekarang",
                          style: TextStyle(color: primary),
                        ),
                        RoundedButton(
                          text: "LOGIN",
                          press: () {
                            Get.toNamed(Routes.LOGIN);
                          },
                          borderRadius: 25,
                        ),
                      ],
                    ),
                    onEmpty: RoundedButton(
                      text: "DAFTAR",
                      press: () {
                        controller.registerUser(
                          controller.myControllerName.text,
                          controller.myControllerPhoneNumber.text,
                          controller.myControllerEmail.text,
                          controller.myControllerAddress.text,
                          controller.myControllerPassword.text,
                          controller.myControllerPasswordConfirm.text,
                          controller.bytes64Image.value,
                        );
                      },
                      borderRadius: 25,
                    ),
                    onError: (err) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                err!,
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ),
                          RoundedButton(
                            text: "DAFTAR",
                            press: () {
                              controller.registerUser(
                                controller.myControllerName.text,
                                controller.myControllerPhoneNumber.text,
                                controller.myControllerEmail.text,
                                controller.myControllerAddress.text,
                                controller.myControllerPassword.text,
                                controller.myControllerPasswordConfirm.text,
                                controller.bytes64Image.value,
                              );
                            },
                            borderRadius: 25,
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Sudah Punya Akun? ',
                    style: GoogleFonts.poppins(fontSize: 18, color: kBlack),
                    children: [
                      TextSpan(
                        text: 'Masuk Disini! ',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.toNamed(Routes.LOGIN);
                          },
                        style: GoogleFonts.poppins(
                          color: primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),
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

  final RegisterController controller;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
            hintText: "Password",
            hintStyle: TextStyle(fontSize: 13),
            icon: Icon(
              Icons.lock,
              color: primary,
            ),
            suffixIcon: IconButton(
              color: primary,
              icon: controller.isPasswordHidden.value
                  ? Icon(Icons.remove_red_eye)
                  : Icon(Icons.remove_red_eye_outlined),
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
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
            hintText: "Konfirmasi Password",
            hintStyle: TextStyle(fontSize: 13),
            icon: Icon(
              Icons.lock,
              color: primary,
            ),
            suffixIcon: IconButton(
              color: primary,
              icon: controller.isConfirmPasswordHidden.value
                  ? Icon(Icons.remove_red_eye)
                  : Icon(Icons.remove_red_eye_outlined),
              onPressed: () => controller.isConfirmPasswordHidden.toggle(),
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
