import 'package:drainit_flutter/app/components/constant.dart';
import 'package:drainit_flutter/app/components/rounded_button.dart';
import 'package:drainit_flutter/app/components/rounded_input_field.dart';
import 'package:drainit_flutter/app/components/text_poppins.dart';
import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../controllers/reports_controller.dart';

class ReportsView extends GetView<ReportsController> {
  @override
  Widget build(BuildContext context) {
    String? selectedValue;
    final List<String> items = [
      'Banjir',
      'Drainase Rusak',
    ];
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      builder: () => Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                left: 25.w,
                right: 20.w,
              ),
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildBody(),
                  ],
                ),
              ),
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
        const HeaderReports(),
        SizedBox(height: 10.h),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                controller.page.value = 0;
              },
              child: TextPoppinsBold(
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
                text: "Drainase tersumbat",
                fontSize: 16.sp,
                textColour:
                    controller.page.value == 1 ? Colors.red : Colors.grey,
              ),
            ),
          ],
        ),
        SizedBox(height: 20.h),
        TextPoppinsRegular(text: "Pilih foto", fontSize: 14.sp),
        SizedBox(height: 10.h),
        Center(
          child: Container(
            width: 200.w,
            height: 150.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.w),
              color: controller.page.value == 1 ? Colors.red : Colors.green,
            ),
            child: const Icon(
              Icons.camera_alt,
              color: white,
            ),
          ),
        ),
        SizedBox(height: 20.h),
        TextPoppinsRegular(text: "Pilih lokasi", fontSize: 14.sp),
        SizedBox(height: 10.h),
        selectLocation(),
        SizedBox(height: 20.h),
        TextPoppinsRegular(text: "Deskripsi", fontSize: 14.sp),
        SizedBox(height: 10.h),
        TextFormField(
          maxLines: 6,
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
        SizedBox(height: 10.h),
        Row(
          children: [
            Obx(
              () => Checkbox(
                value: controller.isChecked.value,
                onChanged: (value) {
                  print(Get.width);
                  controller.isChecked.value = value!;
                },
              ),
            ),
            if (Get.width >= 430)
              TextPoppinsRegular(
                text:
                    "Saya menyatakan laporan saya benar dan dapat dipertanggung jawabkan",
                fontSize: 12.sp,
              )
            else
              TextPoppinsRegular(
                text:
                    "Saya menyatakan laporan saya benar dan dapat \ndipertanggung jawabkan",
                fontSize: 12.sp,
              ),
          ],
        ),
        SizedBox(height: 10.h),
        RoundedButton(
          text: 'Laporkan',
          textColor: white,
          fontSize: 16.sp,
          borderRadius: 12.w,
          height: 56.h,
          width: 376.w,
          color: controller.page.value == 1 ? Colors.red : Colors.green,
        )
      ],
    );
  }

  Container buildOldView(List<String> items) {
    return Container(
      color: kIconColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: 29.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.0.w),
            child:
                TextPoppinsBold(text: "Laporkan \nKejadian", fontSize: 40.sp),
          ),
          SizedBox(
            height: 31.h,
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(36),
                topRight: Radius.circular(36),
              ),
            ),
            height: 650.h,
            width: 414.w,
            child: Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 24.h,
                  ),
                  DropdownButtonHideUnderline(
                    child: Obx(
                      () => dropdownMenu(items),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Obx(
                    () => selectLocation(),
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0.w),
                    child: TextPoppinsRegular(
                      text: "Deskripsi Laporan",
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  RoundedInputField(
                    backgroundColor: kBackgroundInput,
                    height: 117.h,
                    width: 374.w,
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0.w),
                    child: TextPoppinsRegular(
                      text: "Foto Lokasi",
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      RoundedInputField(
                        backgroundColor: green,
                        height: 117.h,
                        width: 374.w,
                      ),
                      SvgPicture.asset(
                        'assets/svg/Profile_Img.svg',
                        height: 86.h,
                        width: 86.w,
                      ),
                    ],
                  ),
                  SizedBox(height: 31.h),
                  RoundedButton(
                    text: 'Laporkan',
                    fontSize: 16.sp,
                    borderRadius: 12.w,
                    height: 56.h,
                    width: 376.w,
                    color: kIconColor,
                  )
                ],
              ),
            ),
          ),
        ],
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
                minimumSize: Size(374.w, 50.h),
                primary: controller.page.value == 1 ? Colors.red : Colors.green,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.w),
                ),
              ),
              onPressed: () {
                Get.snackbar(
                  "Lokasi Sudah Dipilih",
                  controller.latlng.value,
                );
              },
              child: Text(
                controller.latlng.value,
                maxLines: 1,
                style: TextStyle(
                  color: white,
                  fontSize: 16.sp,
                ),
              ),
            ),
    );
  }

  DropdownButton2<String> dropdownMenu(List<String> items) {
    return DropdownButton2(
      isExpanded: true,
      hint: Row(
        children: [
          SizedBox(width: 4.w),
          Expanded(
            child: Text(
              'Select Item',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: kTextPurple,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      items: items
          .map(
            (item) => DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: kTextPurple,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
          .toList(),
      value: controller.dropdownValue.value,
      onChanged: (value) {
        controller.dropdownValue.value = value.toString();
      },
      icon: const Icon(
        Icons.arrow_forward_ios_outlined,
        color: Colors.white,
      ),
      iconSize: 14.h,
      iconEnabledColor: kTextPurple,
      iconDisabledColor: kIconColor,
      buttonHeight: 50.h,
      buttonWidth: 374.w,
      buttonPadding: const EdgeInsets.only(left: 14, right: 14),
      buttonDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Colors.black26,
        ),
        color: kIconColor,
      ),
      buttonElevation: 0,
      itemHeight: 40.h,
      itemPadding: const EdgeInsets.only(left: 14, right: 14),
      dropdownMaxHeight: 200.h,
      dropdownWidth: 374.w,
      dropdownDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: kIconColor,
      ),
      dropdownElevation: 0,
      scrollbarRadius: const Radius.circular(40),
      scrollbarThickness: 6,
      scrollbarAlwaysShow: true,
    );
  }

  Future<void> _selectPlace() async {
    final result = await Get.toNamed(Routes.SEARCHMAP);
    controller.latlng.value = result as String;
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
