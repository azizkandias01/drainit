import 'package:cached_network_image/cached_network_image.dart';
import 'package:drainit_flutter/app/components/constant.dart';
import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:drainit_flutter/app/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/history_controller.dart';

class HistoryView extends GetView<HistoryController> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      builder: () => Scaffold(
        body: Container(
          height: 896.w,
          width: 414.w,
          color: kBackgroundInput,
          child: Column(
            children: [
              SizedBox(
                height: 286.h,
              ),
              Container(
                decoration: const BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(36),
                    topRight: Radius.circular(36),
                  ),
                ),
                height: 610.h,
                width: 414.w,
                child: controller.obx(
                  (state) => SingleChildScrollView(
                    child: SizedBox(
                      width: 414.w,
                      height: 676.h,
                      child: RefreshIndicator(
                        onRefresh: () => controller.loadHistory(),
                        child: ListView.builder(
                          itemCount: controller.historyList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return historyItem(
                              controller.historyList[index].foto ?? '',
                              controller.historyList[index].statusPengaduan ??
                                  '',
                              controller.historyList[index].tipePengaduan ?? '',
                              controller.historyList[index].namaJalan ?? '',
                              () {
                                Get.toNamed(
                                  Routes.DETAIL,
                                  arguments: controller.historyList[index].id,
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget historyItem(String foto, String status, String jenis, String lokasi,
      Function() onTap) {
    return Center(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.r, 10.r, 20.r, 10.r),
        child: SizedBox(
          width: 414.w,
          height: 150.h,
          child: Stack(
            children: [
              Container(
                width: 414.w,
                height: 150.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: kBackgroundInput,
                ),
                child: SvgPicture.asset(
                  "assets/svg/Frame.svg",
                  fit: BoxFit.fill,
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(20.r),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.r),
                      child: Image(
                        width: 167.w,
                        height: 110.h,
                        fit: BoxFit.fill,
                        errorBuilder: (_, __, ___) {
                          return const Center(
                            child: Text('Image error'),
                          );
                        },
                        image: CachedNetworkImageProvider(imagePath() + foto),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          jenis,
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                            color: kTextPurple,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 8.w),
                          child: Text(
                            lokasi,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: kBackgroundInput,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              minWidth: 58.w,
                              height: 31.h,
                              color: Colors.white,
                              onPressed: onTap,
                              child: Text(
                                "Detail",
                                style: GoogleFonts.poppins(
                                  fontSize: 12.sp,
                                  color: kIconColor,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              minWidth: 58.w,
                              height: 31.h,
                              color: Colors.white,
                              onPressed: onTap,
                              child: Text(
                                "Feedback",
                                style: GoogleFonts.poppins(
                                  fontSize: 12.sp,
                                  color: kIconColor,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
