import 'package:drainit_petugas/app/modules/detail/providers/detail_provider.dart';
import 'package:drainit_petugas/app/modules/detail/providers/update_laporan_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final detailProvider = DetailProvider();
  final updateProvider = UpdateLaporanProvider();
  test('loadDetailReport', () async {
    final response = await detailProvider.getDetail(
        "1350f84d-3f7d-4864-985a-b2fbba967c7c",
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjBmODY5NDMyLThlNjEtNDk1Yi05YTY4LTFkZDRhNzEzN2NlOCIsImVtYWlsIjoiam9rb0BnbWFpbC5jb20iLCJyb2xlIjoiUGV0dWdhcyIsImV4cCI6MTY1ODgyOTUzNH0.fXj5oWmpiL6DKZ5oU3c5a3Rg3I2IRoXbSGOiKTpyo6s");
    expect(response?.id, isNotNull);
  });
  test('loadFeedback', () async {
    final response = await detailProvider.getDetail(
        "1350f84d-3f7d-4864-985a-b2fbba967c7c",
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjBmODY5NDMyLThlNjEtNDk1Yi05YTY4LTFkZDRhNzEzN2NlOCIsImVtYWlsIjoiam9rb0BnbWFpbC5jb20iLCJyb2xlIjoiUGV0dWdhcyIsImV4cCI6MTY1ODgyOTUzNH0.fXj5oWmpiL6DKZ5oU3c5a3Rg3I2IRoXbSGOiKTpyo6s");
    expect(response?.id, isNotNull);
  });
  test('loadUpdateReport', () async {
    final response = await updateProvider.listUpdate(
      "1350f84d-3f7d-4864-985a-b2fbba967c7c",
    );
    expect(response, isNotNull);
  });
}
