import 'package:drainit_petugas/app/modules/profile/providers/profile_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final profileProvider = ProfileProvider();
  test('loadProfile', () async {
    final response = await profileProvider.getProfile(
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjBmODY5NDMyLThlNjEtNDk1Yi05YTY4LTFkZDRhNzEzN2NlOCIsImVtYWlsIjoiam9rb0BnbWFpbC5jb20iLCJyb2xlIjoiUGV0dWdhcyIsImV4cCI6MTY1ODgyOTUzNH0.fXj5oWmpiL6DKZ5oU3c5a3Rg3I2IRoXbSGOiKTpyo6s");
    expect(response, isNotNull);
  });
}
