// ignore_for_file: lines_longer_than_80_chars

import 'package:drainit_flutter/app/components/constant.dart';
import 'package:drainit_flutter/app/modules/login/models/user_model.dart';
import 'package:drainit_flutter/app/modules/login/providers/user_provider.dart';
import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController with StateMixin<LoginReponse> {
  final isPasswordHidden = true.obs;
  late TextEditingController myControllerEmail;
  late TextEditingController myControllerPassword;
  late GetStorage box;
  @override
  void onInit() {
    super.onInit();
    FlutterNativeSplash.remove();
    box = GetStorage();

    //on init state set that state is empty
    change(null, status: RxStatus.empty());
    myControllerEmail = TextEditingController();
    myControllerPassword = TextEditingController();
    printInfo(info: 'onInit');
  }

  Future<void> userLogin(String email, String password) async {
    final dataLogin = {
      'email': email,
      'password': password,
    };
    //when user call this function, change the state to loading
    change(
      null,
      status: RxStatus.loading(),
    );
    //call this function to check user login with given data
    UserProvider().loginUser(dataLogin).then(
      (resp) => {
        //if the result is ok then change the status to success and move the page to home page
        change(
          resp,
          status: RxStatus.success(),
        ),
        box.write(Routes.TOKEN, resp.accessToken),
        box.write(Routes.USER_ID, resp.user?.id),

        Get.offAllNamed(Routes.HOMEPAGE, arguments: 'login')
      },
      //if error happens then catch the error and show to user
      onError: (err) {
        Get.bottomSheet(
          Container(
            key: const Key('error'),
            height: Get.height / 2.7,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SvgPicture.asset(
                  'assets/svg/il_err_404.svg',
                  height: 200,
                  width: 200,
                ),
                Text(
                  'Error ketika login : $err',
                  style: const TextStyle(
                    fontSize: 16,
                    color: kTextPurple,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        );
        change(
          null,
          status: RxStatus.error('Error occured : $err'),
        );
      },
    );
  }

  void loginInformationEmpty() {
    Get.bottomSheet(
      Container(
        key: const Key('error'),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/svg/not_found.svg',
              height: Get.height * 0.3,
            ),
            const Text(
              'Email dan Password tidak boleh kosong',
              style: TextStyle(
                fontSize: 16,
                color: kTextPurple,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
