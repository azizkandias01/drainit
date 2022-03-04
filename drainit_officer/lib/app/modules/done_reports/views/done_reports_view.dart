import 'package:cached_network_image/cached_network_image.dart';
import 'package:drainit_petugas/app/routes/app_pages.dart';
import 'package:drainit_petugas/app/utils/text_poppins.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import '../controllers/done_reports_controller.dart';

class DoneReportsView extends GetView<DoneReportsController> {
  @override
  Widget build(BuildContext context) {
    List<Widget> _buildList() {
      final List<Widget> listItems = [];

      for (int i = 0; i < controller.list.length; i++) {
        final isBanjir = controller.list[i].tipePengaduan == 'Banjir';
        listItems.add(
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.DETAIL, arguments: [
                controller.list[i].id,
                controller.list[i].geometry
              ]);
            },
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 325.w,
                  height: 122.h,
                  child: Stack(
                    children: [
                      Container(
                        width: 325.w,
                        height: 122.h,
                        child: isBanjir
                            ? Image.asset(
                                "assets/png/bg_banjir.png",
                                fit: BoxFit.fill,
                              )
                            : SvgPicture.asset("assets/svg/bg_tersumbat.svg",
                                fit: BoxFit.fill),
                      ),
                      Container(
                        width: 325.w,
                        height: 122.h,
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 8.w),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15.r),
                                child: Image(
                                  width: 147.w,
                                  height: 97.h,
                                  fit: BoxFit.fill,
                                  errorBuilder: (_, __, ___) {
                                    return SizedBox(
                                      width: 167.w,
                                    );
                                  },
                                  image: CachedNetworkImageProvider(
                                      Routes.IMAGEURL +
                                          (controller.list[i].foto ??
                                              "defaultpengaduan.png")),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 97.h,
                                width: 160.w,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextPoppinsBold(
                                      text: controller.list[i].tipePengaduan ??
                                          "",
                                      fontSize: 11.sp,
                                      textColour: Colors.white,
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    // TextPoppinsBold(
                                    //   text: controller.list[i].namaJalan ?? "",
                                    //   fontSize: 11.sp,
                                    //   textColour: Colors.white,
                                    // ),
                                    TextPoppinsBold(
                                      text: controller.list[i].namaJalan ?? "",
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 11.sp,
                                      textColour: Colors.white,
                                    ),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    Row(
                                      children: [
                                        LineIcon.history(
                                          color: Colors.white,
                                          size: 18.w,
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        TextPoppinsBold(
                                          text: controller.list[i].createdAt ??
                                              "",
                                          fontSize: 11.sp,
                                          textColour: Colors.white,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                    // ElevatedButton(
                                    //   style: ButtonStyle(
                                    //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    //       RoundedRectangleBorder(
                                    //         borderRadius: BorderRadius.circular(10.0),
                                    //       ),
                                    //     ),
                                    //     minimumSize: MaterialStateProperty.all(Size(58.w, 21.h)),
                                    //     backgroundColor:
                                    //     MaterialStateProperty.all(Colors.white),
                                    //     // elevation: MaterialStateProperty.all(3),
                                    //   ),
                                    //   onPressed: () => {},
                                    //   child: TextPoppinsBold(
                                    //     text: "Lihat Detail",
                                    //     fontSize: 8.sp,
                                    //     textColour: kMainGreen,
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }
      return listItems;
    }

    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: () => Scaffold(
        body: controller.obx(
          (state) => CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: ScreenUtil().setHeight(150),
                backgroundColor: Colors.white,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: false,
                  titlePadding: EdgeInsets.only(
                    left: ScreenUtil().setWidth(30),
                  ),
                  title: TextPoppinsBold(
                    text: 'Laporan \nSelesai',
                    fontSize: ScreenUtil().setSp(25),
                    textColour: Colors.black,
                  ),
                ),
              ),
              SliverList(delegate: SliverChildListDelegate.fixed(_buildList()))
            ],
          ),
          onLoading: Center(
            child: CupertinoActivityIndicator(),
          ),
          onError: (err) => Center(
            child: Text(err.toString()),
          ),
        ),
      ),
    );
  }
}
