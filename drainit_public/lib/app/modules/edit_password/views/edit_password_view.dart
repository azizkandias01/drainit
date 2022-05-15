import 'package:drainit_flutter/app/components/constant.dart';
import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/edit_password_controller.dart';

class EditPasswordView extends GetView<EditPasswordController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(Routes.HOME, parameters: {'index': "3"});
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
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
                Get.offAllNamed(Routes.HOME, parameters: {'index': "3"}),
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
                    TextField(
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.remove_red_eye,
                            color: black,
                          ),
                          onPressed: () => {},
                        ),
                        hintText: '********',
                        hintStyle: TextStyle(
                          fontSize: 12.sp,
                        ),
                      ),
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
                    TextField(
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.remove_red_eye,
                            color: black,
                          ),
                          onPressed: () => {},
                        ),
                        hintText: '********',
                        hintStyle: TextStyle(
                          fontSize: 12.sp,
                        ),
                      ),
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
                    TextField(
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.remove_red_eye,
                            color: black,
                          ),
                          onPressed: () => {},
                        ),
                        hintText: '********',
                        hintStyle: TextStyle(
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ],
                ).paddingAll(10.r),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Simpan"),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                    ),
                    minimumSize:
                        MaterialStateProperty.all(Size(Get.width, 50.h)),
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                  ),
                ).paddingAll(10.r),
              ],
            ).paddingAll(20.r),
          ],
        ),
      ),
    );
  }
}
