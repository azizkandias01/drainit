import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  final GetStorage box = GetStorage();
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          "error occured : check console!",
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  };
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(
    ScreenUtilInit(
      designSize: const Size(414, 896),
      builder: (context) => GetMaterialApp(
        title: "Application",
        initialRoute:
            box.hasData(Routes.TOKEN) ? Routes.HOMEPAGE : Routes.LOGIN,
        getPages: AppPages.routes,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          backgroundColor: Colors.white,
          fontFamily: "Raleway",
          bottomAppBarTheme: const BottomAppBarTheme(
            color: Colors.white,
            elevation: 0,
          ),
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
              statusBarColor: Colors.transparent,
            ),
            titleTextStyle: TextStyle(
              fontSize: ScreenUtil().setSp(20),
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            backgroundColor: Colors.white, // 2
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
          ),
        ),
      ),
    ),
  );
}
