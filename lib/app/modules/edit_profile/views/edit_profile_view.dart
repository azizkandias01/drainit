import 'package:drainit_flutter/app/components/constant.dart';
import 'package:drainit_flutter/app/components/rounded_button.dart';
import 'package:drainit_flutter/app/components/rounded_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(414, 896),
      builder: () => Scaffold(
        backgroundColor: kBackgroundInput,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TopMenu(),
              SizedBox(
                height: 49.h,
              ),
              Container(
                width: 145.w,
                height: 145.h,
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                      width: 145.w,
                      height: 145.h,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          "https://reqres.in/img/faces/2-image.jpg",
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: () => {},
                        child: Container(
                          height: 44.h,
                          width: 44.w,
                          decoration: BoxDecoration(
                            color: kColorGrey,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            heightFactor: 10.h,
                            widthFactor: 10.w,
                            child: Icon(
                              Icons.edit,
                              color: white,
                              size: 30.r,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 62.h,
              ),
              RoundedInputField(
                hintText: "Nama Lengkap",
                backgroundColor: white,
                //textEditingController: controller.myControllerName,
                roundedCorner: 12.r,
                width: 374.w,
                height: 56.h,
              ),
              SizedBox(
                height: 8,
              ),
              RoundedInputField(
                hintText: "Nama Lengkap",
                backgroundColor: white,
                //textEditingController: controller.myControllerName,
                roundedCorner: 12.r,
                width: 374.w,
                height: 56.h,
              ),
              SizedBox(
                height: 8,
              ),
              RoundedInputField(
                hintText: "Nama Lengkap",
                backgroundColor: white,
                //textEditingController: controller.myControllerName,
                roundedCorner: 12.r,
                width: 374.w,
                height: 56.h,
              ),
              SizedBox(
                height: 247.h,
              ),
              RoundedButton(
                text: "Next",
                fontSize: 16.sp,
                borderRadius: 12.w,
                height: 56.h,
                width: 376.w,
                color: kIconColor,
                press: () {
                  //Get.toNamed(Routes.REGISTER_NEXT);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TopMenu extends StatelessWidget {
  const TopMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 10.w,
        ),
        GestureDetector(
          onTap: () => Get.back(),
          child: SvgPicture.asset(
            "assets/svg/Back_Icon.svg",
          ),
        ),
        SizedBox(
          width: 80.w,
        ),
        Text(
          "Edit Profile",
          style: TextStyle(
              fontFamily: 'Klasik', fontSize: 18.sp, color: kTextPurple),
        ),
      ],
    );
  }
}
