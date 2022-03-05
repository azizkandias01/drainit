import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:drainit_petugas/app/routes/app_pages.dart';
import 'package:drainit_petugas/app/utils/colors.dart';
import 'package:drainit_petugas/app/utils/rounded_button.dart';
import 'package:drainit_petugas/app/utils/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:line_icons/line_icon.dart';
import 'package:readmore/readmore.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  static final Completer<GoogleMapController> _googleMapsController =
      Completer();
  @override
  Widget build(BuildContext context) {
    List<Marker> markers = <Marker>[
      Marker(
          markerId: MarkerId('1'),
          position: controller.geoToLatlong(controller.geometry)),
    ];
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: () => Scaffold(
        body: controller.obx(
          (state) => NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  iconTheme: IconThemeData(color: Colors.black),
                  expandedHeight: ScreenUtil().setHeight(100),
                  backgroundColor: Colors.white,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: false,
                    titlePadding: EdgeInsets.only(
                      left: ScreenUtil().setWidth(40),
                      bottom: ScreenUtil().setHeight(20),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: ScreenUtil().setWidth(100),
                          child: TextPoppinsBold(
                            text: 'Detail \nLaporan',
                            fontSize: ScreenUtil().setSp(18),
                            textColour: Colors.black,
                          ),
                        ),
                        Container(
                          width: 50.w,
                          child: TextPoppinsBold(
                            text: 'Selesai',
                            fontSize: ScreenUtil().setSp(10),
                            textColour: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ];
            },
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 23.w, right: 15.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppBar(
                      controller: controller,
                    ),
                    Obx(
                      () {
                        if (controller.page.value == 0) {
                          return DetailWidget(
                            controller: controller,
                            cameraPosition: CameraPosition(
                              target:
                                  controller.geoToLatlong(controller.geometry),
                              zoom: 17,
                            ),
                            markers: markers,
                            googleMapsController: _googleMapsController,
                          );
                        }
                        if (controller.page.value == 1) {
                          return UpdateLaporanWidget();
                        } else {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: ScreenUtil().setHeight(20),
                              ),
                              TextPoppinsBold(
                                text: "Feedback Masyarakat",
                                fontSize: 18.sp,
                                textColour: kMainGreen,
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(20),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  LineIcon.star(
                                    color: Colors.amber,
                                    size: ScreenUtil().setWidth(50),
                                  ),
                                  LineIcon.star(
                                    color: Colors.amber,
                                    size: ScreenUtil().setWidth(50),
                                  ),
                                  LineIcon.star(
                                    color: Colors.amber,
                                    size: ScreenUtil().setWidth(50),
                                  ),
                                  LineIcon.star(
                                    color: Colors.amber,
                                    size: ScreenUtil().setWidth(50),
                                  ),
                                  LineIcon.star(
                                    color: Colors.amber,
                                    size: ScreenUtil().setWidth(50),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(20),
                              ),
                              TextField(
                                maxLines: 5,
                                decoration: InputDecoration(
                                  hintText:
                                      "Drainase tersumbat sudah diperbaiki dan sudah berjalan sesuai dengan semestinya",
                                  hintStyle: GoogleFonts.poppins(
                                    fontSize: ScreenUtil().setSp(14),
                                    color: Colors.grey,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          onLoading: Center(
            child: CircularProgressIndicator(),
          ),
          onError: (err) => Container(
            child: Center(
              child: Text(
                err.toString(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class UpdateLaporanWidget extends StatelessWidget {
  const UpdateLaporanWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 37.h,
        ),
        TextField(
          maxLines: 5,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            labelText: 'Deskripsi',
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            LineIcon.camera(
              size: 30.w,
            ),
            RoundedButtonWidget(
                buttonText: "Update Laporan", width: 150.w, onpressed: () {}),
          ],
        ),
        TextPoppinsBold(
          text: "Laporan Petugas",
          fontSize: 12.sp,
          textColour: kMainGreen,
        ),
        SizedBox(
          width: 414.w,
          height: 1000.h,
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
                    color: kMainGreen,
                  ),
                  child: Column(
                    children: [Text("Laporan $id")],
                  ),
                ),
              ),
              startChild: Container(
                color: kSecondaryGreen,
                child: Text("Senin"),
              ),
            ),
            itemCount: 20,
          ),
        ),
      ],
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
                        controller.detail.deskripsiPengaduan ??
                            "no description",
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

class AppBar extends StatelessWidget {
  final DetailController controller;

  const AppBar({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    controller.page.value = 0;
                  },
                  child: TabItemChip(
                    isSelected: controller.page.value == 0,
                    text: "Detail",
                    width: 90.w,
                    height: 40.h,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.page.value = 1;
                  },
                  child: TabItemChip(
                    isSelected: controller.page.value == 1,
                    text: "Update Laporan",
                    width: 120.w,
                    height: 40.h,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.page.value = 2;
                  },
                  child: TabItemChip(
                    isSelected: controller.page.value == 2,
                    text: "Feedback",
                    width: 90.w,
                    height: 40.h,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
