import 'package:cached_network_image/cached_network_image.dart';
import 'package:drainit_flutter/app/components/constant.dart';
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
    return ScreenUtilInit(
      designSize: designSize,
      builder: () => Scaffold(
        appBar: AppBar(
          title: const Text(
            "Riwayat Laporan",
            style: TextStyle(
              color: black,
            ),
          ),
          elevation: 0,
          backgroundColor: white,
          centerTitle: true,
          leading: PopupMenuButton(
            icon: const Icon(Icons.filter_list, color: black),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            onSelected: (value) {
              if (value == "semua") {
                controller.sortHistory(value.toString());
              } else if (value == "terbaru") {
                controller.sortHistory(value.toString());
              } else if (value == "terlama") {
                controller.sortHistory(value.toString());
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'semua',
                onTap: () {
                  controller.selectedFilter.value = "semua";
                },
                child: Container(
                    color: controller.selectedFilter.value == "semua"
                        ? red
                        : white,
                    child: Text('Semua')),
              ),
              PopupMenuItem(
                value: 'terbaru',
                onTap: () {
                  controller.selectedFilter.value = "terbaru";
                },
                child: Container(
                    color: controller.selectedFilter.value == "terbaru"
                        ? red
                        : white,
                    child: Text('terbaru')),
              ),
              PopupMenuItem(
                value: 'terlama',
                onTap: () {
                  controller.selectedFilter.value = "terlama";
                },
                child: Container(
                    color: controller.selectedFilter.value == "terlama"
                        ? red
                        : white,
                    child: Text('terlama')),
              ),
              PopupMenuItem(
                value: 'status',
                onTap: () {
                  controller.selectedFilter.value = "status";
                  controller.sortHistory("status");
                },
                child: Container(
                    padding: EdgeInsets.all(10.r),
                    color: controller.selectedFilter.value == "status"
                        ? green
                        : white,
                    child: Text('status')),
              ),
              PopupMenuItem(
                value: 'jenis',
                onTap: () {
                  controller.selectedFilter.value = "jenis";
                  controller.sortHistory("jenis");
                },
                child: Container(
                    color: controller.selectedFilter.value == "jenis"
                        ? red
                        : white,
                    child: Text('jenis')),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.info_outline_rounded,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: controller.obx(
          (state) => SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 60.h,
                  child: TextField(
                    controller: controller.searchController,
                    onChanged: (value) {
                      controller.searchHistory(value);
                    },
                    decoration: InputDecoration(
                      hintText: "Cari laporan",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 10.sp,
                      ),
                      suffixIcon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ).paddingAll(10.r),
                ),
                RefreshIndicator(
                  onRefresh: () => controller.loadHistory(),
                  child: Builder(
                    builder: (context) {
                      controller.searchHistory("");
                      return SizedBox(
                        height: Get.height,
                        child: Obx(
                          () => controller.list.isEmpty
                              ? Center(
                                  child: Text(
                                    "Tidak ada laporan",
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: controller.foundList.value.length,
                                  itemBuilder: (context, index) => ListTile(
                                    dense: true,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20.r,
                                      vertical: 10.r,
                                    ),
                                    isThreeLine: true,
                                    onTap: () {
                                      Get.offNamed(Routes.DETAIL,
                                          arguments: controller
                                              .foundList.value[index].id);
                                    },
                                    title: Text(
                                      " ${controller.foundList.value[index].namaJalan!}",
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ).paddingAll(5.r),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                            .foundList
                                                            .value[index]
                                                            .tipePengaduan! ==
                                                        "Banjir"
                                                    ? Colors.lightBlue
                                                    : Colors.brown,
                                              ),
                                              child: Text(
                                                controller
                                                    .foundList
                                                    .value[index]
                                                    .tipePengaduan!,
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
                                                color:
                                                    controller.getStatusColor(
                                                  controller
                                                      .foundList
                                                      .value[index]
                                                      .statusPengaduan!,
                                                ),
                                              ),
                                              child: Text(
                                                controller
                                                    .foundList
                                                    .value[index]
                                                    .statusPengaduan!,
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
                                          timeAgoSinceDate(controller.foundList
                                              .value[index].createdAt!),
                                          style: TextStyle(
                                            fontSize: 11.sp,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ).paddingAll(5.r),
                                    trailing: Image(
                                      image: CachedNetworkImageProvider(
                                          Routes.IMAGEURL +
                                              controller.foundList.value[index]
                                                  .foto!),
                                      height: 50,
                                      width: 50,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                        ),
                      );
                    },
                  ),
                ),
              ],
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
