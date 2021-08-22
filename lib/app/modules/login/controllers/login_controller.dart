import 'package:drainit_flutter/app/modules/login/providers/user_provider.dart';
import 'package:drainit_flutter/app/modules/login/user_model.dart';
import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController with StateMixin<LoginReponse> {
  var isPasswordHidden = true.obs;
  late TextEditingController myControllerEmail;
  late TextEditingController myControllerPassword;

  @override
  void onInit() {
    super.onInit();
    //on init state set that state is empty
    change(null, status: RxStatus.empty());
    myControllerEmail = TextEditingController();
    myControllerPassword = TextEditingController();
  }

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
        Get.offAllNamed(Routes.HOME)
      },
      //if error happens then catch the error and show to user
      onError: (err) {
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
}
