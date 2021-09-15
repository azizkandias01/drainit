import 'package:cached_network_image/cached_network_image.dart';
import 'package:drainit_flutter/app/components/constant.dart';
import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:drainit_flutter/app/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import '../controllers/timeline_controller.dart';

class TimelineView extends GetView<TimelineController> {
  final String? type;

  const TimelineView(this.type);
  @override
  Widget build(BuildContext context) {
    controller.loadTimeline(type ?? "login");
    return ScreenUtilInit(
      designSize: Size(414, 896),
      builder: () => Scaffold(
        backgroundColor: kBackgroundInput,
        body: SafeArea(
          child: Column(
            children: [
              TopMenu(),
              SizedBox(
                height: 20.h,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Sort By :"),
                    SizedBox(
                      width: 4.w,
                    ),
                    Container(
                      width: 183.w,
                      height: 33.h,
                      decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(12.r)),
                      child: Center(child: Text("Popular")),
                    ),
                    SizedBox(
                      width: 21.w,
                    ),
                    Container(
                      width: 110.w,
                      height: 33.h,
                      decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(12.r)),
                      child: Center(child: Text("Filter")),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              controller.obx(
                (state) => SingleChildScrollView(
                  child: Container(
                    width: 374.w,
                    height: 676.h,
                    child: RefreshIndicator(
                      onRefresh: () => controller.loadTimeline(Get.arguments),
                      child: ListView.separated(
                        itemCount: Get.arguments == "anonymouse"
                            ? controller.timelineAnonymouse.length
                            : controller.timeline.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: 14.h,
                          );
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                              onTap: () => print(
                                  "timelineFiltered filtered length :" +
                                      controller.timeline[index].id.toString()),
                              child: Get.arguments == "anonymouse"
                                  ? ListviewItem(
                                      name: controller.timelineAnonymouse[index]
                                          .namaPelapor,
                                      foto: controller
                                          .timelineAnonymouse[index].foto,
                                      description: controller
                                          .timelineAnonymouse[index]
                                          .deskripsiPengaduan,
                                      upVote: controller
                                          .timelineAnonymouse[index].upvote,
                                      downVote: controller
                                          .timelineAnonymouse[index].downvote,
                                    )
                                  : ListviewItem(
                                      name: controller
                                          .timeline[index].namaPelapor,
                                      foto: controller.timeline[index].foto,
                                      description: controller
                                          .timeline[index].deskripsiPengaduan,
                                      upVote: controller.timeline[index].upvote,
                                      downVote:
                                          controller.timeline[index].downvote,
                                    ));
                        },
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
}

class ListviewItem extends StatelessWidget {
  final String? name;
  final String? foto;
  final String? description;
  final int? upVote;
  final int? downVote;

  const ListviewItem({
    Key? key,
    this.name,
    this.foto,
    this.description,
    this.upVote,
    this.downVote,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 331.h,
      width: 374.w,
      decoration: BoxDecoration(
          color: white, borderRadius: BorderRadius.circular(12.r)),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 16.w,
              ),
              CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(
                  imagePath() + foto!,
                  scale: 32.w,
                  errorListener: () => Center(
                    child: Text("image not loaded"),
                  ),
                ),
                onBackgroundImageError: (object, trace) {
                  print("error object");
                },
              ),
              SizedBox(
                width: 10.w,
              ),
              Container(
                width: 215.w,
                height: 60.h,
                child: Column(
                  children: [
                    SizedBox(
                      height: 12.h,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        name ?? "anonymouse",
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: kTextPurple),
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Beginner",
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: kColorGrey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              SvgPicture.asset(
                "assets/svg/clock.svg",
                height: 38.h,
                width: 38.w,
              ),
              SizedBox(
                width: 10.w,
              )
            ],
          ),
          SizedBox(
            height: 15.h,
          ),
          Container(
            height: 40.h,
            width: 343.w,
            child: Text(description ??
                "Sampah di dekat selokan jalan sampurna menyebabkan air tersumbat dan banjir "),
          ),
          SizedBox(
            height: 15.h,
          ),
          Image(
            image: CachedNetworkImageProvider(
              imagePath() + foto!,
              errorListener: () => Center(
                child: Text("image not loaded"),
              ),
            ),
            width: 351.w,
            height: 157.h,
            fit: BoxFit.fitWidth,
            errorBuilder: (_, __, ___) {
              return Center(
                child: Text("Image error"),
              );
            },
          ),
          SizedBox(
            height: 15.h,
          ),
          Padding(
            padding: EdgeInsets.only(right: 15.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(LineIcons.thumbsUp),
                Text(upVote.toString()),
                SizedBox(
                  width: 20.w,
                ),
                Icon(LineIcons.thumbsDown),
                Text(downVote.toString())
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TopMenu extends StatelessWidget {
  const TopMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64.h,
      width: 387.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SvgPicture.asset(
            "assets/svg/Back_Icon.svg",
          ),
          Spacer(),
          Text(
            "Timeline",
            style: TextStyle(
                fontFamily: 'Klasik', fontSize: 16.sp, color: kTextPurple),
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.PROFILE);
            },
            child: Image.asset("assets/image/ProfileImage.png"),
          ),
        ],
      ),
    );
  }
}
