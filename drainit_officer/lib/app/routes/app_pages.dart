import 'package:get/get.dart';

import '../modules/detail/bindings/detail_binding.dart';
import '../modules/detail/bindings/update_laporan_binding.dart';
import '../modules/detail/views/detail_view.dart';
import '../modules/detail/views/update_laporan_view.dart';
import '../modules/done_reports/bindings/done_reports_binding.dart';
import '../modules/done_reports/views/done_reports_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/homepage/bindings/homepage_binding.dart';
import '../modules/homepage/views/homepage_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/maps/bindings/maps_binding.dart';
import '../modules/maps/views/maps_view.dart';
import '../modules/new_reports/bindings/new_reports_binding.dart';
import '../modules/new_reports/views/new_reports_view.dart';
import '../modules/processed_reports/bindings/processed_reports_binding.dart';
import '../modules/processed_reports/views/processed_reports_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/splashscreen/bindings/splashscreen_binding.dart';
import '../modules/splashscreen/views/splashscreen_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASHSCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SPLASHSCREEN,
      page: () => SplashscreenView(),
      binding: SplashscreenBinding(),
    ),
    GetPage(
      name: _Paths.NEW_REPORTS,
      page: () => NewReportsView(),
      binding: NewReportsBinding(),
    ),
    GetPage(
      name: _Paths.PROCESSED_REPORTS,
      page: () => ProcessedReportsView(),
      binding: ProcessedReportsBinding(),
    ),
    GetPage(
      name: _Paths.DONE_REPORTS,
      page: () => DoneReportsView(),
      binding: DoneReportsBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL,
      page: () => DetailView(),
      binding: DetailBinding(),
    ),
    GetPage(
      name: _Paths.MAPS,
      page: () => MapsView(),
      binding: MapsBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE_LAPORAN,
      page: () => UpdateLaporanView(),
      binding: UpdateLaporanBinding(),
    ),
    GetPage(
      name: _Paths.HOMEPAGE,
      page: () => HomepageView(),
      binding: HomepageBinding(),
    ),
  ];
}
