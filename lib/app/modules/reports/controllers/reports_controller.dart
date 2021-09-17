import 'package:get/get.dart';

class ReportsController extends GetxController {
  final count = 0.obs;
  // ignore: prefer_single_quotes
  final latlng = "".obs;

  @override
  void onClose() {}
  void increment() => count.value++;
}
