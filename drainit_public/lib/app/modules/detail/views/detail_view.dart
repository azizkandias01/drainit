import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:drainit_flutter/app/components/constant.dart';
import 'package:drainit_flutter/app/components/rounded_button.dart';
import 'package:drainit_flutter/app/components/text_poppins.dart';
import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:drainit_flutter/app/utils/Utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:line_icons/line_icons.dart';

import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    final Completer<GoogleMapController> _googleMapsController = Completer();
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      builder: () => WillPopScope(
        onWillPop: () async {
          Get.offAllNamed(Routes.HOME, parameters: {'index': "1"});
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: white,
            elevation: 0,
            title: const Text(
              "Detail Laporan",
              style: TextStyle(color: black),
            ),
            centerTitle: true,
            toolbarHeight: 50.h,
            leading: IconButton(
              iconSize: 24.sp,
              icon: const Icon(
                Icons.arrow_back_outlined,
                color: black,
              ),
              onPressed: () {
                print("back");
              },
            ),
            actions: [
              IconButton(
                iconSize: 24.sp,
                icon: const Icon(
                  Icons.more_horiz_outlined,
                  color: black,
                ),
                onPressed: () {
                  print("back");
                },
              )
            ],
          ),
          backgroundColor: Colors.white,
          body: controller.obx(
            (state) => SafeArea(
              bottom: false,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Scrollbar(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    const CachedNetworkImageProvider(
                                  "https://i.pravatar.cc/300",
                                ),
                                backgroundColor: Colors.amber,
                                minRadius: 20.r,
                              ),
                              10.horizontalSpace,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextPoppinsBold(
                                    text: "Aziz Kandias",
                                    fontSize: 12.sp,
                                    textColour: black,
                                  ),
                                  TextPoppinsRegular(
                                    text:
                                        "${timeAgoSinceDate(controller.detail.createdAt!)}",
                                    fontSize: 11.sp,
                                    textColour: Colors.grey,
                                  ),
                                ],
                              ),
                            ],
                          ).paddingOnly(left: 20.w, right: 20.w),
                          20.verticalSpace,
                          Text("Lorem ipsum, atau ringkasnya lipsum, adalah teks standar yang ditempatkan untuk mendemostrasikan elemen grafis atau presentasi visual seperti font, tipografi, dan tata letak.")
                              .paddingOnly(left: 20.w, right: 20.w),
                          20.verticalSpace,
                          20.verticalSpace,
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.to(
                                    HeroPhotoViewRouteWrapper(
                                      maxScale: 3.0,
                                      minScale: 0.5,
                                      imageProvider: CachedNetworkImageProvider(
                                        Routes.IMAGEURL +
                                            controller.detail.foto!,
                                      ),
                                    ),
                                  );
                                },
                                child: Hero(
                                  tag: "image",
                                  child: Image(
                                    image: CachedNetworkImageProvider(
                                      Routes.IMAGEURL + controller.detail.foto!,
                                    ),
                                    width: Get.width / 2,
                                    height: Get.width,
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Get.width / 2,
                                height: Get.width,
                                child: GoogleMap(
                                  initialCameraPosition: CameraPosition(
                                      zoom: 15,
                                      target: controller.geoToLatlong(
                                          controller.detail.geometry!)),
                                  markers: <Marker>{
                                    Marker(
                                        markerId: MarkerId("1"),
                                        position: controller.geoToLatlong(
                                            controller.detail.geometry!))
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      iconSize: 25.sp,
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.thumb_up_off_alt,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    TextPoppinsRegular(
                                      text: "Like",
                                      fontSize: 12.sp,
                                      textColour: Colors.grey,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      iconSize: 25.r,
                                      onPressed: () {},
                                      icon: const Icon(
                                        LineIcons.comment,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    TextPoppinsRegular(
                                      text: "Update",
                                      fontSize: 12.sp,
                                      textColour: Colors.grey,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      iconSize: 25.sp,
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.star_outline,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    TextPoppinsRegular(
                                      text: "Beri rating",
                                      fontSize: 12.sp,
                                      textColour: Colors.grey,
                                    ),
                                  ],
                                ),
                              ],
                            ).paddingOnly(left: 40.w, right: 40.w),
                          ),
                          Divider(
                            thickness: 1.h,
                          ),
                          const Text("Riwayat Update Laporan")
                              .paddingOnly(left: 20.w),
                          for (int i = 0;
                              i < controller.updateReport.value.length;
                              i++)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      const CachedNetworkImageProvider(
                                    "https://i.pravatar.cc/300",
                                  ),
                                  backgroundColor: Colors.amber,
                                  minRadius: 20.r,
                                ),
                                10.horizontalSpace,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.r),
                                        color: Colors.grey[200],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${controller.updateReport.value[i].namaPetugas}",
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          5.verticalSpace,
                                          Text(
                                            "Update: ${controller.updateReport.value[i].judul}",
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          5.verticalSpace,
                                          TextPoppinsRegular(
                                            text:
                                                "${controller.updateReport.value[i].deskripsi}",
                                            fontSize: 11.sp,
                                            textColour: black,
                                          ),
                                        ],
                                      ).paddingAll(10.r),
                                    ),
                                    TextPoppinsRegular(
                                      text:
                                          "${controller.updateReport.value[i].waktu}",
                                      fontSize: 11.sp,
                                      textColour: Colors.grey,
                                    ),
                                    5.verticalSpace,
                                    Visibility(
                                      visible: controller
                                              .updateReport.value[i].foto !=
                                          "tidak ada",
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        child: const Image(
                                          image: CachedNetworkImageProvider(
                                              "https://random.imagecdn.app/300/200"),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ).paddingOnly(left: 20.w, right: 20.w, top: 10.h),
                          50.verticalSpace,
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: Get.width,
                    height: 50.h,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        top: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Container(
                            height: 40.h,
                            color: Colors.grey[200],
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "Tambahkan feedback anda",
                                hintStyle: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.grey,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.send,
                          color: Colors.grey,
                        ),
                      ],
                    ).paddingOnly(left: 20.w, right: 20.w),
                  ),
                ],
              ),
            ),
            onError: (err) {
              return GestureDetector(
                onTap: () {
                  Get.offNamedUntil(
                    Routes.HOME,
                    ModalRoute.withName(Routes.DETAIL),
                  );
                },
                child: const Center(
                  child: Text("Kembali"),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _FlexibleSpaceHeader extends GetView<DetailController> {
  const _FlexibleSpaceHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 120.h,
      collapsedHeight: 120.h,
      leading: const SizedBox(),
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.only(left: 30.w, right: 30.w),
        collapseMode: CollapseMode.pin,
        title: Stack(
          children: [
            TextPoppinsBold(
              text: "Detail\nLaporan",
              fontSize: 36.sp,
              textColour: black,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: RoundedButton(
                text: "Selesai",
                width: 100.w,
                height: 50.h,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final maxHeaderExtent = 80.0.h;

class _HeaderSliver extends SliverPersistentHeaderDelegate {
  final controller = Get.find<DetailController>();
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final percent = shrinkOffset / maxHeaderExtent;
    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      bottom: 0,
      child: Container(
        height: maxHeaderExtent,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(left: 30.w, right: 30.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RoundedButton(
                text: "Detail",
                width: 80.w,
                height: 40.h,
                color: green2,
                textColor: white,
              ),
              RoundedButton(
                text: "Update Laporan",
                width: 150.w,
                height: 40.h,
                color: green2,
                textColor: white,
              ),
              RoundedButton(
                text: "Feedback",
                width: 100.w,
                height: 40.h,
                color: green2,
                textColor: white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => maxHeaderExtent;

  @override
  // TODO: implement minExtent
  double get minExtent => maxHeaderExtent;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
