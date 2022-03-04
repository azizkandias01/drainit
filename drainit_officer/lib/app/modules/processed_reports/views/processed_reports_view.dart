import 'package:drainit_petugas/app/utils/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/processed_reports_controller.dart';

class ProcessedReportsView extends GetView<ProcessedReportsController> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder:()=> Scaffold(
        body: Padding(
          padding: EdgeInsets.only(left: 36.w),
          child: Column(
            children: [
              SizedBox(height: ScreenUtil().setHeight(51)),
              TextPoppinsBold(text: "Laporan\nDiprosess", fontSize: 36.sp,),
            ],
          ),
        ),
      ),
    );
  }
}
