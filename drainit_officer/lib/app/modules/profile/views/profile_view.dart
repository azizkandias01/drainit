import 'package:drainit_petugas/app/utils/rounded_button.dart';
import 'package:drainit_petugas/app/utils/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: (context) => Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: ScreenUtil().setHeight(51)),
            Padding(
              padding: EdgeInsets.only(left: 36.w),
              child: TextPoppinsBold(
                text: "Profile",
                fontSize: 36.sp,
              ),
            ),
            Center(
              child: Column(
                children: [
                  SizedBox(height: ScreenUtil().setHeight(47)),
                  CircleAvatar(
                    radius: ScreenUtil().setWidth(70.w),
                    backgroundImage: AssetImage("assets/png/bg_banjir.png"),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(13)),
                  TextPoppinsBold(
                    text: "Anam Wicaksono",
                    fontSize: 27.sp,
                  ),
                  SizedBox(height: ScreenUtil().setHeight(4)),
                  TextPoppinsRegular(text: "Anam@gmail.com", fontSize: 14.sp),
                  SizedBox(height: ScreenUtil().setHeight(13)),
                  RoundedButtonWidget(
                    buttonText: "Logout",
                    width: 200,
                    onpressed: () {
                      controller.logoutAccount();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
