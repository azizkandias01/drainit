import 'package:cached_network_image/cached_network_image.dart';
import 'package:drainit_flutter/app/components/constant.dart';
import 'package:drainit_flutter/app/utils/Utils.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../components/text_poppins.dart';
import '../../../routes/app_pages.dart';
import '../controllers/history_controller.dart';

class HistoryView extends GetView<HistoryController> {
  @override
  Widget build(BuildContext context) {
    List<Widget> _buildList() {
      final List<Widget> listItems = [];

      for (int i = 0; i < controller.list.length; i++) {
        final isBanjir = controller.list[i].tipePengaduan == 'banjir';
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
                      SizedBox(
                        width: 325.w,
                        height: 122.h,
                        child: isBanjir
                            ? Image.asset(
                                "assets/image/bg_tersumbat.png",
                                fit: BoxFit.fill,
                              )
                            : SvgPicture.asset(
                                "assets/image/bg_tersumbat.png",
                                fit: BoxFit.fill,
                              ),
                      ),
                      SizedBox(
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
                                    return Container(
                                      width: 147.w,
                                      height: 97.h,
                                      color: Colors.white,
                                      child: Center(
                                        child: TextPoppinsBold(
                                          text: "cannot load image",
                                          fontSize: 8.sp,
                                        ),
                                      ),
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
                                    TextPoppinsBold(
                                      text: controller.list[i].namaJalan ?? "",
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 11.sp,
                                      textColour: Colors.white,
                                    ),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    TextPoppinsBold(
                                      text: controller.list[i].createdAt ?? "",
                                      fontSize: 11.sp,
                                      textColour: Colors.white,
                                      overflow: TextOverflow.ellipsis,
                                    ),
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
      return listItems.isEmpty
          ? [
              Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: Column(
                  children: [
                    Center(
                      child: SvgPicture.asset(
                        "assets/svg/il_no_data.svg",
                        width: Get.width / 2,
                        height: Get.height / 2,
                      ),
                    ),
                    TextPoppinsBold(
                      text: "Tidak ada data laporan",
                      fontSize: 16.sp,
                      textColour: Colors.black,
                    ),
                  ],
                ),
              ),
            ]
          : listItems;
    }

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () => Scaffold(
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        floatingActionButton: FloatingActionBubble(
          // Menu items
          items: <Bubble>[
            // Floating action menu item
            Bubble(
              title: "Settings",
              iconColor: Colors.white,
              bubbleColor: Colors.blue,
              icon: Icons.settings,
              titleStyle: TextStyle(fontSize: 16, color: Colors.white),
              onPress: () {
                controller.animationController.reverse();
              },
            ),
            // Floating action menu item
            Bubble(
              title: "Profile",
              iconColor: Colors.white,
              bubbleColor: Colors.blue,
              icon: Icons.people,
              titleStyle: TextStyle(fontSize: 16, color: Colors.white),
              onPress: () {
                controller.animationController.reverse();
              },
            ),
            //Floating action menu item
            Bubble(
              title: "Home",
              iconColor: Colors.white,
              bubbleColor: Colors.blue,
              icon: Icons.home,
              titleStyle: TextStyle(fontSize: 16, color: Colors.white),
              onPress: () {
                print("Home");
                controller.animationController.reverse();
              },
            ),
          ],

          // animation controller
          animation: controller.animation,

          // On pressed change animation state
          onPress: () => controller.animationController.isCompleted
              ? controller.animationController.reverse()
              : controller.animationController.forward(),

          // Floating Action button Icon color
          iconColor: green,

          // Flaoting Action button Icon
          iconData: Icons.align_vertical_bottom_outlined,
          backGroundColor: Colors.white,
        ),
        body: controller.obx(
          (state) => RefreshIndicator(
            onRefresh: () {
              return controller.loadHistory();
            },
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: ScreenUtil().setHeight(100),
                  backgroundColor: white,
                  flexibleSpace: FlexibleSpaceBar(
                    titlePadding: EdgeInsets.only(
                      left: ScreenUtil().setWidth(30),
                      top: ScreenUtil().setHeight(50),
                    ),
                    title: TextPoppinsBold(
                      text: 'Riwayat \nLaporan',
                      fontSize: ScreenUtil().setSp(16),
                      textColour: Colors.black,
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate.fixed(_buildList()),
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

  Widget historyItem(
    String foto,
    String status,
    String jenis,
    String lokasi,
    Function() onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
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
                            return SizedBox(
                              width: 167.w,
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
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class oldWidget extends StatelessWidget {
  const oldWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final HistoryController controller;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: ScreenUtil().setHeight(100),
          backgroundColor: green,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Text(
              'History',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(30),
                ),
              ),
            ),
          ),
        ),
        SliverList(
            delegate: SliverChildListDelegate.fixed(controller.buildList()))
      ],
    );
  }
}
