// ignore_for_file: invalid_use_of_protected_member

import 'package:cached_network_image/cached_network_image.dart';
import 'package:drainit_flutter/app/components/constant.dart';
import 'package:drainit_flutter/app/modules/flood_drainage_list/controllers/flood_drainage_list_controller.dart';
import 'package:drainit_flutter/app/modules/history/controllers/history_controller.dart';
import 'package:drainit_flutter/app/modules/homepage/models/timeline_model.dart';
import 'package:drainit_flutter/app/modules/homepage/providers/timeline_provider.dart';
import 'package:drainit_flutter/app/modules/profile/controllers/profile_controller.dart';
import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:drainit_flutter/app/utils/Utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomepageController extends GetxController with StateMixin {
  GetStorage box = GetStorage();
  final String arguments = Get.arguments.toString();
  final visible = 0.obs;
  final profileC = Get.find<ProfileController>();
  final historyC = Get.find<HistoryController>();
  final floodListC = Get.find<FloodDrainageListController>();
  List<Timeline> timelineList = <Timeline>[].obs;
  List<Timeline> allTimelineList = <Timeline>[].obs;
  RxList<Timeline> sortedList = <Timeline>[].obs;
  RxList<Timeline> foundList = <Timeline>[].obs;
  final dataButton = [
    HomeButtonCustom(
      Routes.REPORTS,
      Icons.file_copy_rounded,
      text: "Buat laporan",
      color: [const Color(0xFFFFCA03), primary],
    ),
    HomeButtonCustom(
      Routes.HISTORY,
      Icons.history_rounded,
      text: "Riwayat laporan",
      color: [primary, header],
    ),
    HomeButtonCustom(
      Routes.FLOOD_DRAINAGE_LIST,
      Icons.map_rounded,
      text: "Peta titik",
      color: [primaryVariant, primary],
    ),
  ];

  @override
  Future<void> onInit() async {
    super.onInit();
    //remove the splash screen
    FlutterNativeSplash.remove();
    change(null, status: RxStatus.empty());
    final regId = await FirebaseMessaging.instance.getToken();
    addDevice(regId ?? "");
    loadTimeline();
    loadAllTimeline();
    getPosition();
  }

  Future<void> loadTimeline() async {
    change(null, status: RxStatus.loading());
    await TimelineProvider()
        .loadTimeline(box.read(Routes.TOKEN) as String)
        .then(
      (value) => {
        timelineList = value,
        change(null, status: RxStatus.success()),
      },
      onError: (err) {
        change(err, status: RxStatus.error());
      },
    );
  }

  Future<void> loadAllTimeline() async {
    change(null, status: RxStatus.loading());
    await TimelineProvider()
        .loadAllimeline(
      box.read(Routes.TOKEN) as String,
      box.read(Routes.USER_ID) as String,
    )
        .then(
      (value) => {
        allTimelineList = value,
        change(null, status: RxStatus.success()),
      },
      onError: (err) {
        change(err, status: RxStatus.error());
      },
    );
  }

  void searchHistory(String name) {
    List<Timeline> filteredList = [];
    if (name == "") {
      filteredList = allTimelineList;
    } else {
      filteredList = allTimelineList
          .where(
            (element) =>
                element.namaJalan!.toLowerCase().contains(name.toLowerCase()),
          )
          .toList();
    }
    foundList.value = filteredList;
  }

  Future<void> upvote(String idPengaduan) async {
    final data = {
      "id_pengaduan": idPengaduan,
      "vote": true,
    };
    await TimelineProvider().vote(
      data,
      box.read(Routes.TOKEN) as String,
    );
  }

  Future<void> downvote(String idPengaduan) async {
    await TimelineProvider().deleteVote(
      idPengaduan,
      box.read(Routes.TOKEN) as String,
    );
  }

  Future<void> addDevice(String deviceId) async {
    await TimelineProvider().addDevice(
      {
        "registration_id": deviceId,
      },
      box.read(Routes.TOKEN) as String,
    );
  }
}

class HomeButtonCustom {
  HomeButtonCustom(
    this.route,
    this.icon, {
    required this.text,
    required this.color,
  });
  final String text;
  final List<Color> color;
  final String route;
  final IconData icon;
}

class HomeSearchDelegate extends SearchDelegate {
  HomeSearchDelegate(this.controller);
  final HomepageController controller;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    controller.searchHistory(query);
    return Obx(
      () => ListView.builder(
        itemCount: controller.foundList.value.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(controller.foundList.value[index].namaJalan!),
          );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    controller.searchHistory(query);
    return ListView.builder(
      itemCount: controller.foundList.value.length,
      itemBuilder: (context, index) => controller.foundList.value.isNotEmpty
          ? ListTile(
              dense: true,
              contentPadding: EdgeInsets.symmetric(
                vertical: 10.h,
                horizontal: 10.w,
              ),
              isThreeLine: true,
              onTap: () {
                Get.toNamed(
                  Routes.DETAIL,
                  arguments: controller.foundList.value[index].id,
                );
              },
              title: Text(
                " ${controller.foundList.value[index].namaJalan!}",
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
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
                          color: controller.foundList.value[index].tipe! ==
                                  "Banjir"
                              ? Colors.lightBlue
                              : Colors.brown,
                        ),
                        child: Text(
                          controller.foundList.value[index].tipe!,
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
                            controller.foundList.value[index].status!,
                          ),
                        ),
                        child: Text(
                          controller.foundList.value[index].status!,
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
                      controller.foundList.value[index].createdAt!,
                    ),
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ).paddingAll(5.r),
              trailing: Image(
                image: CachedNetworkImageProvider(
                  controller.foundList.value[index].foto!,
                ),
                height: 50,
                width: 50,
                fit: BoxFit.fill,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error);
                },
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
