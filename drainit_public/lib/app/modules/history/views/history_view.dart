import 'package:cached_network_image/cached_network_image.dart';
import 'package:drainit_flutter/app/components/constant.dart';
import 'package:drainit_flutter/app/components/text_default.dart';
import 'package:drainit_flutter/app/components/text_poppins.dart';
import 'package:drainit_flutter/app/modules/history/controllers/history_controller.dart';
import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:drainit_flutter/app/utils/Utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class HistoryView extends GetView<HistoryController> {
  @override
  Widget build(BuildContext context) {
    var selectedFilter = controller.selectedFilter.value;
    return ScreenUtilInit(
      designSize: designSize,
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: TextBold(
            text: "Riwayat Laporan",
            fontSize: ScreenUtil().setSp(23),
          ).paddingOnly(left: 15.r),
          elevation: 0,
          backgroundColor: white,
          actions: [
            PopupMenuButton(
              icon: const Icon(Icons.filter_list, color: black),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              onSelected: (value) {
                if (value == "semua") {
                  selectedFilter = "semua";
                  controller.sortHistory(value.toString());
                } else if (value == "terbaru") {
                  selectedFilter = "terbaru";

                  controller.sortHistory(value.toString());
                } else if (value == "terlama") {
                  selectedFilter = "terlama";

                  controller.sortHistory(value.toString());
                } else if (value == "status") {
                  selectedFilter = "status";

                  controller.sortHistory(value.toString());
                } else if (value == "jenis") {
                  selectedFilter = "jenis";
                  controller.sortHistory(value.toString());
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'semua',
                  child: Container(
                    height: 20.h,
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.r, vertical: 5.r),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.r)),
                      color: selectedFilter == "semua" ? green : white,
                    ),
                    child: Text(
                      'Semua',
                      style: TextStyle(
                        color: selectedFilter == "semua" ? white : black,
                        fontSize: 10.sp,
                      ),
                    ),
                  ),
                ),
                PopupMenuItem(
                  value: 'terbaru',
                  child: Container(
                    height: 20.h,
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.r, vertical: 5.r),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.r)),
                      color: selectedFilter == "terbaru" ? green : white,
                    ),
                    child: Text(
                      'Terbaru',
                      style: TextStyle(
                        color: selectedFilter == "terbaru" ? white : black,
                        fontSize: 10.sp,
                      ),
                    ),
                  ),
                ),
                PopupMenuItem(
                  value: 'terlama',
                  child: Container(
                    height: 20.h,
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.r, vertical: 5.r),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.r)),
                      color: selectedFilter == "terlama" ? green : white,
                    ),
                    child: Text(
                      'Terlama',
                      style: TextStyle(
                        color: selectedFilter == "terlama" ? white : black,
                        fontSize: 10.sp,
                      ),
                    ),
                  ),
                ),
                PopupMenuItem(
                  value: 'status',
                  child: Container(
                    height: 20.h,
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.r, vertical: 5.r),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.r)),
                      color: selectedFilter == "status" ? green : white,
                    ),
                    child: Text(
                      'Status',
                      style: TextStyle(
                        color: selectedFilter == "status" ? white : black,
                        fontSize: 10.sp,
                      ),
                    ),
                  ),
                ),
                PopupMenuItem(
                  value: 'jenis',
                  child: Container(
                    height: 20.h,
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.r, vertical: 5.r),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.r)),
                      color: selectedFilter == "jenis" ? green : white,
                    ),
                    child: Text(
                      'Jenis',
                      style: TextStyle(
                        color: selectedFilter == "jenis" ? white : black,
                        fontSize: 10.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.black,
              ),
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: HistorySearchDelegate(controller));
              },
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: controller.obx(
          (state) => SingleChildScrollView(
            child: RefreshIndicator(
              onRefresh: () => controller.loadHistory(),
              child: Builder(
                builder: (context) {
                  controller.sortHistory("semua");
                  return Obx(
                    () => SizedBox(
                      height: 1.sh - (kToolbarHeight * 2),
                      child: controller.sortedList.value.isEmpty
                          ? Center(
                              child: Text(
                                "Tidak ada laporan",
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          : Scrollbar(
                              child:
                                  BuildSortedHistoryList(controller: controller)
                                      .paddingOnly(bottom: 20.h),
                            ),
                    ),
                  );
                },
              ),
            ),
          ),
          onLoading: Center(
            child: CupertinoActivityIndicator(
              radius: 20.w,
            ),
          ),
          onError: (err) => GestureDetector(
            onTap: () => controller.loadHistory(),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/svg/il_no_internet.svg',
                    height: Get.height / 3,
                    width: Get.width / 3,
                  ),
                  SizedBox(height: 20.h),
                  TextPoppinsBold(
                    text: "Tidak dapat menjangkau internet",
                    fontSize: 16.sp,
                    textColour: black,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextPoppinsRegular(
                    text: "Ketuk untuk mencoba lagi!",
                    fontSize: 12.sp,
                    textColour: Colors.black38,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BuildHistoryList extends StatelessWidget {
  const BuildHistoryList({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final HistoryController controller;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: controller.foundList.value.length,
      itemBuilder: (context, index) => controller.foundList.value.isNotEmpty
          ? ListTile(
              dense: true,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 20.r,
                vertical: 10.r,
              ),
              isThreeLine: true,
              onTap: () {
                Get.offNamed(
                  Routes.DETAIL,
                  arguments: controller.foundList.value[index].id,
                );
              },
              title: Text(
                " ${controller.foundList.value[index].namaJalan!}",
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ).paddingAll(5.r),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5.r,
                          vertical: 5.r,
                        ),
                        height: 20.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.r),
                          ),
                          color: controller
                                      .foundList.value[index].tipePengaduan! ==
                                  "Banjir"
                              ? Colors.lightBlue
                              : Colors.brown,
                        ),
                        child: Text(
                          controller.foundList.value[index].tipePengaduan!,
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: white,
                          ),
                        ),
                      ),
                      10.horizontalSpace,
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5.r,
                          vertical: 5.r,
                        ),
                        height: 20.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.r),
                          ),
                          color: getStatusColor(
                            controller.foundList.value[index].statusPengaduan!,
                          ),
                        ),
                        child: Text(
                          controller.foundList.value[index].statusPengaduan!,
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  5.verticalSpace,
                  Text(
                    timeAgoSinceDate(
                        controller.foundList.value[index].createdAt!),
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ).paddingAll(5.r),
              trailing: Image(
                image: CachedNetworkImageProvider(
                    Routes.IMAGEURL + controller.foundList.value[index].foto!),
                height: 50,
                width: 50,
                fit: BoxFit.fill,
              ),
            )
          : Center(
              child: Text(
                "Tidak ada laporan yang ditemukan",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ),
    );
  }
}

