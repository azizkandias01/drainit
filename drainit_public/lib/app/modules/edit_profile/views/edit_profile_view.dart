import 'package:drainit_flutter/app/components/constant.dart';
import 'package:drainit_flutter/app/modules/edit_profile/controllers/edit_profile_controller.dart';
import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class EditProfileView extends GetView<EditProfileController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(Routes.HOME, parameters: {'index': "3"});
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Edit Profile',
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                width: 100.w,
                height: 100.h,
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      maxRadius: 60.w,
                      minRadius: 60.w,
                      backgroundImage: NetworkImage(
                        '${Routes.IMAGEURL}${controller.profile.foto}',
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: () => {},
                        child: Container(
                          height: 20.h,
                          width: 20.w,
                          decoration: const BoxDecoration(
                            color: green,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.edit,
                              color: white,
                              size: 15.r,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ).paddingOnly(top: 20.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Edit Profile',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ).paddingAll(10.r),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nama lengkap",
                      style: TextStyle(color: black, fontSize: 11.sp),
                    ),
                    10.verticalSpace,
                    TextField(
                      controller: controller.nameController,
                      decoration: InputDecoration(
                        hintText: 'Nama Lengkap',
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
                      "Email",
                      style: TextStyle(color: black, fontSize: 11.sp),
                    ),
                    10.verticalSpace,
                    TextField(
                      controller: controller.emailController,
                      decoration: InputDecoration(
                        hintText: 'Email',
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
                      "Nomor telepon",
                      style: TextStyle(color: black, fontSize: 11.sp),
                    ),
                    10.verticalSpace,
                    TextField(
                      controller: controller.phoneController,
                      decoration: InputDecoration(
                        hintText: 'nomor telepon',
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
                      "Alamat",
                      style: TextStyle(color: black, fontSize: 11.sp),
                    ),
                    10.verticalSpace,
                    TextField(
                      controller: controller.addressController,
                      decoration: InputDecoration(
                        hintText: 'Alamat',
                        hintStyle: TextStyle(
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ],
                ).paddingAll(10.r),
                ElevatedButton(
                  onPressed: () {},
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
                  child: const Text("Simpan"),
                ).paddingAll(10.r),
              ],
            ).paddingAll(20.r),

            // RoundedButton(
            //   text: 'Next',
            //   fontSize: 16.sp,
            //   borderRadius: 12.w,
            //   height: 56.h,
            //   width: 376.w,
            //   color: kIconColor,
            //   press: () {
            //     //Get.toNamed(Routes.REGISTER_NEXT);
            //   },
            // ),
          ],
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
            'assets/svg/Back_Icon.svg',
          ),
        ),
        SizedBox(
          width: 80.w,
        ),
        Text(
          'Edit Profile',
          style: TextStyle(
            fontFamily: 'Klasik',
            fontSize: 18.sp,
            color: kTextPurple,
          ),
        ),
      ],
    );
  }
}
