import 'package:drainit_flutter/app/components/constant.dart';
import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import '../controllers/timeline_controller.dart';

class TimelineView extends GetView<TimelineController> {
  List<String> dropdownValue = ["oke, deh", "Mantap"];
  @override
  Widget build(BuildContext context) {
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
              SingleChildScrollView(
                child: Container(
                  width: 374.w,
                  height: 676.h,
                  child: ListView.separated(
                    itemCount: 10,
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 14.h,
                      );
                    },
                    itemBuilder: (BuildContext context, int Index) {
                      return GestureDetector(
                          onTap: () => print("posringan index ke $Index"),
                          child: ListviewItem());
                    },
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
              Image.asset(
                "assets/image/ProfileImage.png",
                height: 32.h,
                width: 32.w,
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
                        "Aziz Kandias",
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
            child: Text(
                "Sampah di dekat selokan jalan sampurna menyebabkan air tersumbat dan banjir "),
          ),
          SizedBox(
            height: 15.h,
          ),
          Container(
            height: 157.h,
            width: 351.w,
            color: kTextPurple,
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
                Text("28"),
                SizedBox(
                  width: 20.w,
                ),
                Icon(LineIcons.thumbsDown),
                Text("3")
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
