import 'package:drainit_flutter/app/components/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

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
                      width: 374.w,
                      height: 676.h,
                      child: RefreshIndicator(
                        onRefresh: () => controller.loadHistory(),
                        child: ListView.separated(
                          itemCount: controller.historyList.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              height: 14.h,
                            );
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () => print(
                                'id pengaduan :${controller.historyList[index].id}',
                              ),
                              child: historyItem(
                                controller.historyList[index].namaJalan ?? '',
                                controller.historyList[index].statusPengaduan ??
                                    '',
                              ),
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

  Widget historyItem(String location, String status) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 317.w,
        height: 109.h,
        decoration: BoxDecoration(
          color: (status == 'Selesai') ? green : kBackgroundInput,
          borderRadius: BorderRadius.circular(
            15,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              location,
              softWrap: true,
              maxLines: 1,
            ),
            Text(status),
          ],
        ),
      ),
    );
  }
}
