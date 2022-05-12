import 'package:cached_network_image/cached_network_image.dart';
import 'package:drainit_petugas/app/modules/done_reports/controllers/done_reports_controller.dart';
import 'package:drainit_petugas/app/routes/app_pages.dart';
import 'package:drainit_petugas/app/utils/text_default.dart';
import 'package:drainit_petugas/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/processed_reports_controller.dart';

class ProcessedReportsView extends GetView<ProcessedReportsController> {
  final doneC = Get.find<DoneReportsController>();
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(414, 896),
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: TextBold(
            text: 'Laporan Diproses',
            fontSize: 20.sp,
          ).paddingOnly(left: 10.r),
          actions: [
            IconButton(
              icon: Icon(Icons.filter_list),
              onPressed: () {
                Get.toNamed('/search_processed_reports');
              },
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Get.toNamed('/search');
              },
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await controller.reportProcessed();
          },
          child: controller.obx(
            (state) => Scrollbar(
              child: ListView.builder(
                itemBuilder: (_, index) {
                  return ListTile(
                    dense: true,
                    onTap: () {
                      Get.toNamed(Routes.DETAIL, arguments: [
                        controller.list[index].id,
                        controller.list[index].geometry,
                      ]);
                    },
                    isThreeLine: true,
                    title: TextBold(
                      text: 'Laporan ${controller.list[index].namaJalan}',
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        20.verticalSpace,
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 5.r,
                                vertical: 5.r,
                              ),
                              alignment: Alignment.center,
                              height: 25.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5.r),
                                ),
                                color: getStatusColor(
                                  controller.list[index].tipePengaduan!,
                                ),
                              ),
                              child: Text(
                                controller.list[index].tipePengaduan!,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            10.horizontalSpace,
                            TextThin(
                              text: timeAgoSinceDate(
                                  controller.list[index].createdAt.toString(),
                                  numericDates: true),
                              textColour: Colors.grey,
                            ),
                          ],
                        ),
                        20.verticalSpace,
                        ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.r),
                          ),
                          child: Image(
                            image: CachedNetworkImageProvider(
                                Routes.IMAGEURL + controller.list[index].foto!),
                            height: Get.width / 2,
                            width: Get.width,
                            fit: BoxFit.cover,
                          ),
                        ),
                        20.verticalSpace,
                        Divider(
                          height: 1.h,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ).paddingAll(10.r);
                },
                itemCount: controller.list.length,
              ),
            ),
            onLoading: Center(
              child: CircularProgressIndicator.adaptive(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            ),
            onEmpty: Center(
              child: Text(
                'Tidak ada laporan yang ditanggapi',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            onError: (err) => Center(
              child: Text(
                'Terjadi kesalahan',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
