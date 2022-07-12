import 'package:drainit_flutter/app/modules/login/providers/user_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("api login should success", () async {
    final login = UserProvider();
    final dataLogin = {
      'email': "rina@gmail.com",
      'password': "12345678",
    };
    final response = await login.loginUser(dataLogin);
    expect(response.idMasyarakat, isNotNull);
  });
  test("api login with wrong username and password should unsuccess", () async {
    try {
      final login = UserProvider();
      final dataLogin = {
        'email': "aziz@gmail.com",
        'password': "1234567",
      };
      final response = await login.loginUser(dataLogin);
    } catch (e) {
      expect(e.toString(), "500");
    }
  });
  test("api login with empty input should unsuccess", () async {
    try {
      final login = UserProvider();
      final dataLogin = {
        'email': "",
        'password': "",
      };
      final response = await login.loginUser(dataLogin);
    } catch (e) {
      expect(e.toString(), "400");
    }
  });
}
