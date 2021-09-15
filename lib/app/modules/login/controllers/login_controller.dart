import 'package:drainit_flutter/app/components/constant.dart';
import 'package:drainit_flutter/app/modules/login/providers/user_provider.dart';
import 'package:drainit_flutter/app/modules/login/models/user_model.dart';
import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    box = GetStorage();

    //on init state set that state is empty
    change(null, status: RxStatus.empty());
    myControllerEmail = TextEditingController();
    myControllerPassword = TextEditingController();
  }

  bool isLoggedIn() => box.hasData(Routes.TOKEN);

  void userLogin(String email, String password) async {
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

        Get.offAllNamed(Routes.HOME, arguments: "login")
      },
      //if error happens then catch the error and show to user
      onError: (err) {
        Get.bottomSheet(
          Container(
            color: white,
            child: Center(
              child: Text("error ketika login $err"),
            ),
          ),
        );
        change(
          null,
          status: RxStatus.error("Error occured : " + err.toString()),
        );
      },
    );
  }

  @override
  void onClose() {
    myControllerPassword.dispose();
    myControllerEmail.dispose();
    super.onClose();
  }

  @override
  void onReady() {
    super.onReady();
    if (isLoggedIn()) Get.offAllNamed(Routes.HOME);
  }
}
