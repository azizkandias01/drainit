import 'package:drainit_flutter/app/components/constant.dart';
import 'package:drainit_flutter/app/components/text_default.dart';
import 'package:drainit_flutter/app/modules/edit_password/controllers/edit_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EditPasswordView extends GetView<EditPasswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                primary,
                white,
              ],
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Edit Password',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () =>
              Get.back(), // Get.off(AppPages.home, arguments: HomeArguments()),
        ),
      ),
      backgroundColor: white,
      body: Column(
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
                                    icon: const Icon(
                                      Icons.remove_red_eye,
                                      color: black,
                                    ),
                                    onPressed: () => {
                                      isVisible.toggle(),
                                    },
                                  )
                                : IconButton(
                                    icon: const Icon(
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
                                    icon: const Icon(
                                      Icons.remove_red_eye,
                                      color: black,
                                    ),
                                    onPressed: () => {
                                      isVisible.toggle(),
                                    },
                                  )
                                : IconButton(
                                    icon: const Icon(
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
                          controller: controller.confirmPasswordController,
                          obscureText: isVisible.value,
                          decoration: InputDecoration(
                            suffixIcon: isVisible.value
                                ? IconButton(
                                    icon: const Icon(
                                      Icons.remove_red_eye,
                                      color: black,
                                    ),
                                    onPressed: () => {
                                      isVisible.toggle(),
                                    },
                                  )
                                : IconButton(
                                    icon: const Icon(
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
      child: TextSemiBold(
        text: 'Ubah Password',
        fontSize: 16.sp,
      ),
    );
  }
}
