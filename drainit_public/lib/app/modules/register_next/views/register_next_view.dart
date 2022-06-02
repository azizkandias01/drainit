// ignore_for_file: sized_box_for_whitespace

import 'dart:convert';

import 'package:drainit_flutter/app/components/constant.dart';
import 'package:drainit_flutter/app/components/rounded_button.dart';
import 'package:drainit_flutter/app/components/text_default.dart';
import 'package:drainit_flutter/app/modules/register_next/controllers/register_next_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/Utils.dart';

class RegisterNextView extends GetView<RegisterNextController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: appBarGradient(),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Unggah Foto',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      backgroundColor: white,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 21.h),
            TextBold(text: "Selamat Datang", fontSize: 28.sp),
            SizedBox(height: 4.h),
            TextRegular(
              text: "Masukan foto profile anda",
              fontSize: 12.sp,
            ),
            SizedBox(height: 40.h),
            Center(
              child: Obx(
                () => GestureDetector(
                  onTap: () => controller.getImage(ImageSource.gallery),
                  child: controller.bytes64Image.value.isEmpty
                      ? Container(
                          width: 150.w,
                          height: 150.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.w),
                            color: Colors.green,
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            color: white,
                          ),
                        )
                      : ClipOval(
                          child: Image.memory(
                            base64Decode(controller.bytes64Image.value),
                            fit: BoxFit.cover,
                            width: 150.w,
                            height: 150.h,
                          ),
                        ),
                ),
              ),
            ),
            SizedBox(height: 57.h),
            controller.obx(
              (state) => RoundedButton(
                text: 'Daftar',
                fontSize: 16.sp,
                borderRadius: 12.w,
                height: 56.h,
                width: 376.w,
                color: Colors.green,
                textColor: white,
                press: () {
                  controller.registerUser(
                    controller.argument[0].toString(),
                    controller.argument[1].toString(),
                    controller.argument[2].toString(),
                    controller.argument[3].toString(),
                    controller.argument[4].toString(),
                    controller.argument[5].toString(),
                    controller.bytes64Image.value,
                  );
                },
              ),
              onEmpty: RoundedButton(
                text: 'Daftar',
                fontSize: 16.sp,
                borderRadius: 12.w,
                height: 56.h,
                width: 376.w,
                color: Colors.green,
                textColor: white,
                press: () {
                  controller.registerUser(
                    controller.argument[0].toString(),
                    controller.argument[1].toString(),
                    controller.argument[2].toString(),
                    controller.argument[3].toString(),
                    controller.argument[4].toString(),
                    controller.argument[5].toString(),
                    controller.bytes64Image.value,
                  );
                },
              ),
              onLoading: Column(
                children: [
                  Center(
                    child: CupertinoActivityIndicator(
                      radius: 20.r,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  TextRegular(
                    text: 'Sedang membuat akun...',
                    fontSize: 12.sp,
                  ),
                ],
              ),
              onError: (error) => RoundedButton(
                text: 'Daftar',
                fontSize: 16.sp,
                borderRadius: 12.w,
                height: 56.h,
                width: 376.w,
                color: Colors.green,
                textColor: white,
                press: () {
                  controller.registerUser(
                    controller.argument[0].toString(),
                    controller.argument[1].toString(),
                    controller.argument[2].toString(),
                    controller.argument[3].toString(),
                    controller.argument[4].toString(),
                    controller.argument[5].toString(),
                    controller.bytes64Image.value,
                  );
                },
              ),
            ),
            SizedBox(height: 20.h),
            // RoundedButton(
            //   text: 'Skip',
            //   fontSize: 16.sp,
            //   borderRadius: 12.w,
            //   height: 56.h,
            //   width: 376.w,
            //   color: green,
            //   textColor: white,
            //   press: () {
            //     controller.registerUser(
            //       controller.argument[0].toString(),
            //       controller.argument[1].toString(),
            //       controller.argument[2].toString(),
            //       controller.argument[3].toString(),
            //       controller.argument[4].toString(),
            //       controller.argument[5].toString(),
            //       '',
            //     );
            //   },
            // ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
