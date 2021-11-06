import 'package:cached_network_image/cached_network_image.dart';
import 'package:drainit_flutter/app/components/constant.dart';
import 'package:drainit_flutter/app/components/error_page.dart';
import 'package:drainit_flutter/app/utils/Utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      builder: () => Scaffold(
        body: controller.obx(
          (state) => Stack(
            children: [
              SizedBox(
                child: Image(
                  height: 350.h,
                  width: 414.w,
                  image: CachedNetworkImageProvider(
                    imagePath() + controller.detail.foto!,
                    errorListener: () => const Center(
                      child: Text('image not loaded'),
                    ),
                  ),
                  fit: BoxFit.fitHeight,
                  errorBuilder: (_, __, ___) {
                    return const Center(
                      child: Text('Image error'),
                    );
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 414.w,
                  height: 600.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      30.r,
                    ),
                    color: kBackgroundInput,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 33.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 120.w,
                            height: 40.h,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 5.w),
                                  child: SvgPicture.asset(
                                    "assets/svg/clock.svg",
                                    width: 40.w,
                                    height: 40.h,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "14:55:40",
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                    Text(
                                      "Jan 20, 2021",
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 117.w,
                          ),
                          SizedBox(
                            width: 120.w,
                            height: 40.h,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 5.w),
                                  child: SvgPicture.asset(
                                    "assets/svg/flag.svg",
                                    width: 40.w,
                                    height: 40.h,
                                  ),
                                ),
                                Text(
                                  "Selesai",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 32.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.detail.tipePengaduan!,
                              style: GoogleFonts.poppins(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: kIconColor,
                              ),
                            ),
                            Text(controller.detail.namaJalan!),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(
                              "Deskripsi",
                              style: GoogleFonts.poppins(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: kIconColor,
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(controller.detail.deskripsiPengaduan!),
                            SizedBox(
                              width: 414.w,
                              height: 350.h,
                              child: ListView.builder(
                                itemBuilder: (context, id) => TimelineTile(
                                  lineXY: 0.3,
                                  alignment: TimelineAlign.manual,
                                  endChild: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 274.w,
                                      height: 137.w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          30.r,
                                        ),
                                        color: kIconColor,
                                      ),
                                      child: Column(
                                        children: [Text("Laporan $id")],
                                      ),
                                    ),
                                  ),
                                  startChild: Container(
                                    color: kIconColor,
                                    child: Text("Senin"),
                                  ),
                                ),
                                itemCount: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 40.h,
                left: 20.w,
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    LineIcons.arrowCircleLeft,
                    size: 50.w,
                  ),
                ),
              ),
            ],
          ),
          onError: (err) {
            return const ErrorPage();
          },
        ),
      ),
    );
  }
}
