import 'dart:convert';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:drainit_flutter/app/components/constant.dart';
import 'package:drainit_flutter/app/modules/edit_profile/controllers/edit_profile_controller.dart';
import 'package:drainit_flutter/app/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class EditProfileView extends GetView<EditProfileController> {
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
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                width: 100.w,
                height: 100.h,
                child: Obx(
                  () => Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      if (controller.bytes64Image.value.isNotEmpty)
                        CircleAvatar(
                          maxRadius: 60.w,
                          minRadius: 60.w,
                          backgroundColor: primary,
                          backgroundImage: MemoryImage(
                            base64Decode(
                              controller.bytes64Image.value,
                            ),
                          ),
                        )
                      else
                        CircleAvatar(
                          maxRadius: 60.w,
                          minRadius: 60.w,
                          backgroundColor: Colors.transparent,
                          backgroundImage: NetworkImage(
                            '${controller.profile.data!.foto}',
                          ),
                        ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: GestureDetector(
                          onTap: () => openFilePickerImage(
                            controller.selectedImagePath,
                            controller.bytes64Image,
                          ),
                          child: Container(
                            height: 20.h,
                            width: 20.w,
                            decoration: const BoxDecoration(
                              color: primary,
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
                DateTimePicker(
                  initialValue: controller.profile.data!.tanggalLahir,
                  dateMask: 'yyyy-MM-dd',
                  firstDate: DateTime(1940),
                  lastDate: DateTime(2100),
                  dateLabelText: 'Tanggal Lahir',
                  onChanged: (date) {
                    controller.dateOfBirth = date;
                  },
                ).paddingAll(10.r),
                controller.obx(
                  (state) => editButton().paddingAll(10.r),
                  onEmpty: editButton().paddingAll(10.r),
                  onError: (err) => editButton().paddingAll(10.r),
                  onLoading: const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                ),
              ],
            ).paddingAll(20.r),
          ],
        ),
      ),
    );
  }

  ElevatedButton editButton() {
    return ElevatedButton(
      onPressed: () {
        if (controller.bytes64Image.value.isNotEmpty) {
          controller.updateProfilePicture(controller.bytes64Image.value);
        }
        controller.updateProfile(
          controller.nameController.text,
          controller.phoneController.text,
          controller.addressController.text,
          controller.dateOfBirth,
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
      child: const Text("Simpan"),
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
