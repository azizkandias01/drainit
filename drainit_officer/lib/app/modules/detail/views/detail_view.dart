import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:drainit_petugas/app/routes/app_pages.dart';
import 'package:drainit_petugas/app/utils/colors.dart';
import 'package:drainit_petugas/app/utils/text_default.dart';
import 'package:drainit_petugas/app/utils/text_poppins.dart';
import 'package:drainit_petugas/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:readmore/readmore.dart';

import '../controllers/detail_controller.dart';
import 'update_laporan_view.dart';

class DetailView extends GetView<DetailController> {
  static final Completer<GoogleMapController> _googleMapsController =
      Completer();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  primary,
                  Colors.white,
                ],
              ),
            ),
          ),
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.adaptive.arrow_back_outlined,
              color: Colors.black,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.black,
              ),
              onPressed: () {
                controller.onInit();
              },
            ),
          ],
          title: TextMedium(
            text: 'Detail Laporan',
          ),
          bottom: TabBar(
            padding: EdgeInsets.all(5.r),
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: primary,
            labelColor: Colors.black,
            tabs: [
              Tab(
                child: TextRegular(
                  text: 'Detail',
                ),
              ),
              Tab(
                child: TextRegular(
                  text: 'Update',
                ),
              ),
              Tab(
                child: TextRegular(
                  text: 'Komentar',
                ),
              ),
            ],
          ),
        ),
        body: controller.obx(
          (state) => TabBarView(
            children: [
              DetailTab(controller: controller),
              SingleChildScrollView(child: UpdateLaporanView()),
              PublicCommunityReview(),
            ],
          ),
          onLoading: Center(
            child: CircularProgressIndicator.adaptive(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            ),
          ),
          onError: (err) => Center(
            child: TextBold(
              text: "Terjadi kesalahan",
            ),
          ),
        ),
      ),
    );
  }

  Container PublicCommunityReview() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextBold(
            text: "Tanggapan Masyarakat",
          ),
          20.verticalSpace,
          Row(
            children: [
              CircleAvatar(
                backgroundImage: const CachedNetworkImageProvider(
                  "https://i.pravatar.cc/300",
                ),
                backgroundColor: Colors.amber,
                minRadius: 20.r,
              ),
              10.horizontalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextBold(
                    text: controller.detail.namaPelapor!,
                    fontSize: 16.sp,
                  ),
                  TextRegular(
                    text: timeAgoSinceDate(controller.detail.createdAt!),
                    textColour: Colors.grey,
                  ),
                ],
              ),
            ],
          ),
          10.verticalSpace,
          Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
          ),
        ],
      ),
    );
  }
}

