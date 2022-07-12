import 'dart:convert';
import 'dart:io';

import 'package:drainit_flutter/app/components/constant.dart';
import 'package:drainit_flutter/app/components/rounded_button.dart';
import 'package:drainit_flutter/app/components/text_default.dart';
import 'package:drainit_flutter/app/modules/reports/controllers/reports_controller.dart';
import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:drainit_flutter/app/utils/Utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class ReportsView extends GetView<ReportsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                primary,
                white,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: TextSemiBold(
          text: 'Laporan',
          fontSize: ScreenUtil().setSp(18),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                30.verticalSpace,
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.w),
                    border: Border.all(
                      color: Colors.grey,
                      width: .1.w,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 15.r,
                        offset: Offset(0, 10.w),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextBold(
                        text: "Pilih jenis laporan",
                        fontSize: 14.sp,
                      ),
                      10.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.page.value = 0;
                            },
                            child: Container(
                              width: 100.w,
                              height: 40.h,
                              decoration: BoxDecoration(
                                color: controller.page.value == 0
                                    ? Colors.amberAccent
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(10.w),
                                border: Border.all(
                                  color: Colors.grey,
                                  width: .1.w,
                                ),
                              ),
                              child: Center(
                                child: TextBold(
                                  text: "Banjir",
                                  fontSize: 14.sp,
                                  textColour: controller.page.value == 0
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 30.w),
                          GestureDetector(
                            onTap: () {
                              controller.page.value = 1;
                            },
                            child: Container(
                              width: 150.w,
                              height: 40.h,
                              decoration: BoxDecoration(
                                color: controller.page.value == 1
                                    ? Colors.red
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(10.w),
                                border: Border.all(
                                  color: Colors.grey,
                                  width: .5.w,
                                ),
                              ),
                              child: Center(
                                child: TextBold(
                                  text: "Drainase Rusak",
                                  fontSize: 14.sp,
                                  textColour: controller.page.value == 1
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ).paddingAll(20.r),
                ),
                10.verticalSpace,
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.w),
                    border: Border.all(
                      color: Colors.grey,
                      width: .1.w,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 15.r,
                        offset: Offset(0, 10.w),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextBold(
                        text: "Pilih foto lokasi",
                        fontSize: 14.sp,
                      ),
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
                              getImage(
                                ImageSource.camera,
                                controller.selectedImagePath,
                                controller.selectedImageSize,
                                controller.cropImagePath,
                                controller.cropImageSize,
                                controller.bytes64Image,
                              );
                            },
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.camera_alt,
                                  color: Colors.grey,
                                ),
                                SizedBox(width: 10.w),
                                TextLight(
                                  text: "Kamera",
                                  fontSize: 12.sp,
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (Platform.isIOS) {
                                openFilePickerImage(
                                  controller.selectedImagePath,
                                  controller.bytes64Image,
                                );
                              } else {
                                getImage(
                                  ImageSource.gallery,
                                  controller.selectedImagePath,
                                  controller.selectedImageSize,
                                  controller.cropImagePath,
                                  controller.cropImageSize,
                                  controller.bytes64Image,
                                );
                              }
                            },
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.image,
                                  color: Colors.grey,
                                ),
                                SizedBox(width: 10.w),
                                TextLight(
                                  text: "Galerry",
                                  fontSize: 12.sp,
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
                                  TextLight(
                                    text: "Hapus",
                                    fontSize: 12.sp,
                                  ),
                                ],
                              ),
                            )
                          else
                            const SizedBox(),
                        ],
                      ),
                    ],
                  ).paddingAll(20.r),
                ),
                10.verticalSpace,
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.w),
                    border: Border.all(
                      color: Colors.grey,
                      width: .1.w,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 15.r,
                        offset: Offset(0, 10.w),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextBold(
                        text: "Pilih lokasi",
                        fontSize: 14.sp,
                      ),
                      SizedBox(height: 10.h),
                      selectLocation(),
                    ],
                  ).paddingAll(20.r),
                ),
                10.verticalSpace,
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.w),
                    border: Border.all(
                      color: Colors.grey,
                      width: .1.w,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 15.r,
                        offset: Offset(0, 10.w),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextBold(
                        text: "Deskripsi laporan",
                        fontSize: 14.sp,
                      ),
                      SizedBox(height: 10.h),
                      TextFormField(
                        maxLines: Get.height > 800 ? 4 : 2,
                        controller: controller.deskripsiController,
                        decoration: InputDecoration(
                          hintText:
                              "Masukan detail mengenai lokasi dan keadaan sekitarnya",
                          hintStyle: TextStyle(
                            fontSize: 12.sp,
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
                    ],
                  ).paddingAll(20.r),
                ),
                10.verticalSpace,
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.w),
                    border: Border.all(
                      color: Colors.grey,
                      width: .1.w,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 15.r,
                        offset: Offset(0, 10.w),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                            child: TextThin(
                              text:
                                  "Saya menyatakan laporan saya benar dan dapat dipertanggung jawabkan",
                              fontSize: 12.sp,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10.h),
                      controller.obx(
                        (state) => Container(),
                        onEmpty: RoundedButton(
                          text: 'Laporkan',
                          textColor: white,
                          fontSize: 14.sp,
                          borderRadius: 12.w,
                          height: 56.h,
                          width: 376.w,
                          color: controller.page.value == 1
                              ? Colors.red
                              : Colors.amberAccent,
                          press: () {
                            controller.validateReportForm(
                              controller.latlng.value,
                              controller.bytes64Image.value,
                              controller.page.value == 0
                                  ? "Banjir"
                                  : "Drainase Tersumbat",
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
                          fontSize: 14.sp,
                          borderRadius: 12.w,
                          height: 56.h,
                          width: Get.width,
                          color: controller.page.value == 1
                              ? Colors.red
                              : Colors.amberAccent,
                          press: () {
                            controller.validateReportForm(
                              controller.latlng.value,
                              controller.bytes64Image.value,
                              controller.page.value == 0
                                  ? "Banjir"
                                  : "Drainase Rusak",
                              controller.deskripsiController.text,
                              controller.geometry,
                            );
                          },
                        ),
                      ),
                    ],
                  ).paddingAll(20.r),
                ),
              ],
            ).paddingOnly(left: 20.w, right: 20.w, bottom: 20.h),
          ),
        ),
      ),
    );
  }

  Padding selectLocation() {
    return Padding(
      padding: EdgeInsets.only(left: 0.w, right: 0.w),
      child: controller.latlng.value == ''
          ? ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(374.w, 50.h),
                primary: controller.page.value == 1
                    ? Colors.red
                    : Colors.amberAccent,
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
                      fontSize: 12.sp,
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
                minimumSize: Size(374.w, 50.h),
                primary: controller.page.value == 1
                    ? Colors.red
                    : Colors.amberAccent,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.w),
                ),
              ),
              onPressed: _selectPlace,
              child: Text(
                controller.latlng.value,
                maxLines: 1,
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
