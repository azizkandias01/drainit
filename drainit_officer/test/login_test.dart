import 'package:drainit_petugas/app/modules/login/providers/login_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final loginProvider = LoginProvider();
  test('Login test with valid data', () async {
    final loginData = {"email": "petugas@gmail.com", "password": "petugas"};
    final response = await loginProvider.loginPetugas(loginData);
    // expect(response.user, isNotNull);
  });
  //test login with invalid data
  test('Login test with invalid data', () async {
    try {
      final loginData = {"email": "petugas@gmail.com", "password": "petugas1"};
      final response = await loginProvider.loginPetugas(loginData);
    } catch (e) {
      expect(e.toString(), "401");
    }
  });
  test("api login with empty input should unsuccess", () async {
    try {
      final dataLogin = {
        'email': "",
        'password': "",
      };
      final response = await loginProvider.loginPetugas(dataLogin);
    } catch (e) {
      expect(e.toString(), "302");
    }
  });
}