class DetailTab extends StatelessWidget {
  const DetailTab({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final DetailController controller;

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.verticalSpace,
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: const CachedNetworkImageProvider(
                    "https://i.pravatar.cc/300",
                  ),
                  backgroundColor: Colors.amber,
                  minRadius: 20.r,
                ),
                10.horizontalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextBold(
                      text: "Aziz Kandias",
                    ),
                    TextRegular(
                      text: timeAgoSinceDate(
                        controller.detail.createdAt!,
                      ),
                      textColour: Colors.grey,
                    ),
                  ],
                ),
              ],
            ).paddingOnly(left: 20.w, right: 20.w, bottom: 10.h),
            Container(
              decoration: const BoxDecoration(
                border: Border.fromBorderSide(
                  BorderSide(
                    color: Colors.grey,
                    width: .3,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextBold(
                    text: "Jenis Dan Status Laporan",
                  ),
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
                            controller.detail.tipe!,
                          ),
                        ),
                        child: TextMedium(
                          text: controller.detail.tipe!,
                          textColour: white,
                        ),
                      ),
                      10.horizontalSpace,
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
                            controller.detail.status!,
                          ),
                        ),
                        child: TextMedium(
                          text: controller.detail.status!,
                          textColour: white,
                        ),
                      ),
                    ],
                  ),
                ],
              ).paddingAll(20.r),
            ),
            Container(
              width: Get.width,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: .3,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextBold(
                    text: "Deskripi Laporan",
                  ),
                  10.verticalSpace,
                  Text(
                    '${controller.detail.deskripsi}',
                  )
                ],
              ).paddingAll(20.r),
            ),
            Container(
              width: Get.width,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: .3,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextBold(
                    text: "Nama Jalan",
                  ),
                  10.verticalSpace,
                  Text(
                    '${controller.detail.namaJalan}',
                  )
                ],
              ).paddingAll(20.r),
            ),
            Container(
              width: Get.width,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: .3,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextBold(
                    text: "Laporan Ditangani Oleh",
                  ),
                  10.verticalSpace,
                  Builder(
                    builder: (context) {
                      final petugas = controller.detail.petugas!.length;
                      var namaPetugas = "";
                      for (var i = 0; i < petugas; i++) {
                        namaPetugas +=
                            "${controller.detail.petugas![i].namaPetugas}";
                        if (i < petugas - 1) {
                          namaPetugas += ", ";
                        }
                      }
                      return Row(
                        children: [
                          TextMedium(
                            text: namaPetugas,
                            textColour: Colors.grey,
                          ),
                        ],
                      ).paddingSymmetric(
                        vertical: 10.h,
                      );
                    },
                  )
                ],
              ).paddingAll(20.r),
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: .3,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextBold(
                    text: "Foto dan Lokasi Laporan",
                  ),
                  10.verticalSpace,
                  GestureDetector(
                    onTap: () {
                      Get.to(
                        () => HeroPhotoViewRouteWrapper(
                          maxScale: 3.0,
                          minScale: 0.5,
                          imageProvider: CachedNetworkImageProvider(
                            Routes.IMAGEURL + controller.detail.foto!,
                          ),
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.r),
                      ),
                      child: Hero(
                        tag: "image",
                        child: Image(
                          image: CachedNetworkImageProvider(
                            Routes.IMAGEURL + controller.detail.foto!,
                          ),
                          width: Get.width,
                          height: 200.w,
                          fit: BoxFit.fitWidth,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 200.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.r),
                                ),
                                color: Colors.grey,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  20.verticalSpace,
                  ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.r),
                    ),
                    child: SizedBox(
                      width: Get.width,
                      height: 200.w,
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                            zoom: 15,
                            target: controller
                                .geoToLatlong(controller.detail.geometry!)),
                        markers: <Marker>{
                          Marker(
                              markerId: MarkerId("1"),
                              position: controller
                                  .geoToLatlong(controller.detail.geometry!))
                        },
                      ),
                    ),
                  ),
                ],
              ).paddingAll(20.r),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailWidget extends StatelessWidget {
  const DetailWidget({
    Key? key,
    required this.controller,
    required this.cameraPosition,
    required this.markers,
    required Completer<GoogleMapController> googleMapsController,
  })  : _googleMapsController = googleMapsController,
        super(key: key);

  final DetailController controller;
  final CameraPosition cameraPosition;
  final List<Marker> markers;
  final Completer<GoogleMapController> _googleMapsController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: ScreenUtil().setHeight(9)),
        Container(
          width: 328.w,
          height: 300.h,
          decoration: BoxDecoration(
            color: kMainGreen,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: EdgeInsets.all(10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.r),
                    child: Image(
                      width: 301.w,
                      height: 117.h,
                      fit: BoxFit.fitWidth,
                      errorBuilder: (_, __, ___) {
                        return SizedBox(
                          width: 301.w,
                          height: 117.h,
                        );
                      },
                      image: CachedNetworkImageProvider(Routes.IMAGEURL +
                          (controller.detail.foto ?? "defaultpengaduan.png")),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 9.h,
                      ),
                      TextPoppinsBold(
                        text: "Deskripsi",
                        fontSize: ScreenUtil().setSp(9),
                        textColour: Colors.white,
                      ),
                      SizedBox(
                        height: 9.h,
                      ),
                      ReadMoreText(
                        controller.detail.deskripsi ?? "no description",
                        trimLines: 2,
                        colorClickableText: Colors.pink,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: 'Show more',
                        trimExpandedText: 'Show less',
                        style: GoogleFonts.poppins(
                          fontSize: 9.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        moreStyle: GoogleFonts.poppins(
                          fontSize: 9.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        lessStyle: GoogleFonts.poppins(
                          fontSize: 9.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 13.h,
                      ),
                      TextPoppinsBold(
                        text: "Lokasi",
                        fontSize: ScreenUtil().setSp(9),
                        textColour: Colors.white,
                      ),
                      SizedBox(
                        height: 9.h,
                      ),
                      TextPoppinsBold(
                        text: controller.detail.createdAt ?? "",
                        fontSize: ScreenUtil().setSp(9),
                        textColour: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 29.h,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: TextPoppinsBold(
            text: "Lokasi",
            fontSize: 12.sp,
            textColour: kMainGreen,
          ),
        ),
        SizedBox(
          height: 16.h,
        ),
        Container(
          width: 322.w,
          height: 200.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: kSecondaryGreen,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.w),
            child: GoogleMap(
              mapToolbarEnabled: false,
              myLocationButtonEnabled: false,
              initialCameraPosition: cameraPosition,
              markers: Set.from(markers),
              onMapCreated: (GoogleMapController controller) {
                if (!_googleMapsController.isCompleted) {
                  _googleMapsController.complete(controller);
                }
              },
            ),
          ),
        ),
        SizedBox(
          height: 16.h,
        ),
        TextPoppinsBold(
            text: controller.detail.namaJalan ?? "Lokasi tidak diketahui",
            fontSize: 12.sp),
      ],
    );
  }
}

class TabItemChip extends StatelessWidget {
  final bool isSelected;
  final String text;
  final double height;
  final double width;
  const TabItemChip({
    Key? key,
    required this.text,
    required this.isSelected,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      height: height,
      width: width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isSelected ? kMainGreen : Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
