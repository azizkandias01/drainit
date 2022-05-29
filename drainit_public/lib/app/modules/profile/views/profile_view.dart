// ignore_for_file: avoid_print

import 'package:drainit_flutter/app/components/constant.dart';
import 'package:drainit_flutter/app/components/text_default.dart';
import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:drainit_flutter/app/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../components/text_poppins.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(color: black),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.refresh,
              color: Colors.black,
            ),
            onPressed: () => {
              controller.getAccountProfile(),
            },
          ),
        ],
      ),
      body: controller.obx(
        (state) => BodyBuild(controller: controller),
        onLoading: const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
        onError: (err) => OnErrorBuilder(controller: controller),
      ),
    );
  }
}

class BodyBuild extends StatelessWidget {
  const BodyBuild({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileTopBar(controller: controller),
            10.verticalSpace,
            Text(
              'My Profile',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ).paddingOnly(left: 20.r),
            PersonInfo(controller: controller).paddingAll(10.r),
            10.verticalSpace,
            Text(
              'Jumlah laporan',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ).paddingOnly(left: 20.r),
            const PersonReport().paddingAll(10.r),
            Text(
              'Keluar',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ).paddingOnly(left: 20.r),
            GestureDetector(
              onTap: () => controller.logoutAccount(),
              child: Container(
                color: white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Log out',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward,
                      color: Colors.black,
                    ),
                  ],
                ).paddingAll(20.r),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PersonReport extends StatelessWidget {
  const PersonReport({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.report,
                  color: Colors.black,
                ),
                10.horizontalSpace,
                Text(
                  'Total laporan',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
            Text(
              '10',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ).paddingAll(10.r),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.hourglass_bottom,
                  color: Colors.black,
                ),
                10.horizontalSpace,
                Text(
                  'Laporan diproses',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
            Text(
              '2',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ).paddingAll(10.r),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.check_circle,
                  color: Colors.black,
                ),
                10.horizontalSpace,
                Text(
                  'Laporan selesai',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
            Text(
              '8',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ).paddingAll(10.r),
      ],
    );
  }
}

class PersonInfo extends StatelessWidget {
  const PersonInfo({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.phone,
                  color: Colors.black,
                ),
                10.horizontalSpace,
                Text(
                  'Nomor Telepon',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
            Text(
              '${controller.dataProfile.noHp}',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ).paddingAll(10.r),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.mail,
                  color: Colors.black,
                ),
                10.horizontalSpace,
                Text(
                  'Email',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
            Text(
              '${controller.dataProfile.email}',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ).paddingAll(10.r),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.place,
                  color: Colors.black,
                ),
                10.horizontalSpace,
                Text(
                  'Alamat',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
            Text(
              '${controller.dataProfile.alamat}',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ).paddingAll(10.r),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.today,
                  color: Colors.black,
                ),
                10.horizontalSpace,
                Text(
                  'Akun dibuat',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
            Text(
              timeAgoSinceDate(controller.dataProfile.createdAt!),
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ).paddingAll(10.r),
        GestureDetector(
          onTap: () {
            Get.toNamed(Routes.EDIT_PROFILE, arguments: controller.dataProfile);
          },
          child: Container(
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.edit,
                      color: Colors.black,
                    ),
                    10.horizontalSpace,
                    Text(
                      'Edit Profil',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                const Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                ),
              ],
            ).paddingAll(10.r),
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.toNamed(Routes.EDIT_PASSWORD);
          },
          child: Container(
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.lock,
                      color: Colors.black,
                    ),
                    10.horizontalSpace,
                    Text(
                      'Edit password',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                const Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                ),
              ],
            ).paddingAll(10.r),
          ),
        ),
      ],
    );
  }
}

class OnErrorBuilder extends StatelessWidget {
  const OnErrorBuilder({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.getAccountProfile(),
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
            TextBold(
              text: "Tidak dapat menjangkau internet",
              fontSize: 16.sp,
              textColour: black,
            ),
            SizedBox(
              height: 10.h,
            ),
            TextRegular(
              text: "Ketuk untuk mencoba lagi!",
              fontSize: 12.sp,
              textColour: Colors.black38,
            )
          ],
        ),
      ),
    );
  }
}

class ProfileTopBar extends StatelessWidget {
  const ProfileTopBar({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          20.verticalSpace,
          CircleAvatar(
            maxRadius: ScreenUtil().setWidth(40),
            minRadius: ScreenUtil().setWidth(40),
            backgroundImage: NetworkImage(
              controller.dataProfile.foto!.contains('.jp')
                  ? Routes.IMAGEURL + controller.dataProfile.foto!
                  : 'https://random.imagecdn.app/500/150',
            ),
            backgroundColor: green,
          ),
          20.verticalSpace,
          Text(
            controller.dataProfile.nama!,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            controller.dataProfile.email!,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.normal,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
