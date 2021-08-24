import 'package:drainit_flutter/app/components/constant.dart';
import 'package:drainit_flutter/app/components/rounded_button.dart';
import 'package:drainit_flutter/app/components/rounded_input_field.dart';
import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: Get.width,
            height: Get.height * .9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: Get.height * 0.03),
                Text(
                  "Masuk",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                SvgPicture.asset("assets/svg/login.svg",
                    height: Get.height * 0.35),
                Spacer(),
                RoundedInputField(
                  hintText: "Email",
                  roundedCorner: 20,
                  textEditingController: controller.myControllerEmail,
                ),
                InputPassword(
                  controller: controller,
                ),
                controller.obx(
                  (data) => Text(data!.statusCode.toString()),
                  onError: (err) {
                    return Column(
                      children: [
                        RoundedButton(
                          text: "LOGIN",
                          press: () {
                            controller.userLogin(
                              controller.myControllerEmail.text,
                              controller.myControllerPassword.text,
                            );
                          },
                          borderRadius: 25,
                        ),
                        Text(
                          "Terjadi error $err",
                          style: GoogleFonts.poppins(color: Colors.red),
                        )
                      ],
                    );
                  },
                  onEmpty: RoundedButton(
                    text: "LOGIN",
                    press: () {
                      controller.userLogin(
                        controller.myControllerEmail.text,
                        controller.myControllerPassword.text,
                      );
                    },
                    borderRadius: 25,
                  ),
                ),
                SizedBox(height: Get.height * 0.03),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: 'Belum Punya Akun? ',
                      style: TextStyle(fontSize: 18, color: kBlack),
                      children: [
                        TextSpan(
                          text: 'Daftar Disini! ',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.toNamed(Routes.REGISTER);
                            },
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: Get.height * 0.01),
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
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        width: Get.width * 0.8,
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
            icon: Icon(
              Icons.lock,
              color: primary,
            ),
            suffixIcon: IconButton(
              color: primary,
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
