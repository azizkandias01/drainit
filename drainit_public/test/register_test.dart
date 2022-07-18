import 'package:drainit_flutter/app/modules/register/providers/register_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final registerController = RegisterProvider();
  test("Check Public Community Register with valid Data should success",
      () async {
    final registerData = {
      "nama": "Aziz ",
      "telepon": "0812331231",
      "alamat": "Jalan Bukit Sari no.9a",
      "email": "zeekands@gmail.com",
      "password": "aziz1234",
      "tanggal_lahir": "2001-07-01"
    };
    final response = await registerController.registerUser(registerData);
    expect(response, "success register");
  });
  test("Check Public Community Register with null Data should unsuccess",
      () async {
    try {
      final registerData = {
        "email": null,
        "password": null,
        "password_confirmation": null,
        "nama": null,
        "no_hp": null,
        "foto": null,
        "alamat": null
      };
      final response = await registerController.registerUser(registerData);
    } catch (e) {
      expect(e.toString(), "400");
    }
  });
}
