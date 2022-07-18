import 'package:drainit_petugas/app/modules/edit_password/controllers/edit_password_controller.dart';
import 'package:drainit_petugas/app/utils/colors.dart';
import 'package:drainit_petugas/app/utils/text_default.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EditPasswordView extends GetView<EditPasswordController> {
  const EditPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            height: 0.5.sh,
            width: 1.sw,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  primary,
                  orange,
                  primary,
                ],
              ),
            ),
            child: Container(
              height: Get.statusBarHeight,
              width: 1.sw,
              child: SafeArea(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.adaptive.arrow_back_outlined,
                            color: white,
                          ),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                        TextBold(
                          text: 'Edit Password',
                          fontSize: 16.sp,
                          textColour: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 0.88.sh,
              width: 1.sw,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.w),
                  topRight: Radius.circular(30.w),
                ),
              ),
              child: Column(
                children: <Widget>[
                  Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Password lama",
                            style: TextStyle(color: black, fontSize: 11.sp),
                          ),
                          10.verticalSpace,
                          Builder(
                            builder: (context) {
                              final isVisible = true.obs;
                              return Obx(
                                () => TextField(
                                  obscureText: isVisible.value,
                                  controller: controller.oldPassword,
                                  decoration: InputDecoration(
                                    suffixIcon: isVisible.value
                                        ? IconButton(
                                            icon: Icon(
                                              Icons.remove_red_eye,
                                              color: black,
                                            ),
                                            onPressed: () => {
                                              isVisible.toggle(),
                                            },
                                          )
                                        : IconButton(
                                            icon: Icon(
                                              Icons.remove_red_eye_outlined,
                                              color: black,
                                            ),
                                            onPressed: () => {
                                              isVisible.toggle(),
                                            },
                                          ),
                                    hintText: '********',
                                    hintStyle: TextStyle(
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ).paddingAll(10.r),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Password baru",
                            style: TextStyle(color: black, fontSize: 11.sp),
                          ),
                          10.verticalSpace,
                          Builder(
                            builder: (context) {
                              final isVisible = true.obs;
                              return Obx(
                                () => TextField(
                                  obscureText: isVisible.value,
                                  controller: controller.newPasswordController,
                                  decoration: InputDecoration(
                                    suffixIcon: isVisible.value
                                        ? IconButton(
                                            icon: Icon(
                                              Icons.remove_red_eye,
                                              color: black,
                                            ),
                                            onPressed: () => {
                                              isVisible.toggle(),
                                            },
                                          )
                                        : IconButton(
                                            icon: Icon(
                                              Icons.remove_red_eye_outlined,
                                              color: black,
                                            ),
                                            onPressed: () => {
                                              isVisible.toggle(),
                                            },
                                          ),
                                    hintText: '********',
                                    hintStyle: TextStyle(
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ).paddingAll(10.r),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Konfirmasi password baru",
                            style: TextStyle(color: black, fontSize: 11.sp),
                          ),
                          10.verticalSpace,
                          Builder(
                            builder: (context) {
                              final isVisible = true.obs;
                              return Obx(
                                () => TextField(
                                  controller:
                                      controller.confirmPasswordController,
                                  obscureText: isVisible.value,
                                  decoration: InputDecoration(
                                    suffixIcon: isVisible.value
                                        ? IconButton(
                                            icon: Icon(
                                              Icons.remove_red_eye,
                                              color: black,
                                            ),
                                            onPressed: () => {
                                              isVisible.toggle(),
                                            },
                                          )
                                        : IconButton(
                                            icon: Icon(
                                              Icons.remove_red_eye_outlined,
                                              color: black,
                                            ),
                                            onPressed: () => {
                                              isVisible.toggle(),
                                            },
                                          ),
                                    hintText: '********',
                                    hintStyle: TextStyle(
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ).paddingAll(10.r),
                      controller.obx(
                        (state) => editPasswordButton().paddingAll(10.r),
                        onEmpty: editPasswordButton().paddingAll(10.r),
                        onLoading: const Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                        onError: (err) => editPasswordButton().paddingAll(10.r),
                      ),
                    ],
                  ).paddingAll(20.r),
                ],
              ).paddingSymmetric(horizontal: 5.w),
            ),
          ),
        ],
      ),
    );
  }

  Widget editPasswordButton() {
    return ElevatedButton(
      onPressed: () {
        controller.editPassword(
          controller.oldPassword.text,
          controller.newPasswordController.text,
          controller.confirmPasswordController.text,
        );
      },
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
        ),
        minimumSize: MaterialStateProperty.all(Size(Get.width, 50.h)),
        backgroundColor: MaterialStateProperty.all(primary),
      ),
      child: TextRegular(
        text: 'Ubah Password',
        fontSize: 16.sp,
      ),
    );
  }
}