class BuildSortedHistoryList extends StatelessWidget {
  const BuildSortedHistoryList({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final HistoryController controller;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: controller.sortedList.value.length,
      itemBuilder: (context, index) => controller.sortedList.value.isNotEmpty
          ? ListTile(
              dense: true,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 20.r,
                vertical: 10.r,
              ),
              isThreeLine: true,
              onTap: () {
                Get.offNamed(Routes.DETAIL,
                    arguments: controller.sortedList.value[index].id);
              },
              title: TextBold(
                text: " ${controller.sortedList.value[index].namaJalan!}",
              ).paddingAll(5.r),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5.r,
                          vertical: 5.r,
                        ),
                        alignment: Alignment.center,
                        height: 30.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.r),
                          ),
                          color: getStatusColor(
                            controller.sortedList.value[index].tipePengaduan!,
                          ),
                        ),
                        child: Text(
                          controller.sortedList.value[index].tipePengaduan!,
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: white,
                          ),
                        ),
                      ),
                      10.horizontalSpace,
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5.r,
                          vertical: 5.r,
                        ),
                        alignment: Alignment.center,
                        height: 30.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.r),
                          ),
                          color: getStatusColor(
                            controller.sortedList.value[index].statusPengaduan!,
                          ),
                        ),
                        child: Text(
                          controller.sortedList.value[index].statusPengaduan!,
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  20.verticalSpace,
                  ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.r),
                    ),
                    child: Image(
                      image: CachedNetworkImageProvider(Routes.IMAGEURL +
                          controller.sortedList.value[index].foto!),
                      height: Get.width / 2,
                      width: Get.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                  5.verticalSpace,
                  Text(
                    timeAgoSinceDate(
                        controller.sortedList.value[index].createdAt!),
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ).paddingAll(5.r),
            )
          : Center(
              child: Text(
                "Tidak ada laporan yang ditemukan",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ),
    );
  }
}
