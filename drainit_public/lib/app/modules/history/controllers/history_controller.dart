import 'package:drainit_flutter/app/modules/history/models/history_model.dart';
import 'package:drainit_flutter/app/modules/history/providers/history_provider.dart';
import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:drainit_flutter/app/utils/Utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

///controller for handling history
class HistoryController extends GetxController with StateMixin {
  ///list of history that user has reported to system
  List<HistoryModel> list = [];
  RxList<HistoryModel> foundList = <HistoryModel>[].obs;
  late GetStorage box;
  TextEditingController searchController = TextEditingController();
  final selectedFilter = "semua".obs;

  @override
  void onInit() {
    super.onInit();
    box = GetStorage();
    change(null, status: RxStatus.empty());
    loadHistory();
  }

  ///load the history from api
  Future<void> loadHistory() async {
    change(null, status: RxStatus.loading());
    await HistoryProvider().loadHistory(box.read(Routes.TOKEN) as String).then(
      (value) => {
        list = value,
        change(null, status: RxStatus.success()),
      },
      onError: (err) {
        change(err, status: RxStatus.error());
      },
    );
  }

  void searchHistory(String name) {
    List<HistoryModel> filteredList = [];
    if (name == "") {
      filteredList = list;
    } else {
      filteredList = list
          .where((element) =>
              element.namaJalan!.toLowerCase().contains(name.toLowerCase()))
          .toList();
    }
    foundList.value = filteredList;
  }

  void sortHistory(String filter) {
    List<HistoryModel> filteredList = list;
    if (filter == "semua") {
      filteredList = list;
    } else if (filter == "terbaru") {
      filteredList.sort((a, b) => timeAgoSinceDate(a.createdAt!)
          .compareTo(timeAgoSinceDate(b.createdAt!)));
    } else if (filter == "terlama") {
      filteredList.sort((a, b) => timeAgoSinceDate(a.createdAt!)
          .compareTo(timeAgoSinceDate(b.createdAt!)));
      filteredList = filteredList.reversed.toList();
    } else if (filter == "status") {
      filteredList
          .sort((a, b) => a.statusPengaduan!.compareTo(b.statusPengaduan!));
    } else if (filter == "jenis") {
      filteredList.sort((a, b) => a.tipePengaduan!.compareTo(b.tipePengaduan!));
    }
    foundList.value = filteredList;
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "NOT_YET_VERIFIED":
        return Colors.orange;
      case "ON_PROGRESS":
        return Colors.purple;
      case "COMPLETED":
        return Colors.green;
      case "REFUSED":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
