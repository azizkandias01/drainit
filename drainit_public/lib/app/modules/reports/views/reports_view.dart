import 'dart:convert';

import 'package:drainit_flutter/app/components/constant.dart';
import 'package:drainit_flutter/app/components/rounded_button.dart';
import 'package:drainit_flutter/app/components/text_poppins.dart';
import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/reports_controller.dart';

class ReportsView extends GetView<ReportsController> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      builder: () => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Obx(
            () => Text(
              'Laporkan ${controller.page.value == 0 ? 'Banjir' : 'Drainase Rusak'}',
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_outlined,
              color: Colors.black,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        backgroundColor: white,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildBody(),
                ],
              ).paddingOnly(left: 20.w, right: 20.w, bottom: 20.h),
            ),
          ),
        ),
      ),
    );
  }

  Column buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // const HeaderReports(),
        SizedBox(height: 10.h),
        TextPoppinsRegular(text: "Pilih jenis laporan", fontSize: 11.sp),
        10.verticalSpace,
        Row(
          children: [
            GestureDetector(
              onTap: () {
                controller.page.value = 0;
              },
              child: TextPoppinsBold(
                key: const Key('reports'),
                text: "Banjir",
                fontSize: 16.sp,
                textColour:
                    controller.page.value == 0 ? Colors.green : Colors.grey,
              ),
            ),
            SizedBox(width: 30.w),
            GestureDetector(
              onTap: () {
                controller.page.value = 1;
              },
              child: TextPoppinsBold(
                text: "Drainase Rusak",
                fontSize: 16.sp,
                textColour:
                    controller.page.value == 1 ? Colors.red : Colors.grey,
              ),
            ),
          ],
        ),
        SizedBox(height: 20.h),
        TextPoppinsRegular(text: "Pilih foto", fontSize: 11.sp),
        SizedBox(height: 10.h),
        if (controller.bytes64Image.value.isEmpty)
          const SizedBox()
        else
          Center(
            child: Container(
              height: Get.width / 2,
              width: Get.width / 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.w),
                image: DecorationImage(
                  image: MemoryImage(
                    base64Decode(controller.bytes64Image.value),
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                controller.getImage(ImageSource.camera);
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.camera_alt,
                    color: Colors.grey,
                  ),
                  SizedBox(width: 10.w),
                  TextPoppinsRegular(
                    text: "Ambil foto",
                    fontSize: 11.sp,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                controller.getImage(ImageSource.gallery);
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.image,
                    color: Colors.grey,
                  ),
                  SizedBox(width: 10.w),
                  TextPoppinsRegular(
                    text: "Pilih dari gallery",
                    fontSize: 11.sp,
                  ),
                ],
              ),
            ),
            if (controller.bytes64Image.value.isNotEmpty)
              GestureDetector(
                onTap: () {
                  controller.bytes64Image.value = '';
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.delete,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 10.w),
                    TextPoppinsRegular(
                      text: "Hapus",
                      fontSize: 11.sp,
                    ),
                  ],
                ),
              )
            else
              const SizedBox(),
          ],
        ),
        SizedBox(height: 20.h),
        TextPoppinsRegular(text: "Pilih lokasi", fontSize: 11.sp),
        SizedBox(height: 10.h),
        selectLocation(),
        SizedBox(height: 20.h),
        TextPoppinsRegular(text: "Deskripsi", fontSize: 11.sp),
        SizedBox(height: 10.h),
        TextFormField(
          maxLines: Get.height > 800 ? 6 : 4,
          controller: controller.deskripsiController,
          decoration: InputDecoration(
            hintText: "Masukan deskripsi",
            hintStyle: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.green),
              borderRadius: BorderRadius.circular(10.w),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.green),
              borderRadius: BorderRadius.circular(10.w),
            ),
          ),
        ),
        SizedBox(height: 20.h),
        Row(
          children: [
            Obx(
              () => Checkbox(
                value: controller.isChecked.value,
                onChanged: (value) {
                  controller.isChecked.value = value!;
                },
              ),
            ),
            Flexible(
              child: TextPoppinsRegular(
                text:
                    "Saya menyatakan laporan saya benar dan dapat dipertanggung jawabkan",
                fontSize: 11.sp,
              ),
            )
          ],
        ),
        SizedBox(height: 20.h),
        controller.obx(
          (state) => Container(),
          onEmpty: RoundedButton(
            text: 'Laporkan',
            textColor: white,
            fontSize: 16.sp,
            borderRadius: 12.w,
            height: 56.h,
            width: 376.w,
            color: controller.page.value == 1 ? Colors.red : Colors.green,
            press: () {
              controller.validateReportForm(
                controller.latlng.value,
                controller.bytes64Image.value,
                controller.page.value == 0 ? "Banjir" : "Drainase Tersumbat",
                controller.deskripsiController.text,
                controller.geometry,
              );
            },
          ),
          onLoading: Center(
            child: CupertinoActivityIndicator(
              radius: 20.r,
            ),
          ),
          onError: (error) => RoundedButton(
            text: 'Laporkan',
            textColor: white,
            fontSize: 16.sp,
            borderRadius: 12.w,
            height: 56.h,
            width: Get.width,
            color: controller.page.value == 1 ? Colors.red : Colors.green,
            press: () {
              controller.validateReportForm(
                controller.latlng.value,
                controller.bytes64Image.value,
                controller.page.value == 0 ? "Banjir" : "Drainase Rusak",
                controller.deskripsiController.text,
                controller.geometry,
              );
            },
          ),
        ),
      ],
    );
  }

  Padding selectLocation() {
    return Padding(
      padding: EdgeInsets.only(left: 0.w, right: 0.w),
      child: controller.latlng.value == ''
          ? ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(374.w, 50.h),
                primary: controller.page.value == 1 ? Colors.red : Colors.green,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.w),
                ),
              ),
              onPressed: _selectPlace,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pilih Lokasi Dari Peta',
                    style: TextStyle(
                      color: white,
                      fontSize: 14.sp,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.white,
                    size: 14.w,
                  ),
                ],
              ),
            )
          : ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(374.w, 100.h),
                primary: controller.page.value == 1 ? Colors.red : Colors.green,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.w),
                ),
              ),
              onPressed: _selectPlace,
              //     () {
              //   Get.snackbar(
              //     'Error',
              //     'Lokasi sudah dipilih',
              //     snackPosition: SnackPosition.BOTTOM,
              //     backgroundColor: Colors.red,
              //     colorText: Colors.white,
              //   );
              // },
              child: Text(
                controller.latlng.value,
                maxLines: 3,
                style: TextStyle(
                  color: white,
                  fontSize: 14.sp,
                ),
              ),
            ),
    );
  }

  Future<void> _selectPlace() async {
    final result = await Get.toNamed(Routes.SEARCHMAP);
    controller.latlng.value = result[0].toString();
    controller.geometry = result[1] as LatLng;
  }
}

class HeaderReports extends StatelessWidget {
  const HeaderReports({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextPoppinsRegular(text: "Halo,", fontSize: 24.sp),
            TextPoppinsBold(text: "Zeekands", fontSize: 24.sp),
          ],
        ),
        Icon(
          CupertinoIcons.person_alt_circle,
          color: Colors.black,
          size: 48.w,
        ),
      ],
    );
  }
}
