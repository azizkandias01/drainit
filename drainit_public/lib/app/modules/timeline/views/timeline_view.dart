// ignore_for_file: lines_longer_than_80_chars, avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:drainit_flutter/app/components/constant.dart';
import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:drainit_flutter/app/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../controllers/timeline_controller.dart';

class TimelineView extends GetView<TimelineController> {
  const TimelineView(this.type);

  final String? type;

  @override
  Widget build(BuildContext context) {
    controller.loadTimeline(type ?? 'login');
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      builder: (context) => Scaffold(
        backgroundColor: kBackgroundInput,
        body: SafeArea(
          child: Column(
            children: [
              const TopMenu(),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Sort By :'),
                  SizedBox(
                    width: 4.w,
                  ),
                  Container(
                    width: 183.w,
                    height: 33.h,
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: DropdownButton(
                      alignment: Alignment.bottomCenter,
                      items: const [
                        DropdownMenuItem(
                          child: Text('Date'),
                          value: 1,
                        ),
                        DropdownMenuItem(
                          child: Text('Name'),
                          value: 2,
                        ),
                      ],
                      onChanged: (value) {
                        print(value);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 21.w,
                  ),
                  Container(
                    width: 110.w,
                    height: 33.h,
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: const Center(child: Text('Filter')),
                  ),
                ],
              ),
              SizedBox(
                height: 24.h,
              ),
              controller.obx(
                (state) => SingleChildScrollView(
                  child: SizedBox(
                    width: 374.w,
                    height: 676.h,
                    child: RefreshIndicator(
                      onRefresh: () =>
                          controller.loadTimeline(Get.arguments as String),
                      child: ListView.separated(
                        itemCount: Get.arguments == 'anonymouse'
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
                              'timelineFiltered filtered length :${controller.timeline[index].id}',
                            ),
                            child: Get.arguments == 'anonymouse'
                                ? ListviewItem(
                                    name: controller
                                        .timelineAnonymouse[index].namaPelapor,
                                    foto: controller
                                        .timelineAnonymouse[index].foto,
                                    description: controller
                                        .timelineAnonymouse[index]
                                        .deskripsiPengaduan,
                                    tanggal: controller
                                        .timelineAnonymouse[index].createdAt,
                                    upVote: controller
                                        .timelineAnonymouse[index].upvote,
                                    downVote: controller
                                        .timelineAnonymouse[index].downvote,
                                  )
                                : ListviewItem(
                                    name:
                                        controller.timeline[index].namaPelapor,
                                    foto: controller.timeline[index].foto,
                                    description: controller
                                        .timeline[index].deskripsiPengaduan,
                                    tanggal:
                                        controller.timeline[index].createdAt,
                                    upVote: controller.timeline[index].upvote,
                                    downVote:
                                        controller.timeline[index].downvote,
                                  ),
                          );
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
  const ListviewItem({
    Key? key,
    this.name,
    this.foto,
    this.description,
    this.tanggal,
    this.upVote,
    this.downVote,
  }) : super(key: key);

  final String? name;
  final String? foto;
  final String? description;
  final String? tanggal;
  final int? upVote;
  final int? downVote;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 331.h,
      width: 374.w,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 7.h,
          ),
          Row(
            children: [
              SizedBox(
                width: 16.w,
              ),
              CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(
                  imagePath() + foto!,
                  scale: 32.w,
                  errorListener: () => const Center(
                    child: Text('image not loaded'),
                  ),
                ),
                onBackgroundImageError: (object, trace) {
                  print('error object');
                },
              ),
              SizedBox(
                width: 10.w,
              ),
              SizedBox(
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
                        name ?? 'anonymouse',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: kTextPurple,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        tanggal!,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: kColorGrey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              SvgPicture.asset(
                'assets/svg/clock.svg',
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
          SizedBox(
            height: 40.h,
            width: 343.w,
            child: Text(
              description ??
                  'Sampah di dekat selokan jalan sampurna menyebabkan air tersumbat dan banjir ',
              style: TextStyle(
                fontSize: 12.sp,
                color: kColorGrey,
              ),
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          Image(
            image: CachedNetworkImageProvider(
              imagePath() + foto!,
              errorListener: () => const Center(
                child: Text('image not loaded'),
              ),
            ),
            width: 351.w,
            height: 157.h,
            fit: BoxFit.fitWidth,
            errorBuilder: (_, __, ___) {
              return const Center(
                child: Text('Image error'),
              );
            },
          ),
          SizedBox(
            height: 15.h,
          ),
          // Padding(
          //   padding: EdgeInsets.only(right: 15.h),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     children: [
          //       Icon(
          //         LineIcons.thumbsUp,
          //         size: 15.w,
          //       ),
          //       Text(
          //         upVote.toString(),
          //         style: TextStyle(
          //           fontSize: 12.sp,
          //           color: kColorGrey,
          //         ),
          //       ),
          //       SizedBox(
          //         width: 20.w,
          //       ),
          //       Icon(
          //         LineIcons.thumbsDown,
          //         size: 15.w,
          //       ),
          //       Text(
          //         downVote.toString(),
          //         style: TextStyle(
          //           fontSize: 12.sp,
          //           color: kColorGrey,
          //         ),
          //       )
          //     ],
          //   ),
          // ),
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
    return SizedBox(
      height: 64.h,
      width: 387.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SvgPicture.asset(
            'assets/svg/Back_Icon.svg',
          ),
          const Spacer(),
          Text(
            'Timeline',
            style: TextStyle(
              fontFamily: 'Klasik',
              fontSize: 16.sp,
              color: kTextPurple,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.PROFILE);
            },
            child: Image.asset('assets/image/ProfileImage.png'),
          ),
        ],
      ),
    );
  }
}
