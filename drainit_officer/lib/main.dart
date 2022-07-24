import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/routes/app_pages.dart';

void main() async {
  await GetStorage.init();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  GetStorage box = GetStorage();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
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
  runApp(
    ScreenUtilInit(
      designSize: Size(375, 812),
      builder: (ctx, _) => GetMaterialApp(
        title: "Drainit Petugas",
        initialRoute:
            box.read(Routes.TOKEN) != null ? Routes.HOMEPAGE : Routes.LOGIN,
        getPages: AppPages.routes,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            elevation: 0,
            titleTextStyle: TextStyle(
              color: Colors.black,
            ),
            iconTheme: IconThemeData(color: Colors.black),
            systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
              statusBarColor: Colors.transparent,
            ),
            backgroundColor: Colors.white, // 2
          ),
        ),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}
