import 'package:drainit_petugas/app/utils/text_poppins.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splashscreen_controller.dart';

class SplashscreenView extends GetView<SplashscreenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextPoppinsBold(text: "Drainit",fontSize: 50,),
      ),
    );
  }
}
